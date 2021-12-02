import 'package:flutter/material.dart';

import 'package:splitter/Models/ProductsModel.dart';
import 'package:splitter/constants.dart';

class SelectableProduct extends StatefulWidget {
  const SelectableProduct({Key key, @required this.product, @required this.onTap}) : super(key: key);
  final Product product;
  final VoidCallback onTap;
  @override
  _SelectableProductState createState() => _SelectableProductState();
}

class _SelectableProductState extends State<SelectableProduct> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (widget.product.mapped) ? null : (event) => setState(() {
        selected = true;
      }),
      onPointerUp: (widget.product.mapped) ? null : (event) => setState(() {
        selected = false;
      }),
      child: GestureDetector(
        onTap: (widget.product.mapped) ? null : widget.onTap,
        child: Opacity(
          opacity: (widget.product.mapped) ? 0.2 : 1,
          child: Container(
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.only(top: 17.5, bottom: 17.5, left: 15, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          color:  (widget.product.selected) ? kPrimaryColor : kPrimaryGreyColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: (widget.product.selected) ?
                        Center(
                          child: Icon(Icons.done_rounded, color: Colors.white,),
                        ) : null,
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
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: (selected) ? Colors.grey.shade100 : Colors.white,
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
    );
  }
}
