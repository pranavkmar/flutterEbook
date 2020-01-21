import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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
        body: OrientationBuilder(builder: (context, orientation) {
          return GridView.builder(
              itemCount: 10,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
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
        }));
  }
}
