import 'package:flutter/material.dart';

import 'package:splitter/constants.dart';
import 'package:splitter/Models/PeopleModel.dart';

class ListPerson extends StatefulWidget {
  const ListPerson({Key key, @required this.person}) : super(key: key);
  final People person;

  @override
  _ListPersonState createState() => _ListPersonState();
}

class _ListPersonState extends State<ListPerson> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        setState(() {
          selected = true;
        });
      },
      onPointerUp: (event) {
        setState(() {
          selected = false;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        color: (selected) ? Colors.grey.shade100 : Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      widget.person.name.trim().split(' ').map((l) => l[0]).take(2).join().toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.person.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: kSectionHeadingColor,
                      ),
                    ),
                    Text(
                      widget.person.total.toStringAsFixed(2) + " DKK - Pending",
                      style: TextStyle(
                          fontSize: 13,
                          color: kSmallTextColor
                      ),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_ios_rounded, color: kSectionHeadingColor, size: 22,),
            ),
          ]
        ),
      ),
    );
  }
}
