// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM<SplashScreenViewModel>.builder(
      viewModel: SplashScreenViewModel(),
      viewBuilder: (context, vm) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colorStyle.fourth,
                  ),
                  child: Image.asset(
                    'assets/img/logo.png',
                    centerSlice:  Rect.fromLTRB(
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
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),

                // content
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Container(
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
                                  text: 'GO',
                                  style: TextStyle(
                                    fontSize: 50,
                                    color: colorStyle.primary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
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
                                  text: 'rengan',
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
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
                              ])),

                              SizedBox(height: 20),
                              // tagline
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'The best way to taste Indonesian food',
                                  style: TextStyle(
                                    color: colorStyle.primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'sans-serif',
                                    fontStyle: FontStyle.italic,
                                    decorationThickness: 1,
                                    letterSpacing: 3,
                                    shadows: [
                                      Shadow(
                                        color: Colors.white,
                                        blurRadius: 10,
                                        offset: Offset(5, 5),
                                      ),
                                    ],
                                    wordSpacing: 3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // loader

                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                        SizedBox(height: 45),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SplashScreenViewModel extends ViewModel with BaseViewModel {
  bool isLogin = false;
  double margin = 0;

  @override
  void init() async {
    super.init();
    await getInstances();

    isLogin = sharedPref?.getBool(argLoggedIn) ?? false;

    // delay the animation
    Future.delayed(Duration(milliseconds: 2500), () {
      margin = MediaQuery.of(context).size.width;
      notifyListeners();
      // check if logged in
      if (isLogin) {
        // delete all navigation stack
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        move(context, Routes.intro, replace: true);
      }
    });

    notifyListeners();
  }
}
