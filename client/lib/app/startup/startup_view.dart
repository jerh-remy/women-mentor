import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:women_mentor/app/auth_widget.dart';
import 'package:women_mentor/app/landing/landing_view.dart';
import 'package:women_mentor/app/login/login_view.dart';
import 'package:women_mentor/app/onboarding/onboarding_view.dart';
import 'package:women_mentor/app/onboarding/onboarding_view_model.dart';
import 'package:women_mentor/app/top_level_providers.dart';
import 'package:women_mentor/models/notification.dart';
import 'dart:convert';

class StartUpView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return AuthWidget(
        nonSignedInBuilder: (_) => Consumer(
              builder: (context, watch, _) {
                return LoginView();
              },
            ),
        signedInBuilder: (_) {
          final onboardingViewModel = watch(onboardingViewModelProvider);
          print(
              'onboarding complete? ${onboardingViewModel.isOnboardingComplete}');

          // final fcmInitialMessage = watch(fcmInitialMessageProvider);
          // fcmInitialMessage.whenData((remoteMessage) {
          //   print(remoteMessage?.data);
          //   return LandingView(notificationToDisplay: remoteMessage?.data);
          // });

          // Also handle any interaction when the app is in the background via a Stream listener
          final fcmStream = watch(fcmMessageOpenedStreamProvider);
          return fcmStream.when(
              data: (rm) {
                print(rm?.data);
                if (!onboardingViewModel.isOnboardingComplete) {
                  return OnboardingView();
                }
                print(
                    'runtime type of rm is: ${rm?.data['requesterUserProfile'].runtimeType}');
                //notification details
                final requesterUserProfileMap =
                    rm?.data['requesterUserProfile'];
                final bookingDataMap = rm?.data['bookingData'];
                final RequesterUserProfile userProfile =
                    RequesterUserProfile.fromMap(
                        json.decode(requesterUserProfileMap));
                print(userProfile.firstName);

                final BookingData bookingData =
                    BookingData.fromMap(json.decode(bookingDataMap));
                print(bookingData.preferredCallProvider);

                final String bookingId = rm?.data['bookingId'];

                final notification = AppNotification(
                    bookingData: bookingData,
                    bookingId: bookingId,
                    requesterUserProfile: userProfile);
                return LandingView(
                    key: UniqueKey(), notificationToDisplay: notification);
              },
              loading: () => LandingView(),
              error: (_, __) => LandingView());
        });
  }
}
