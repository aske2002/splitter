import 'package:flutter/material.dart';
import 'package:splitter/Models/ProductsModel.dart';
import 'package:splitter/Models/ListModel.dart';
import 'package:splitter/Models/PeopleModel.dart';

import 'EditableProduct.dart';

import 'package:splitter/constants.dart';
import 'package:splitter/route.dart' as route;

class EditAbleListWidget extends StatefulWidget {
  const EditAbleListWidget({Key key, @required this.list}) : super(key: key);
  final SplitterList list;
  /*final SplitterList list = SplitterList(
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
  _EditAbleListWidget createState() => _EditAbleListWidget();
}

class _EditAbleListWidget extends State<EditAbleListWidget> {
  final nameController = TextEditingController();
  bool nameSet = false;

  void nameChanged(string) {
    setState(() {
      if (nameController.text != null && nameController.text.trim() != "")   {
        nameSet = true;
      } else {
        nameSet = false;
      }
    });
  }

  void proceed() {
    SplitterList finallist = SplitterList("Name", [], [], [], widget.list.calcPrice, widget.list.recPrice, widget.list.length);
    for(int i = 0; i < widget.list.products.length; i++) {
      if(widget.list.products[i].amount > 1) {
        for (int k = 0; k < widget.list.products[i].amount; k++) {
          finallist.products.add(Product(
              widget.list.products[i].product, 1, widget.list.products[i].price,
              widget.list.products[i].rabat, widget.list.products[i].name,
              false
          ));
        }
      } else {
        finallist.products.add(widget.list.products[i]);
      }
    }
    finallist.name = nameController.text.trim();
    Navigator.pushNamed(context, route.addPeoplePage, arguments: finallist);
  }
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F4FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
          toolbarHeight: 65,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.close_rounded, color: kDarkHeadingColor, size: 28,),
        ),
        title: Text("New List", style: TextStyle(color: kDarkHeadingColor, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    children: [
                      Container(
                        child: TextField(
                          controller: nameController,
                          onChanged: (string) {nameChanged(string);},
                          style: TextStyle(color: kDarkHeadingColor, fontWeight: FontWeight.w400, fontSize: 18),
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Give this list a name...",
                            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                            hintStyle: TextStyle(color: Colors.grey.shade300, fontWeight: FontWeight.w400, fontSize: 18),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
             ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        height: 45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.add),
                                  style: ElevatedButton.styleFrom(
                                    primary: kPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                  label: Text("Add new item", style: TextStyle(fontSize: 16 ),),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.delete, color: kSectionHeadingColor,),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                  )
                                ),
                                label: Text("Discard list", style: TextStyle(fontSize: 16, color: kSectionHeadingColor),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Expanded(
                        child: ListView.builder(
                            itemCount: widget.list.products.length,
                            itemBuilder: (BuildContext context, int index) {
                              return EditableProduct(product: widget.list.products[index]);
                            }
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
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
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("DKK", style: TextStyle(
                                fontSize: 28,
                                height: 1.1,
                                fontWeight: FontWeight.w400,
                                color: kSectionHeadingColor
                            ),),
                            SizedBox(width: 7,),
                            Text(
                              (widget.list.calcPrice).floor().toString(),
                              style: TextStyle(
                                  fontSize: 28,
                                  height: 1.1,
                                  color: kSectionHeadingColor,
                                  fontWeight: FontWeight.w900
                              ),
                            ),
                            Text(
                              (widget.list.calcPrice-(widget.list.calcPrice).floor().toDouble()).toStringAsFixed(2).split("0.")[1],
                              style: TextStyle(
                                color: kSectionHeadingColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Container(
                          height: 55,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (nameSet && widget.list.length > 0) ? () {proceed();} : null,
                            child: Text("Confirm items", style: TextStyle(
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
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
