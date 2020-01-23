import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:camera_test_app/model/image_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:storage_path/storage_path.dart';
import 'package:transparent_image/transparent_image.dart';

class AlbumPreviewPage extends StatefulWidget {
  @override
  _AlbumPreviewPageState createState() => _AlbumPreviewPageState();
}

class _AlbumPreviewPageState extends State<AlbumPreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album'),
        backgroundColor: Colors.blueGrey,
      ),
      body:
//        buildOrientationBuilder()
          FutureImageWidget(),
    );
  }

  OrientationBuilder buildOrientationBuilder() {
    return OrientationBuilder(builder: (context, orientation) {
      return GridView.builder(
          itemCount: 10,
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
              child: new Card(
                elevation: 5.0,
                child: new Container(
                  alignment: Alignment.center,
                  child: new Text('Item $index'),
                ),
              ),
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  child: new AlertDialog(
                    title: new Column(
                      children: <Widget>[
                        new Text(
                          "Image",
                          textAlign: TextAlign.center,
                        ),
                        new Icon(
                          Icons.favorite,
                          color: Colors.green,
                        ),
                      ],
                    ),
                    content:
                        //new Text("Selected Item $index"),
                        new Container(
                      child: new Text("Selected Item $index"),
                    ),
                    actions: <Widget>[
                      new FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: new Text("OK"))
                    ],
                  ),
                );
              },
            );
          });
    });
  }
}

class FutureImageWidget extends StatelessWidget {
  const FutureImageWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: StoragePath.imagesPath,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      List<dynamic> list = json.decode(snapshot.data);
      return Container(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            ImageModel imageModel = ImageModel.fromJson(list[index]);
            return Container(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  FadeInImage(
                    image: FileImage(
                      File(imageModel.files[0]),
                    ),
                    placeholder: MemoryImage(kTransparentImage),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.7),
                    height: 30,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        imageModel.folderName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Regular'),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
    } else {
      return Container();
    }
        },
      );
  }
}
