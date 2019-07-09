import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_widget_image_picker/image_picker_handler.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin, ImagePickerListener {
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker = ImagePickerHandler(this, _controller);
    imagePicker.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () => imagePicker.showDialog(context),
      child: Center(
          child: _image == null
              ? Stack(
                  children: <Widget>[
                    Center(
                      child: new CircleAvatar(
                        radius: 80.0,
                        backgroundColor: const Color(0xFF778899),),),
                    Center(child: Image.asset("assets/photo_camera.png")),],)
              : Column(
                  children: <Widget>[
                    Container(
                      decoration: new BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: new DecorationImage(
                          image: new ExactAssetImage(_image.path),
                          fit: BoxFit.cover,),),
                      constraints:
                          BoxConstraints(minWidth: 500, minHeight: 600),),
                    Center(
                            child: Image.asset("assets/photo_camera.png")),],)),));}

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
}
