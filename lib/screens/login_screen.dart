import 'package:flash_chat/screens/room_selector.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flash_chat/components/Storage.dart';
import 'package:flash_chat/components/Finger.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool modalProgress = false;
  late String email, password;
  final _auth = FirebaseAuth.instance;
  SecureStorage secureStorage = SecureStorage();
  Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: modalProgress,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/bck2.jpg'),fit: BoxFit.fill,opacity: 0.5)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/circular.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                Material(
                  shadowColor: Color(0xff3e4785),
                  elevation: 5,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 12,left: 15,right: 20),
                    child: Row(
                      children: [
                        Icon(IconData(0xf018, fontFamily: 'MaterialIcons'),color: Colors.black,size: 25,),
                        SizedBox(width: 15,),
                        Flexible(
                          child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.left,
                              onChanged: (value) {
                                email=value;
                              },
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter email',
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Material(
                  color: Colors.white,
                  shadowColor: Color(0xff3e4785),
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 12,left: 15,right: 20),
                    child: Row(
                      children: [
                        Icon(IconData(0xeaa9, fontFamily: 'MaterialIcons'),color: Colors.black,size: 25,),
                        SizedBox(width: 20,),
                        Flexible(
                          child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.left,
                              onChanged: (value) {
                                password=value;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter Password',
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  color: Color(0xff3e4785),
                  title: 'Log In',
                  onPres: () async {
                    setState(() {
                      modalProgress = true;
                    });
                    try {
                      final newUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (newUser != null) {
                        secureStorage.writeData('email', email);
                        secureStorage.writeData('password', password);
                        secureStorage.getData(password);
                        Navigator.pushNamed(context, RoomSelector.id);
                      }
                    } catch (e) {
                      print(e);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid username or password!')));
                    }
                    setState(() {
                      modalProgress = false;
                    });
                  },
                ),
                RoundedButton(
                    color: Color(0xff3e4785),
                    title: "Use Fingerprint",
                    onPres: () async {
                      final authStatus = await authentication.auth(context);
                      if (authStatus) {
                        try {
                          print('here11');
                          String em = await secureStorage.getData('email');
                          String pass = await secureStorage.getData('password');
                          print('herhe222');
                          final newUser = await _auth.signInWithEmailAndPassword(
                              email: em, password: pass);
                          if (newUser != null) {
                            Navigator.pushNamed(context, RoomSelector.id);
                          }
                        } catch (e, stacktrace) {
                          print(e);
                          print(stacktrace);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You are not registered.')));
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InputTextField extends StatelessWidget {
  final IconData iconData;
  final String ltext,htext;
  String val;
  InputTextField({
    Key? key, required this.iconData, required this.ltext, required this.htext, required this.val,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData,color: Colors.lightBlueAccent,),
        SizedBox(width: 20,),
        Flexible(
          child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.left,
              onChanged: (value) {
                val=value;
              },
              decoration: InputDecoration(
                  labelText: ltext,
                  hintText: htext,
              )
          ),
        ),
      ],
    );
  }
}

