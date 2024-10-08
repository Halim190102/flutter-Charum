import 'package:charum/utils/colors.dart';
import 'package:charum/utils/const.dart';
import 'package:charum/utils/container.dart';
import 'package:charum/utils/text.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key, e});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int activePage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Center(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * .025,
                    horizontal: size.width * .05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * .025,
                      ),
                      _imageSlider(size),
                      Flexible(
                        flex: 2,
                        child: Container(),
                      ),
                      _imageIndicator(),
                      SizedBox(
                        height: size.height * .03,
                      ),
                      _bottomButton(context, size),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _imageSlider(Size size) {
    return SizedBox(
      height: size.height * 0.7,
      child: PageView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        pageSnapping: true,
        controller: _pageController,
        onPageChanged: (page) {
          setState(() => activePage = page);
        },
        itemBuilder: (context, pagePosition) {
          return Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.asset(
                    'assets/welcome/background-welcome.png',
                    width: 280,
                  ),
                  Image.asset(
                    'assets/welcome/welcome-${pagePosition + 1}.png',
                    height: 330,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * .035,
              ),
              textUtils(
                text: text1[pagePosition],
                color: greenCharum,
                weight: FontWeight.bold,
                size: 20,
              ),
              SizedBox(
                height: size.height * .01,
              ),
              textUtils(
                text: text2[pagePosition],
                align: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }

  _imageIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: containerUtils(
        duration: Duration(milliseconds: time),
        curve: Curves.easeInOut,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(3, (index) {
            return containerUtils(
              duration: Duration(milliseconds: time),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
              width: 8,
              height: 8,
              color: activePage == index ? greenCharum : black26,
              shape: BoxShape.circle,
            );
          }),
        ),
      ),
    );
  }

  List<String> text1 = [
    'Search Thread Whatever You Like',
    'Discover Space Group',
    'Share Your Experience',
  ];
  List<String> text2 = [
    "Confused and want to talk about something but\ndon't know where to go? You can talk to other\npeople on Charum from anywhere and at any time.",
    "You no longer need to be confused looking for\nthreads on a particular topic, with Space Group you\ncan search for threads on the topic you want.",
    "You can gain a lot of insight from existing\ndiscussions using the Charum. What are you\nwaiting for? Come on over and join us!",
  ];

  _bottomButton(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedCrossFade(
        duration: Duration(milliseconds: time),
        crossFadeState: activePage == 2
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: _lastPage(context, size),
        secondChild: _previousPage(size),
      ),
    );
  }

  _previousPage(Size size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _skipButton(size),
        _nextButton(size),
      ],
    );
  }

  _nextButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (activePage == 0) {
          _actionButton(1);
        } else {
          _actionButton(2);
        }
      },
      child: containerUtils(
        duration: Duration(milliseconds: time),
        curve: Curves.easeInOut,
        width: size.width * .45,
        height: size.height * .07,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        borderRadius: 10,
        color: greenCharum,
        child: textUtils(
          text: 'Next',
          color: white,
        ),
      ),
    );
  }

  _skipButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (activePage == 0) {
          _pageController.jumpToPage(2);
          setState(() {
            activePage = 2;
          });
        } else {
          _actionButton(2);
        }
      },
      child: containerUtils(
        alignment: Alignment.center,
        width: size.width * .4,
        height: size.height * .07,
        child: textUtils(
          text: 'Skip',
          color: greenCharum,
        ),
      ),
    );
  }

  _actionButton(int page) {
    _pageController.animateToPage(
      page,
      duration: Duration(milliseconds: time),
      curve: Curves.ease,
    );
    setState(() {
      activePage = page;
    });
  }

  _lastPage(BuildContext context, Size size) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        '/login',
      ),
      child: containerUtils(
        duration: Duration(milliseconds: time),
        curve: Curves.easeInOutCubic,
        width: size.width * .9,
        height: size.height * .07,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        borderRadius: 10,
        color: greenCharum,
        child: textUtils(
          text: 'Get Started',
          color: white,
        ),
      ),
    );
  }
}
