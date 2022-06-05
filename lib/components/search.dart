import 'package:flash_chat/screens/custom_chat_room.dart';
import 'package:flutter/material.dart';

class SearchSheet extends StatefulWidget {
  @override
  State<SearchSheet> createState() => _SearchSheetState();
}

class _SearchSheetState extends State<SearchSheet> {
  String name = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              // topLeft: Radius.circular(20),
              // topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Enter Room',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Barlow',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  hoverColor: Colors.white,
                  focusColor: Colors.black,
                ),
                style: TextStyle(fontSize: 20),
                autofocus: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  name = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatRoom(room: name)));
                },
                child: Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Kaushan',
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black54),
                ),
              )
            ],
          ),
        ),
        loading
            ? Align(
                child: CircularProgressIndicator(),
                alignment: AlignmentDirectional.topCenter,
              )
            : Container(),
      ],
    );
  }
}
