import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:splitter/Models/ListModel.dart';
import 'package:splitter/constants.dart';
import 'package:splitter/Models/PeopleModel.dart';
import 'package:splitter/Models/ProductsModel.dart';
import 'person.dart';
import 'package:splitter/route.dart' as route;

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

class AddPeopleWidget extends StatefulWidget {
  AddPeopleWidget({Key key, @required this.list}) : super(key: key);
  final SplitterList list;

  @override
  _AddPeopleWidgetState createState() => _AddPeopleWidgetState();
}

class _AddPeopleWidgetState extends State<AddPeopleWidget> {
  String search = "";
  bool showPeople = false;
  FocusNode _focus = new FocusNode();
  TextEditingController _controller = new TextEditingController();
  //PeopleList finalPeopleList = new PeopleList([], []);

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose(){
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange(){
    setState(() {
      showPeople = _focus.hasFocus;
    });
  }

  void addPerson(People person) {
    setState(() {
      widget.list.participants.add(person);
    });
  }

  void removePerson(int index) {
    setState(() {
      widget.list.participants.removeAt(index);
    });
  }

  Future<PeopleList> searchUser(username) async {
    List<int> intList = username.codeUnits;
    Uint8List uint8 = Uint8List.fromList(intList);
    try {
      RestOptions options = RestOptions(
          path: '/searchuser',
          body: uint8
      );
      RestOperation restOperation = Amplify.API.post(
          restOptions: options
      );
      RestResponse response = await restOperation.response;
      String strres = new String.fromCharCodes(response.data);
      PeopleList users = PeopleList.fromJson(jsonDecode(strres));
      if(users.people.length < 1 && username.toString().isNotEmpty) {
        users.people.add(People(username, username, false));
      }
      for(int i = 0; i < widget.list.participants.length; i++) {
        for(int k = 0; k < users.people.length; k++) {
          if(widget.list.participants[i].email == users.people[k].email) {
            users.people.removeAt(k);
            break;
          }
        }
      }
      return users;
    } on ApiException catch (e) {
      return Future.error(e.message);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 0.75)
            )
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Container(
          height: 55,
          child: ElevatedButton(
            onPressed: (widget.list.participants.length > 0) ? () {Navigator.pushNamed(context, route.selectPayersPage, arguments: widget.list);} : null,
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
      ),
      backgroundColor: kSecondaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 65,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.close_rounded, color: kDarkHeadingColor, size: 28,),
        ),
        title: Text("Add participants", style: TextStyle(color: kDarkHeadingColor, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Theme(
            data: Theme.of(context).copyWith(colorScheme: ThemeData().colorScheme.copyWith(primary: kPrimaryColor)),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                focusNode: _focus,
                onChanged: (text) {
                  setState(() {
                    search = text;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Enter name or email of participant",
                  hintStyle: TextStyle(color: kSmallTextColor, fontSize: 16),
                  contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  prefixIcon: Icon(Icons.person_add, size: 22,),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor, width: 4.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                )
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        (widget.list.participants.length < 1) ?
                        Container(
                            height: 80,
                            child: Center(child: Text("Please add participants to the list", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: kSmallTextColor),))
                        ) :
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.list.participants.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(width: 0.5, color: kSmallTextColor),
                                  ),
                                  color: Colors.transparent,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: kPrimaryColor,
                                                borderRadius: BorderRadius.all(Radius.circular(100))
                                            ),
                                            child: Center(child: Text(widget.list.participants[index].name.trim().split(' ').map((l) => l[0]).take(2).join().toUpperCase(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white),)),
                                          ),
                                          SizedBox(width: 10,),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(widget.list.participants[index].name, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: kSectionHeadingColor),),
                                              Text(widget.list.participants[index].email, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: kMediumHeadingColor),)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {removePerson(index);},
                                        icon: Icon(Icons.close_rounded, color: kSectionHeadingColor,)
                                    )
                                  ],
                                ),
                              );
                            }
                        ),
                        SizedBox(height: 20,),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 150,
                                width: MediaQuery.of(context).size.width/2-25,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(.15),
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.add_circle_rounded, color: Colors.black.withOpacity(.1), size: 40,),
                                      padding: EdgeInsets.zero,
                                    ),
                                    SizedBox(height: 5,),
                                    Text("Add group", style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(.2), fontWeight: FontWeight.w500),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: showPeople,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsetsDirectional.zero,
                    padding: EdgeInsets.only(bottom: 20, top: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20), topLeft: Radius.zero, topRight: Radius.zero),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.15),
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: FutureBuilder<PeopleList>(
                        future: searchUser(search),
                        builder: (BuildContext context, AsyncSnapshot<PeopleList> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting: return Padding(
                              padding: const EdgeInsets.only(top: 25, bottom: 20,),
                              child: Container(height: 40, width: 40,child: Center(child: CircularProgressIndicator())),
                            );
                            default:
                              if (snapshot.hasError) {
                                return Container(
                                  height: 40,
                                  child: Center(child: new Text('Error: ${snapshot.error}')),
                                );
                              } else if(snapshot.data.people.length > 0) {
                                return Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: snapshot.data.people.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Person(person: snapshot.data.people[index], onPressed: (person) {
                                          _focus.unfocus();
                                          addPerson(person);
                                        });
                                      }
                                  ),
                                );
                              } else {
                                return Container(
                                  height: 70,
                                  width: double.infinity,
                                  child: Center(child: Text("No users found")),
                                );
                              }
                          }
                        }
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
