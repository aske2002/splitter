import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:splitter/Models/ListModel.dart';
import 'package:splitter/Models/PeopleModel.dart';
import 'package:splitter/Models/ProductsModel.dart';


import 'package:splitter/constants.dart';
import 'package:splitter/route.dart';
import 'ListPerson.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({Key key, @required this.list}) : super(key: key);
  final SplitterList list;

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  /*final SplitterList testlist = SplitterList(
    "Hello",
    [
      People("lau@erikmiachael.dk", "Lau Sørensen", false),
      People("lau@erikmiachael.dk", "Lau Sørensen", false),
      People("kasperpepsi@gmail.com", "Kasper Hyldgaard", false),
      People("askevkoed@gmail.com", "Aske Koed", false),
      People("Silje Holm", "Silje Holm", false),
    ],
    [],
    [
      Product("Mælk", 1, 20.0, 0.0, true, false),
      Product("Jordbær", 1, 10.0, 0.0, true, false),
      Product("Mælk", 1, 20.0, 0.0, true, false),
      Product("Marmelade", 1, 20.0, 0.0, true, false),
      Product("Kartofler", 1, 20.0, 0.0, true, false),
      Product("LASAGNE 1 KG", 1, 20.0, 0.0, true, false),
      Product("Ged", 1, 20.0, 0.0, true, false),
      Product("Ko", 1, 20.0, 0.0, true, false),
    ],
    124.00,
    124.00,
    11,
  );*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/images/list_illustration.png", color: Colors.black.withOpacity(.2), colorBlendMode: BlendMode.srcOver,),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Container(
                  height: 180,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      widget.list.name,
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.w900
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            topRight: Radius.circular(50.0)
                        )
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.list.name,
                            style: TextStyle(
                              fontSize: 28,
                              color: kDarkHeadingColor,
                              fontWeight: FontWeight.w800,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 2,),
                          Row(
                            children: [
                              Text(
                                "By ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: kSmallTextColor,
                                ),
                              ),
                              Text(
                                "Aske Koed",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: kSmallTextColor,
                                ),
                              ),
                              Text(
                                " • ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: kSmallTextColor,
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Follow",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 25,),
                          Row(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration:  BoxDecoration(
                                    color: kPrimaryColor.withOpacity(.3),
                                    borderRadius: BorderRadius.circular(7.5),
                                ),
                                child: Center(
                                  child: Icon(Icons.today, color: kPrimaryColor,),
                                ),
                              ),
                              SizedBox(width: 15,),
                              Text(
                                new DateFormat("MMM dd, yyyy").format(widget.list.date),
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: kSectionHeadingColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration:  BoxDecoration(
                                  color: kPrimaryColor.withOpacity(.3),
                                  borderRadius: BorderRadius.circular(7.5),
                                ),
                                child: Center(
                                  child: Icon(Icons.groups_rounded, color: kPrimaryColor,),
                                ),
                              ),
                              SizedBox(width: 15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.list.participants.length.toString() + " people in list",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: kSectionHeadingColor,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 120,
                                        child: Text(
                                          widget.list.participants.map((e) => e.name.trim().split(" ")[0]).join(", "),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: kSmallTextColor
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 2,),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          minimumSize: Size.zero,
                                          padding: EdgeInsets.zero,
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          "View all",
                                          style: TextStyle(
                                            color: kPrimaryColor,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration:  BoxDecoration(
                                  color: kPrimaryColor.withOpacity(.3),
                                  borderRadius: BorderRadius.circular(7.5),
                                ),
                                child: Center(
                                  child: Icon(Icons.paid_rounded, color: kPrimaryColor,),
                                ),
                              ),
                              SizedBox(width: 15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.list.calcPrice.toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: kSectionHeadingColor,
                                    ),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      "View items",
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 25,),
                          Text(
                            "About",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kSectionHeadingColor,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            (widget.list.description.length > 0) ? widget.list.description : "No description provided.",
                            maxLines: 4,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: kSectionHeadingColor,
                              height: 1.2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Participants",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: kSectionHeadingColor,
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {},
                                child: Text(
                                  "View all",
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.list.participants.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListPerson(person: widget.list.participants[index]);
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  height: 100,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.2),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: kPrimaryColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)
                              ),
                            ),
                            child: Text(
                              "View items and pay",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.2),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Text(
                            "Dismiss",
                            style: TextStyle(
                              fontSize: 16,
                              color: kPrimaryColor
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
