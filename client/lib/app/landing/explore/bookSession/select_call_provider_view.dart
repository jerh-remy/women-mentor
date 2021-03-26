import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:women_mentor/app/landing/explore/bookSession/back_button.dart';
import 'package:women_mentor/app/landing/explore/bookSession/select_meeting_purpose_view.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/routing/cupertino_tab_view_router.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/custom_text_button.dart';
import 'package:women_mentor/widgets/shared/page_title.dart';
import 'package:women_mentor/widgets/shared/social_sign_in_button.dart';

class SelectCallProviderView extends StatelessWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).pushNamed(
      CupertinoTabViewRoutes.selectCallProviderPage,
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
            child: PageTitle(text: 'How do you want to chat?'),
          ),
          Column(
            children: [
              SocialSignInButton(
                onPressed: () {},
                icon: Ionicons.videocam,
                text: 'ZOOM',
                textColor: Colors.white,
                color: Color(0xff517BD9),
                iconColor: Colors.white,
              ),
              const SizedBox(height: 20),
              SocialSignInButton(
                onPressed: () {},
                icon: FontAwesomeIcons.google,
                text: 'GOOGLE MEET',
                color: Color(0xffF7F7F7),
                iconColor: Colors.black87,
              ),
              const SizedBox(height: 20),
              SocialSignInButton(
                onPressed: () {},
                icon: FontAwesomeIcons.skype,
                text: 'SKYPE',
                textColor: Colors.white,
                color: Color(0xff18A3CC),
                iconColor: Colors.white,
              ),
            ],
          ),
          Column(
            children: [
              CustomElevatedButton(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text('NEXT'),
                  onPressed: () {
                    SelectMeetingPurposeView.show(context);
                  }),
              SizedBox(height: 16),
              CustomTextButton(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text('DECIDE LATER'),
                  onPressed: () {
                    SelectMeetingPurposeView.show(context);
                  }),
              SizedBox(height: 24),
            ],
          )
        ],
      ),
    );
  }
}
