import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:women_mentor/app/landing/explore/bookSession/back_button.dart';
import 'package:women_mentor/app/landing/explore/bookSession/book_session_view_model.dart';
import 'package:women_mentor/app/landing/explore/bookSession/uploaded_cv.dart';
import 'package:women_mentor/app/top_level_providers.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/constants/utilities.dart';
import 'package:women_mentor/routing/app_router.gr.dart';
import 'package:women_mentor/routing/cupertino_tab_view_router.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/page_title.dart';
import 'package:auto_route/auto_route.dart';

class BookingConfirmationView extends ConsumerWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).pushNamed(
      CupertinoTabViewRoutes.confirmBookingPage,
    );
  }

  Future<void> _createBookingRequest(BuildContext context,
      BookSessionViewModel bookSessionViewModel, String userId) async {
    try {
      await bookSessionViewModel.createBookingRequest(menteeId: userId);
      Utilities.showSuccessDialog(
          context: context,
          successMessage: 'Booking request successful!',
          onButtonPressed: () {
            context.router.push(StartUpRoute());
          });
    } catch (e) {
      Utilities.showErrorDialog(context: context, exception: e);
    }
  }

  String _getPreferredCallProviderString(CallProvider callProvider) {
    final String callProviderString;
    switch (callProvider) {
      case CallProvider.meet:
        callProviderString = 'Google Meet';
        break;
      case CallProvider.zoom:
        callProviderString = 'Zoom';
        break;
      case CallProvider.skype:
        callProviderString = 'Skype';
        break;
      default:
        callProviderString = 'Zoom';
    }
    return callProviderString;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bookingViewModel =
        watch<BookSessionViewModel>(bookSessionViewModelProvider);
    return Scaffold(
      appBar: BackButtonAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageTitle(text: 'Confirm details'),
                SizedBox(height: 48),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Date',
                    style: TextStyle(
                      color: CustomColors.appColorOrange,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${Utilities.dateFormat2(bookingViewModel.meetingDate!)}\t 10:00 - 11:30',
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.2,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Location',
                    style: TextStyle(
                      color: CustomColors.appColorOrange,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  _getPreferredCallProviderString(
                      bookingViewModel.callProvider),
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.2,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Agenda',
                    style: TextStyle(
                      color: CustomColors.appColorOrange,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        bookingViewModel.meetingPurpose.join(", "),
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 0.2,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Share your CV',
                    style: TextStyle(
                      color: CustomColors.appColorOrange,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                UploadedCV(
                  height: 80,
                  onTap: () {},
                ),
              ],
            ),
          ),
          Column(
            children: [
              CustomElevatedButton(
                width: MediaQuery.of(context).size.width * 0.9,
                child: bookingViewModel.isLoading
                    ? SpinKitCircle(
                        color: Colors.white,
                        size: 28,
                      )
                    : Text('SUBMIT REQUEST'),
                onPressed: () {
                  final firebaseAuth = watch(firebaseAuthProvider);
                  final user = firebaseAuth.currentUser!;
                  _createBookingRequest(context, bookingViewModel, user.uid);
                },
              ),
              SizedBox(height: 36),
            ],
          )
        ],
      ),
    );
  }
}
