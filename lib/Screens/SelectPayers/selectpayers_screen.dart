import 'package:flutter/material.dart';

import 'package:splitter/Models/ProductsModel.dart';
import 'package:splitter/Models/PeopleModel.dart';
import 'package:splitter/Models/ListModel.dart';
import 'package:splitter/constants.dart';
import 'package:splitter/route.dart' as route;

import 'SelectableProduct.dart';
import 'MapPeopleModal.dart';


class SelectPayersWidget extends StatefulWidget {
  const SelectPayersWidget(
      {Key key, @required this.list})
      : super(key: key);
  final SplitterList list;

  @override
  _SelectPayersWidgetState createState() => _SelectPayersWidgetState();
}

class _SelectPayersWidgetState extends State<SelectPayersWidget> {
  void toggleSelect (index) {
    setState(() {
      if(widget.list.products[index].selected == true) {
        widget.list.products[index].selected = false;
      } else {
        widget.list.products[index].selected = true;
      }
    });
  }

  void mapProducts(List<People> added) {
    Navigator.pop(context);
    setState(() {
      for(int i = 0; i < widget.list.products.length; i++) {
        if(widget.list.products[i].selected) {
          widget.list.products[i].people = added;
          widget.list.products[i].mapped = true;
          widget.list.products[i].selected = false;
        }
      }
      widget.list.products.sort((a, b) => b.mapped ? -1 : 1);
    });
    if(!widget.list.products.map((e) => e.mapped).contains(false)) {
      calculate();
    }
  }

  void calculate() {
    print("Calculating");
    for(int i = 0; i < widget.list.products.length; i++) {
      for(int k = 0; k < widget.list.products[i].people.length; k++) {
        num fraction = widget.list.products[i].price/widget.list.products[i].people.length;
        widget.list.participants.firstWhere((element) => element.email == widget.list.products[i].people[k].email).total += fraction;
        widget.list.participants.firstWhere((element) => element.email == widget.list.products[i].people[k].email).products.add(widget.list.products[i]);
      }
    }
    Navigator.pushReplacementNamed(context, route.listPage, arguments: widget.list);
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
            onPressed: widget.list.products.map((item) => item.selected).contains(true) ? () {
              showModalBottomSheet<dynamic>(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: new MapPeopleModal(
                        people: widget.list,
                        onProceed: (added) {
                          mapProducts(added);
                        },
                      ),
                    ),
                  )
              );
            }: null,
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
        title: Text("Add participants", style: TextStyle(
            color: kDarkHeadingColor,
            fontSize: 20,
            fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select products", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: kSectionHeadingColor),),
            Container(
              margin: EdgeInsets.only(top: 5),
              width: MediaQuery.of(context).size.width*0.7,
              child: Text(
                'Select the products to which you wish to assign payers and click "Select payers".',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: kSectionHeadingColor,
                ),
              ),

            ),
            SizedBox(height: 25,),
            Expanded(
              child: ListView.builder(
                itemCount: widget.list.products.length,
                itemBuilder: (BuildContext context, int index) {
                  return SelectableProduct(
                    product: widget.list.products[index],
                    onTap: () {
                      toggleSelect(index);
                    }
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
