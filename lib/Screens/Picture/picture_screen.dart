import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:splitter/constants.dart';

import 'package:splitter/route.dart' as route;
import 'package:splitter/Models/Imagearguments.dart';

Future<CameraController> GetCamera() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  final CameraController controller = CameraController(firstCamera, ResolutionPreset.high);
  await controller.initialize();
  controller.setFlashMode(FlashMode.always);
  return controller;
}

class PictureScreen extends StatefulWidget {
  const PictureScreen({Key key}) : super(key: key);
  @override
  _PictureScreenState createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool shutterHold = false;
  final ImagePicker _picker = ImagePicker();
  _imgFromGallery() async {
    XFile image = await _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 100
    );
    List<int> imagebytes = await image.readAsBytes();
    String base64image = base64Encode(imagebytes);
    Navigator.pushReplacementNamed(context, route.editListPage, arguments: ImageArguments(image: base64image));
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<CameraController>(
              future: GetCamera(),
              builder: (BuildContext context, AsyncSnapshot<CameraController> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting: return Container(color: kPrimaryColor, child: Center(child: CircularProgressIndicator(color: Colors.white,)));
                  default:
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    else
                    _controller = snapshot.data;
                    _initializeControllerFuture = _controller.initialize();
                    final scale = 1 / (_controller.value.aspectRatio * MediaQuery.of(context).size.aspectRatio);
                    return Transform.scale(
                      scale: scale,
                      alignment: Alignment.topCenter,
                      child: CameraPreview(
                        _controller,
                      ),
                    );
                }
              }
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 50  ,
                  width: double.infinity,
                  child: Center(child: Text("Take a picture of your receipt to scan items", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 15),)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(.5),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.4),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 3, color: Colors.white)),
                  child: Container(
                    width: 45,
                    height: 45,
                    child: FloatingActionButton(
                      onPressed: () async {
                        try {
                          await _initializeControllerFuture;

                          ///Når brugeren trykker på knappen
                          ///Linje 111 - lib/Screens/Picture/picture_screen.dart
                          //Vi beder asynkront kameraet om at tage et billede
                          final image = await _controller.takePicture();
                          //Sæt kamera foråndsvisning på pause
                          _controller.pausePreview();
                          //Hent dataen fra billedet ind i en liste af int
                          List<int> imagebytes = await image.readAsBytes();
                          //Indkod billedet til base64 som en String
                          String base64image = base64Encode(imagebytes);
                          //Send brugeren videre til næste skærm sammen med billedet som base64
                          Navigator.pushReplacementNamed(
                            context, route.editListPage, arguments: ImageArguments(image: base64image)
                          );

                        } catch (e) {

                        }
                      },
                      backgroundColor: Colors.white,
                      splashColor: Colors.grey,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                  onPressed: () {_imgFromGallery();},
                  child: Text("Gallery"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
