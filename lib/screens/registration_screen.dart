import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/Storage.dart';
import 'package:flash_chat/screens/room_selector.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool modalProgress = false;
  late String email, password;
  SecureStorage secureStorage = SecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  height: 20.0,
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
                  title: 'Register',
                  onPres: () async {
                    setState(() {
                      modalProgress = true;
                    });
                    // print(email);
                    // print(password);
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      if (newUser != null) {
                        secureStorage.writeData('email', email);
                        secureStorage.writeData('password', password);
                        secureStorage.getData(password);
                        Navigator.pushNamed(context, RoomSelector.id);
                      }
                    } catch (e) {
                      print(e);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong!')));

                    }
                    setState(() {
                      modalProgress = false;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
