import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:women_mentor/app/landing/explore/bookSession/back_button.dart';
import 'package:women_mentor/app/landing/explore/bookSession/book_session_view_model.dart';
import 'package:women_mentor/app/landing/explore/bookSession/select_meeting_purpose_view.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/routing/cupertino_tab_view_router.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/custom_text_button.dart';
import 'package:women_mentor/widgets/shared/page_title.dart';
import 'package:women_mentor/widgets/shared/social_sign_in_button.dart';

class SelectCallProviderView extends ConsumerWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).pushNamed(
      CupertinoTabViewRoutes.selectCallProviderPage,
      // arguments: job,
    );
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
            child: PageTitle(text: 'How do you want to chat?'),
          ),
          Column(
            children: [
              CallProviderListTile(
                activeColor: Colors.white,
                groupValue: bookingViewModel.callProvider,
                icon: Ionicons.videocam,
                iconColor: Colors.white,
                text: 'ZOOM',
                value: CallProvider.zoom,
                color: Color(0xff517BD9),
                onChanged: (callProvider) {
                  bookingViewModel
                      .setCallProvider(callProvider as CallProvider);
                },
              ),
              const SizedBox(height: 20),
              CallProviderListTile(
                activeColor: Colors.black54,
                groupValue: bookingViewModel.callProvider,
                icon: FontAwesomeIcons.google,
                iconColor: Colors.black54,
                text: 'GOOGLE MEET',
                value: CallProvider.meet,
                color: Color(0xffF7F7F7),
                onChanged: (callProvider) {
                  bookingViewModel
                      .setCallProvider(callProvider as CallProvider);
                },
              ),
              const SizedBox(height: 20),
              CallProviderListTile(
                activeColor: Colors.white,
                groupValue: bookingViewModel.callProvider,
                icon: FontAwesomeIcons.skype,
                iconColor: Colors.white,
                text: 'SKYPE',
                value: CallProvider.skype,
                color: Color(0xff18A3CC),
                onChanged: (callProvider) {
                  bookingViewModel
                      .setCallProvider(callProvider as CallProvider);
                },
              ),
              const SizedBox(height: 20),
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

class CallProviderListTile extends StatelessWidget {
  const CallProviderListTile({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.activeColor,
    this.onChanged,
    required this.text,
    required this.icon,
    required this.iconColor,
    required this.color,
  }) : super(key: key);

  final CallProvider value;
  final CallProvider groupValue;
  final Color activeColor;
  final Function(CallProvider?)? onChanged;
  final String text;
  final IconData icon;
  final Color iconColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.grey.shade100,
      elevation: 4,
      shadowColor: Colors.grey.withOpacity(0.4),
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: color,
        ),
        child: RadioListTile(
          value: value,
          groupValue: groupValue,
          activeColor: activeColor,
          controlAffinity: ListTileControlAffinity.trailing,
          dense: true,
          onChanged: onChanged,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: iconColor,
                  size: value == CallProvider.meet ? 15.0 : 17.0,
                ),
                SizedBox(width: 12),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 15,
                        color: iconColor,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
