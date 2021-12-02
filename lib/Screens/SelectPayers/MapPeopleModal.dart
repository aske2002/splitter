
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splitter/Screens/AddPeople/person.dart';

import 'package:splitter/constants.dart';
import 'package:splitter/Models/PeopleModel.dart';
import 'package:splitter/Models/ListModel.dart';
import 'GroupSelectable.dart';
import 'PersonSelectable.dart';

class MapPeopleModal extends StatefulWidget {
  const MapPeopleModal({Key key, @required this.people, @required this.onProceed}) : super(key: key);
  final SplitterList people;
  final ValueSetter<List<People>> onProceed;
  @override
  _MapPeopleModalState createState() => _MapPeopleModalState();
}

class _MapPeopleModalState extends State<MapPeopleModal> {
  bool allSelected = false;
  bool allPushed = false;
  bool buttonEnabled = false;

  void toggleAll() {
    if(allSelected) {
      allSelected = false;
    } else {
      allSelected = true;
    }
    checkButton();
  }

  void toggleGroup(index) {
    setState(() {
      if(widget.people.groups[index].selected) {
        widget.people.groups[index].selected = false;
      } else {
        widget.people.groups[index].selected = true;
      }
    });
    checkButton();
  }

  void togglePerson(index) {
    setState(() {
      if(widget.people.participants[index].selected) {
        widget.people.participants[index].selected = false;
      } else {
        widget.people.participants[index].selected = true;
      }
    });
    checkButton();
  }

  void checkButton() {
   if(widget.people.participants.map((e) => e.selected).contains(true) || widget.people.groups.map((e) => e.selected).contains(true) || allSelected) {
     setState(() {
       buttonEnabled = true;
     });
   } else {
     setState(() {
       buttonEnabled = false;
     });
   }
  }

  void proceed() {
    List<People> added = [];
    if(allSelected) {
      for(int i = 0; i < widget.people.participants.length; i++) {
        added.add(widget.people.participants[i]);
      }
    }
    for(int i = 0; i < widget.people.participants.length; i++) {
      if(widget.people.participants[i].selected) {
        widget.people.participants[i].selected = false;
        bool exists = false;
        for(int m = 0; m < added.length; m++) {
          if(added[m].email == widget.people.participants[i].email) {
            exists = true;
          }
        }
        if(!exists) {
          added.add(widget.people.participants[i]);
        }
      }
    }
    for(int i = 0; i < widget.people.groups.length; i++) {
      if(widget.people.groups[i].selected) {
        widget.people.groups[i].selected = false;
        for(int k = 0; k < widget.people.groups[i].people.length; k++) {
          bool exists = false;
          for(int m = 0; m < added.length; m++) {
            if(added[m].email == widget.people.groups[i].people[k].email) {
              exists = true;
            }
          }
          if(!exists) {
            added.add(widget.people.groups[i].people[k]);
          }
        }
      }
    }
    widget.onProceed(added);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration:  BoxDecoration(
          color: kSecondaryBackground,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0)
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded, color: kSectionHeadingColor),
                padding: EdgeInsets.only(right: 10.0),
                iconSize: 30.0,
                onPressed: () {Navigator.pop(context);},
              ),
              Text("Select payers", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: kSectionHeadingColor)),
            ],
          ),
          SizedBox(height: 10,),
          Listener(
            onPointerDown: (event) {
              setState(() {
                allPushed = true;
              });
            },
            onPointerUp: (event) {
              setState(() {
                allPushed = false;
              });
            },
            child: GestureDetector(
              onTap: () {
                toggleAll();
              },
              child: Container(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: (allSelected) ? kPrimaryColor : kPrimaryGreyColor,
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: Center(
                        child: Icon(Icons.groups, color: Colors.white,),
                      ),
                    ),
                    SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("All", style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: kMediumHeadingColor,
                          fontSize: 17
                        ),),
                        Text("Select all people who is a part of this list", style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: kMediumHeadingColor,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 13,
                        ),),
                      ],
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                  color: (allPushed) ? Colors.grey.shade100 : Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.15),
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
          ),
          (widget.people.groups.length > 0) ?
          Container(
            height: 120,
            margin: EdgeInsets.only(top: 15, bottom: 20),
            width: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.people.groups.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GroupSelectable(
                  onTap: () {
                    toggleGroup(index);
                  },
                  group: widget.people.groups[index],
                );
              },
            ),
          ) : SizedBox(height: 20,),
          Container(
            height: 75,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.people.participants.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return PersonSelectable(
                    person: widget.people.participants[index],
                    onTap: () {togglePerson(index);},
                );
              }
            )
          ),
          SizedBox(height: 30,),
          Container(
            height: 55,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (buttonEnabled) ? () {proceed();} : null,
              child: Text("Continue", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),),
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
