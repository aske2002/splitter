import 'dart:convert';

import 'package:flutter/material.dart';import 'dart:typed_data';

import 'package:splitter/Screens/EditList/list_widget.dart';
import 'package:splitter/Models/ProductsModel.dart';
import 'package:splitter/Models/ListModel.dart';
import 'package:splitter/constants.dart';
import 'package:splitter/route.dart' as route;

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

class EditListScreen extends StatefulWidget {
  const EditListScreen({Key key, @required this.base64image}) : super(key: key);
  final String base64image;
  @override
  _EditListScreenState createState() => _EditListScreenState();
}

class _EditListScreenState extends State<EditListScreen> {

  ///Når brugeren bliver vidersendt til næste skærm med base64 billedet
  ///Linje 23 - lib/Screens/EditList/editlist_screen.dart
  //Dette er en future, det betyder egnetligt at det er en funktion
  //som lover at retunere et objekt af klassen SplitterList på et senere tidspunkt.
  //Det er vigtigt, for indtil da viser vi brugeren et loading ikon
  Future<SplitterList> parseImage(String base64image) async {
    //Vi laver vores base64 string med billedet om til en liste
    //af UTF-16 koder
    List<int> intList = base64image.codeUnits;
    //Vi laver denne liste om til en liste af 8-bit int
    Uint8List uint8 = Uint8List.fromList(intList);
    //En try-catch blok så vi kan fange fejl
    try {
      //Vi sætter nogle indstillinger for den anmodning
      //vi skal sende til api'en, heriblandt endepunktet
      //som er /parseimg og body
      RestOptions options = RestOptions(
          path: '/parseimg',
          body: uint8
      );
      RestOperation restOperation = Amplify.API.post(
          restOptions: options
      );
      //Vi eksekverer post anmodningen asynkront, og venter på svar
      RestResponse response = await restOperation.response;
      //Response.data er en uint8list, vi laver den om til en
      //string igen
      String strres = new String.fromCharCodes(response.data);
      //Da algortimen sender et JSON objekt tilbage
      //skal svaret fra api'en parses ned i en klasse
      //Klassen products indeholder samme struktur som JSON objektet
      Products products = Products.fromJson(jsonDecode(strres));
      //Ud fra products objektet opretter vi en ny SplitterList
      //som også er en klasse, der indeholder information omkring listen
      SplitterList list = SplitterList(
        "", [], [], products.products, products.calcPrice, products.recPrice, products.length
      );
      //Retuner listen, produkterne bliver vist på brugerens skærm
      return list;
    } catch (e) {
      //Hvis der opstår en fejl sender vi brugeren tilbage til kameraskærmen
      await Navigator.pushReplacementNamed(context, route.picturePage);
    }
  }

  @override
  Widget build(BuildContext context) {
    /*List<Product> productTest = [
      Product("Milk", 4, 2.4, 0, true, false),
      Product("Sugar", 1, 10, 0, true, false),
      Product("Kg kartofler som er meget", 4, 9.95, 0, true, false),
      Product("Æbler", 2, 1, 0, true, false),
      Product("", 3, 6, 0, false, false),
    ];
    return ListWidget(list: new Products(productTest, 5, 125.96, 125.96));*/
    return FutureBuilder<SplitterList>(
        future: parseImage(widget.base64image),
        builder: (BuildContext context, AsyncSnapshot<SplitterList> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Container(color: kPrimaryColor, child: Center(child: CircularProgressIndicator(color: Colors.white,)));
            default:
              if (snapshot.hasError) {
                return Container(color: kPrimaryColor, child: Center(child: CircularProgressIndicator(color: Colors.white,)));
              } else {
                return EditAbleListWidget(list: snapshot.data);
              }
          }
        }
    );
  }
}
