import 'package:flutter/material.dart';
import 'package:women_mentor/app/onboarding/hobbies_view.dart';
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

  @override
  Widget build(BuildContext context) {
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
                  children: [
                    TechInterestsView(),
                    HobbiesView(),
                    SelectRoleView()
                  ],
                  onPageChanged: (pageNumber) => setPageNumber(pageNumber),
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator()),
              SizedBox(height: 46.0),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
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
