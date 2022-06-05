import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.decelerate);
    animationController.forward();
    animationController.addListener(() {
      setState(() {});
      print(animationController.value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/bck2.jpg'),fit: BoxFit.fill,opacity: 0.5)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/circular.png'),
                      height: 70,
                    ),
                  ),
                  // Text(
                  //   'Flash Chat',
                  //   style: TextStyle(
                  //     fontSize: 45.0,
                  //     fontWeight: FontWeight.w900,
                  //   ),
                  // ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Chat Inc.',
                        textStyle: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                        speed: Duration(milliseconds: 150),
                      ),
                    ],
                    repeatForever: true,
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              RoundedButton(
                color: Color(0xff3e4785),
                title: 'Log In',
                onPres: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                  //Go to login screen.
                },
              ),
              RoundedButton(
                color: Color(0xff3e4785),
                title: 'Register',
                onPres: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                  //Go to registration screen.
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
