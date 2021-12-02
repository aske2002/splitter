import 'package:flutter/material.dart';

import 'package:splitter/Models/PeopleModel.dart';
import 'package:splitter/constants.dart';

class Person extends StatefulWidget {
  const Person({Key key, @required this.person, @required this.onPressed}) : super(key: key);
  final People person;
  final ValueSetter<People> onPressed;
  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<Person> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed(widget.person);
      },
      onTapDown: (event) {
        setState(() {
          selected = true;
        });
      },
      onTapUp: (event) {
        setState(() {
          selected = false;
        });
      },
      child: Container(
        color: (selected) ? Colors.black.withOpacity(.05) : Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(100))
              ),
              child: Center(child: Text(widget.person.name.trim().split(' ').map((l) => l[0]).take(2).join().toUpperCase(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white),)),
            ),
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.person.name, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: kSectionHeadingColor),),
                Text(widget.person.email, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: kMediumHeadingColor),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
