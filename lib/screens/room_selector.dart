import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/search.dart';
import 'package:flash_chat/components/rounded_button.dart';

class RoomSelector extends StatefulWidget {
  const RoomSelector({Key? key}) : super(key: key);
  static String id = 'room_selector';
  @override
  State<RoomSelector> createState() => _RoomSelectorState();
}

class _RoomSelectorState extends State<RoomSelector> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/bck2.jpg'),fit: BoxFit.fill,opacity: 0.5)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 0,width: double.infinity,),
              RoundedButton(
                  color: Color(0xff3e4785),
                  title: 'Global Chat',
                  onPres: () {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }),
              RoundedButton(
                  color: Color(0xff3e4785),
                  title: 'Chat Room',
                  onPres: () {
                    print(MediaQuery.of(context).size.height);
                    print(MediaQuery.of(context).size.width);
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.white.withOpacity(0.0),
                        context: context,
                        builder: (context) => SingleChildScrollView(
                          padding: EdgeInsets.only(
                              bottom:
                              MediaQuery.of(context).viewInsets.bottom),
                          child: SearchSheet(),
                        ));
                  }),

              // TextButton(
              //     onPressed: () {
              //       Navigator.pushNamed(context, ChatScreen.id);
              //     },
              //     child: Text('Global Chat')),
              // TextButton(onPressed: () {
              //   showModalBottomSheet(
              //       isScrollControlled: true,
              //       backgroundColor: Colors.white.withOpacity(0.0),
              //       context: context,
              //       builder: (context) => SingleChildScrollView(
              //         padding: EdgeInsets.only(
              //             bottom:
              //             MediaQuery.of(context).viewInsets.bottom),
              //         child: SearchSheet(),
              //       ));
              // }, child: Text('Chat Room')),
            ],
          ),
        ),
      ),
    );
  }
}
