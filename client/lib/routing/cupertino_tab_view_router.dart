import 'package:flutter/cupertino.dart';
import 'package:women_mentor/app/landing/explore/bookSession/add_cv_view.dart';
import 'package:women_mentor/app/landing/explore/bookSession/confirmation_view.dart';
import 'package:women_mentor/app/landing/explore/bookSession/select_call_provider_view.dart';
import 'package:women_mentor/app/landing/explore/bookSession/select_date_view.dart';
import 'package:women_mentor/app/landing/explore/bookSession/select_meeting_purpose_view.dart';
import 'package:women_mentor/app/landing/explore/mentor_profile_view.dart';

class CupertinoTabViewRoutes {
  static const mentorProfilePage = '/mentor-profile-page';
  static const selectBookingDatePage = '/select-date-page';
  static const selectCallProviderPage = '/select-call-provider-page';
  static const selectMeetingPurposePage = '/select-meeting-purpose-page';
  static const addCVPage = '/add-CV-page';
  static const confirmBookingPage = '/confirm-booking-page';
}

class CupertinoTabViewRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CupertinoTabViewRoutes.mentorProfilePage:
        final mentorId = settings.arguments as String;
        return CupertinoPageRoute(
          builder: (_) => MentorProfileView(
            mentorId: mentorId,
          ),
          settings: settings,
          fullscreenDialog: false,
        );
      case CupertinoTabViewRoutes.selectBookingDatePage:
        // final job = settings.arguments as Job;
        return CupertinoPageRoute(
          builder: (_) => SelectDateView(),
          settings: settings,
          fullscreenDialog: false,
        );
      case CupertinoTabViewRoutes.selectCallProviderPage:
        // final job = settings.arguments as Job;
        return CupertinoPageRoute(
          builder: (_) => SelectCallProviderView(),
          settings: settings,
          fullscreenDialog: false,
        );
      case CupertinoTabViewRoutes.selectMeetingPurposePage:
        // final job = settings.arguments as Job;
        return CupertinoPageRoute(
          builder: (_) => SelectMeetingPurposeView(),
          settings: settings,
          fullscreenDialog: false,
        );
      case CupertinoTabViewRoutes.addCVPage:
        // final job = settings.arguments as Job;
        return CupertinoPageRoute(
          builder: (_) => AddCVView(),
          settings: settings,
          fullscreenDialog: false,
        );
      case CupertinoTabViewRoutes.confirmBookingPage:
        // final job = settings.arguments as Job;
        return CupertinoPageRoute(
          builder: (_) => BookingConfirmationView(),
          settings: settings,
          fullscreenDialog: false,
        );
    }
    return null;
  }
}
