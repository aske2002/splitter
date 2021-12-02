import 'package:flutter/material.dart';

import 'package:splitter/constants.dart';
import 'package:splitter/Models/PeopleModel.dart';

class GroupSelectable extends StatefulWidget {
  const GroupSelectable({Key key, @required this.onTap, @required this.group}) : super(key: key);
  final VoidCallback onTap;
  final Group group;

  @override
  _GroupSelectableState createState() => _GroupSelectableState();
}

class _GroupSelectableState extends State<GroupSelectable> {
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
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          margin: EdgeInsets.only(right: 10),
          width: MediaQuery.of(context).size.width/2-25,
          decoration:  BoxDecoration(
            color: (selected) ? Colors.grey.shade100 : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.15),
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (widget.group.selected) ? kPrimaryColor : kPrimaryGreyColor,
                  borderRadius: BorderRadius.circular(150),
                ),
                child: Center(
                  child: Icon(Icons.group, color: Colors.white,),
                ),
              ),
              SizedBox(width: 8,),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.group.name, maxLines: 1, style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: kMediumHeadingColor,
                          fontSize: 17
                      ),),
                      Text(widget.group.people.map((e) => e.name).join(", "), textAlign: TextAlign.left, style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: kMediumHeadingColor,
                        fontSize: 13,
                      ),),
                    ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
