import 'package:flutter/material.dart';
import 'package:women_mentor/app/onboarding/hobbies_view.dart';
import 'package:women_mentor/app/onboarding/mentor_availability_view.dart';
import 'package:women_mentor/app/onboarding/mentor_profile_setup_view.dart';
import 'package:women_mentor/app/onboarding/select_role_view.dart';
import 'package:women_mentor/app/onboarding/tech_interests_view.dart';
import 'package:women_mentor/widgets/custom_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageNumber = 0;
  bool _isMentorOnboarding = false;

  goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      SelectRoleView(
        onTap: (isMentorOnboarding) {
          print(isMentorOnboarding);
          setState(() {
            _isMentorOnboarding = isMentorOnboarding;
          });
          goToNextPage();
        },
      ),
      TechInterestsView(
        onTap: () {
          goToNextPage();
        },
      ),
      HobbiesView(),
      if (_isMentorOnboarding) ...[
        MentorProfileSetupView(
          onTap: () {
            goToNextPage();
          },
        ),
        MentorAvailabilityView(
          onTap: () {
            print('done');
          },
        )
      ]
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  pageSnapping: true,
                  controller: _pageController,
                  children: _pages,
                  onPageChanged: (pageNumber) => setPageNumber(pageNumber),
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(_pages.length)),
              SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator(int length) {
    List<Widget> list = [];
    for (int i = 0; i < length; i++) {
      list.add(i == _currentPageNumber
          ? PageIndicator(
              isActive: true,
            )
          : PageIndicator(isActive: false));
    }
    return list;
  }

  setPageNumber(int pageNumber) {
    setState(() {
      _currentPageNumber = pageNumber;
    });
  }
}
