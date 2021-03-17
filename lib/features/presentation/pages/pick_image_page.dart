import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:zana_storage/core/config/config.dart';
class PickImagePage extends StatefulWidget {
  @override
  _PickImagePageState createState() => _PickImagePageState();
}

class _PickImagePageState extends State<PickImagePage> {
  File _imageFile;

  @override
  void initState() {
    super.initState();
    _imageFile = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Pick Image'),
      ),
        // bottomNavigationBar: BottomAppBar(
        //   child:
        //   Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: <Widget>[
        //       IconButton(
        //         icon: Icon(
        //           Icons.photo_camera,
        //           size: 30,
        //         ),
        //         onPressed: () => _pickImage(ImageSource.camera),
        //         color: Colors.blue,
        //       ),
        //       IconButton(
        //         icon: Icon(
        //           Icons.photo_library,
        //           size: 30,
        //         ),
        //         onPressed: () => _pickImage(ImageSource.gallery),
        //         color: Colors.blue,
        //       ),
        //     ],
        //   ),
        // ),
        body: SingleChildScrollView(
          child:
          Column(
            children: [
              Container(
                margin: EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Column(children: [
                    _imageFile != null? Container(
                        color: Colors.white,
                      // width: Get.mediaQuery.size.width,
                        // height: Get.mediaQuery.size.width,
                        padding: EdgeInsets.all(8.0), child: ClipRRect(
                        borderRadius: BorderRadius.circular(borderRadius),
                        child: Image.file(_imageFile))):Container(),
                    _imageFile != null?
                    Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.white,
                      child:
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FlatButton(
                                // color: Colors.black,
                                child: Icon(Icons.crop),
                                onPressed: _cropImage,
                              ),
                              FlatButton(
                                // color: Colors.black,
                                child: Icon(Icons.refresh),
                                onPressed: _clear,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  // margin: EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(borderRadius),
                                        // side: BorderSide(color: Colors.grey.shade200)
                                      ),
                                      color: Colors.green,
                                      padding: EdgeInsets.only(top: 20,bottom: 20),
                                      onPressed:() {
                                        Get.back(result: _imageFile);
                                      },
                                      child:
                                      Text('Confirm',style: TextStyle(color: Colors.white),)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ):Container(),
                  ],),
                ),
              ),
            ],
          ),
        )
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  void _clear() {
    setState(() => _imageFile = null);
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
        toolbarTitle: 'Crop It'

    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }
}
