import 'package:flutter/material.dart';

import 'package:splitter/constants.dart';
import 'package:splitter/Models/PeopleModel.dart';

class PersonSelectable extends StatefulWidget {
  const PersonSelectable({Key key, @required this.person, @required this.onTap}) : super(key: key);
  final People person;
  final VoidCallback onTap;

  @override
  _PersonSelectableState createState() => _PersonSelectableState();
}

class _PersonSelectableState extends State<PersonSelectable> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      child: Column(
        children: [
          GestureDetector(
            onTap: widget.onTap,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: (widget.person.selected) ? kPrimaryColor : kPrimaryGreyColor,
                borderRadius: BorderRadius.circular(150),
              ),
              child: Center(
                  child: Text(widget.person.name.trim().split(' ').map((l) => l[0]).take(2).join().toUpperCase(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white),)
              ),
            ),
          ),
          SizedBox(height: 7,),
          Text(
            widget.person.name,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: kMediumHeadingColor,
            ),
          ),
        ],
      ),
    );
  }
}
