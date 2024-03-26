import 'package:charum/utils/colors.dart';
import 'package:charum/views/auth/login.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key, required this.size});
  final Size size;

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: widget.size.height * .025,
                      horizontal: widget.size.width * .05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: widget.size.height * .025,
                      ),
                      _imageSlider(),
                      Flexible(
                        flex: 2,
                        child: Container(),
                      ),
                      _imageIndicator(),
                      SizedBox(
                        height: widget.size.height * .03,
                      ),
                      _bottomButton(context),
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

  _imageSlider() {
    return SizedBox(
      height: widget.size.height * 0.7,
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
                height: widget.size.height * .035,
              ),
              Text(
                text1[pagePosition],
                style: TextStyle(
                  color: greenCharum,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: widget.size.height * .01,
              ),
              Text(
                text2[pagePosition],
                textAlign: TextAlign.center,
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(3, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: activePage == index ? greenCharum : Colors.black26,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ),
    );
  }

  _bottomButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 300),
        crossFadeState: activePage == 2
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: _lastPage(context),
        secondChild: _previousPage(),
      ),
    );
  }

  _previousPage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _skipButton(),
        _nextButton(),
      ],
    );
  }

  _nextButton() {
    return GestureDetector(
      onTap: () {
        if (activePage == 0) {
          _actionButton(1);
        } else {
          _actionButton(2);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: widget.size.width * .45,
        height: widget.size.height * .07,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: ShapeDecoration(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          color: greenCharum,
        ),
        child: const Text(
          'Next',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  _skipButton() {
    return Container(
      alignment: Alignment.center,
      width: widget.size.width * .4,
      height: widget.size.height * .07,
      child: TextButton(
        onPressed: () {
          if (activePage == 0) {
            _pageController.jumpToPage(2);
            setState(() {
              activePage = 2;
            });
          } else {
            _actionButton(2);
          }
        },
        child: Text(
          'Skip',
          style: TextStyle(color: greenCharum),
        ),
      ),
    );
  }

  _actionButton(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    setState(() {
      activePage = page;
    });
  }

  _lastPage(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const Login(),
        ),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
        width: widget.size.width * .9,
        height: widget.size.height * .07,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: ShapeDecoration(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          color: greenCharum,
        ),
        child: const Text(
          'Get Started',
          style: TextStyle(color: Colors.white),
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
}
