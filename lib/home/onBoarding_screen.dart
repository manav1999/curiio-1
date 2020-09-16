
import 'package:flutter/material.dart';
import 'package:login_curiio/login_signup/sign_up_screen.dart';





class OnBoardingScreen extends StatefulWidget {
  static const routeName = '/onBoarding_screen';

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _pageController;
  int currentIndex = 0;
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  void next() {
    _pageController.nextPage(duration: _kDuration, curve: _kCurve);
  }

  void onChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  skip() {
    print("skip");
    setState(() {
      _pageController.jumpToPage(2);
      currentIndex = 2;
    });
  }

  void prev() {
    _pageController.previousPage(duration: _kDuration, curve: _kCurve);
  }

  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: onChanged,
            controller: _pageController,
            children: [
              Container(
                  margin: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        child: Text(
                          "What is Curiio ?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 242, 160, 66),
                              fontSize: 40),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        height: 250,
                        width: 300,
                        child: Image.asset(
                          'assets/images/what_and_why.png',
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Text(
                          "Curiio. A step towards progressive dialogue between parents and children answering all your curiosities through videos and blogs.",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 46, 79, 96),
                              fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )),
              Container(
                  margin: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        child: Text(
                          "Age appropriate material ",textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 242, 160, 66),
                              fontSize: 40),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),Container(
                        child: Text(
                          "Where quality meets responsibility.",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 46, 79, 96),
                              fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),SizedBox(
                        height: 30,
                      ),

                      Container(
                        height: 210,
                        width: 300,
                        child: Image.asset(
                          'assets/images/age_appropriate.png',
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Text( "We understand the need of right education at the right time and so our platform offers age appropriate slabs for every piece of info or article,which comes with age lock.  ",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 46, 79, 96),
                              fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )),
              Container(
                  margin: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                        child: Text(
                          "Interactive short videos",textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 242, 160, 66),
                              fontSize: 40),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),Container(
                        child: Text(
                          "We get it!! articles can be boring",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 46, 79, 96),
                              fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),SizedBox(
                        height: 30,
                      ),

                      Container(
                        height: 210,
                        width: 300,
                        child: Image.asset(
                          'assets/images/interactive_videos.png',
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Text( "We got it covered through some shot quirky videos, which are both interactive and interesting.",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(255, 46, 79, 96),
                              fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )),
            ],
          ),
          Positioned(
            bottom: 30,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Indicator(
                  positionIndex: 0,
                  currentIndex: currentIndex,
                ),
                SizedBox(
                  width: 10,
                ),
                Indicator(
                  positionIndex: 1,
                  currentIndex: currentIndex,
                ),
                SizedBox(
                  width: 10,
                ),
                Indicator(
                  positionIndex: 2,
                  currentIndex: currentIndex,
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 30,
              left: 18,
              child: currentIndex == 0
                  ? SizedBox(
                width: 10,
              )
                  : InkWell(
                onTap: prev,
                child: Text(
                  "Prev",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 33, 78, 139),
                  ),
                ),
              )),
          Positioned(
            bottom: 30,
            right: 18,
            child: currentIndex == 2
                ? InkWell(
              onTap: (){
                Navigator.of(context).pushReplacementNamed(SignUpScreen.routeName);
              },
              child: Text(
                "Get Started",
                style: TextStyle(
                    color: Color.fromARGB(255, 242, 160, 66),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            )
                : InkWell(
              onTap: next,
              child: Text(
                "Next",
                style: TextStyle(
                    color: Color.fromARGB(255, 33, 78, 139),
                    fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int positionIndex, currentIndex;

  const Indicator({this.positionIndex, this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 12,
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 33, 78, 139)),
          color: positionIndex == currentIndex
              ? Color.fromARGB(255, 33, 78, 139)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(100)),
    );
  }
}
