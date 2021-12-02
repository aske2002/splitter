import 'package:flutter/material.dart';
import 'package:splitter/constants.dart';

import 'package:splitter/Models/ProductsModel.dart';

class EditableProduct extends StatefulWidget {
  const EditableProduct({Key key, @required this.product}) : super(key: key);
  final Product product;
  @override
  _EditableProductState createState() => _EditableProductState();
}

class _EditableProductState extends State<EditableProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 20),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 45  ,
                      child: FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: kPrimaryColor,
                        child: Text(widget.product.amount.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),),
                        elevation: 0,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (widget.product.name) ? (widget.product.product.toUpperCase()) : "UNNAMED",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18,
                              color: (widget.product.name) ? kSectionHeadingColor : kDarkHeadingColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text("Remove", style: TextStyle(color: Color(0xFFFB7575), fontSize: 14, fontWeight: FontWeight.normal),)
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (widget.product.price*widget.product.amount).floor().toString(),
                            style: TextStyle(
                                fontSize: 26,
                                height: 1,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                          Text(
                            (widget.product.price*widget.product.amount-(widget.product.price*widget.product.amount).floor().toDouble()).toStringAsFixed(2).split(".")[1],
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 15,
                            ),
                          ),
                        ]
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.product.price.toStringAsFixed(2) + "/stk.",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: kPrimaryGreyColor
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
          /*Visibility(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 45,
                    child: Row(
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: kSecondaryColor,
                          child: Text("-",),
                        ),
                        FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: kSecondaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),*/
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
