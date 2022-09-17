// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/base_view_model.dart';
import 'package:restaurant_app/routes.dart';
import 'package:restaurant_app/style/colors.style.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
// screen height
    final double screenWidth = MediaQuery.of(context).size.width;

    return MVVM<SplashScreenViewModel>.builder(
      viewModel: SplashScreenViewModel(screenWidth),
      viewBuilder: (context, vm) {
        return Scaffold(
          body: AnimatedContainer(
            width: vm.scrHeight,
            duration: const Duration(milliseconds: 1000),
            child: SafeArea(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: appColor.quaternaryColor,
                    ),
                    child: Image.asset(
                      'assets/img/logo.png',
                      centerSlice: Rect.fromLTRB(
                        0,
                        0,
                        0,
                        0,
                      ),
                      width: 150,
                      height: 150,
                      colorBlendMode: BlendMode.darken,
                      filterQuality: FilterQuality.high,
                      scale: 0.5,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.9),
                        ],
                      ),
                    ),
                  ),

                  // content
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/img/logo.png',
                                width: 150,
                                height: 150,
                                colorBlendMode: BlendMode.darken,
                                filterQuality: FilterQuality.high,
                                scale: 0.5,
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                  text: 'Nongs',
                                  style: GoogleFonts.signikaNegative(
                                    fontSize: 50,
                                    color: appColor.quinaryTextColor,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black,
                                        blurRadius: 10,
                                        offset: Offset(5, 5),
                                      ),
                                    ],
                                    wordSpacing: 3,
                                  ),
                                ),
                                TextSpan(
                                  text: 'kuy',
                                  style: GoogleFonts.acme(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black,
                                        blurRadius: 10,
                                        offset: Offset(5, 5),
                                      ),
                                    ],
                                    wordSpacing: 3,
                                  ),
                                ),
                              ])),

                              SizedBox(height: 20),
                              // tagline
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  'Nongsky dulssss',
                                  style: GoogleFonts.acme(
                                    color: appColor.tertiaryTextColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                    decorationThickness: 1,
                                    letterSpacing: 3,
                                    shadows: [
                                      Shadow(
                                        color: Colors.grey,
                                        blurRadius: 5,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                    wordSpacing: 3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                        SizedBox(height: 45),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SplashScreenViewModel extends ViewModel with BaseViewModel {
  bool isLogin = false;
  double scrHeight = 0;

  SplashScreenViewModel(double screenHeight) {
    scrHeight = screenHeight;
  }

  @override
  void init() async {
    super.init();
    await getInstances();

    // delay the animation
    await Future.delayed(Duration(seconds: 2), () {
      scrHeight = 0;
      notifyListeners();
      // check if logged in
      move(context, Routes.homePageScreen, replace: true);
    });

    notifyListeners();
  }
}
