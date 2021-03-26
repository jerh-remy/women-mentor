import 'package:flutter/material.dart';
import 'package:women_mentor/app/landing/explore/bookSession/add_cv_view.dart';
import 'package:women_mentor/app/landing/explore/bookSession/back_button.dart';
import 'package:women_mentor/app/landing/explore/bookSession/uploaded_cv.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/routing/cupertino_tab_view_router.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/custom_text_button.dart';
import 'package:women_mentor/widgets/shared/page_title.dart';

class BookingConfirmationView extends StatelessWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).pushNamed(
      CupertinoTabViewRoutes.confirmBookingPage,
      // arguments: job,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  '15 March 12:00 - 13:00',
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
                  'Google Meet',
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
                Text(
                  'Career Advice, General Chat',
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
                  child: Text('SUBMIT REQUEST'),
                  onPressed: () {}),
              SizedBox(height: 36),
              // Opacity(
              //   opacity: 0,
              //   child: CustomTextButton(
              //       width: MediaQuery.of(context).size.width * 0.9,
              //       child: Text('SAVE AS DRAFT'),
              //       onPressed: () {}),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
