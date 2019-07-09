import 'dart:async';

import 'package:flutter/material.dart';
import 'package:new_widget_image_picker/image_picker_handler.dart';

class ImagePickerDialog extends StatelessWidget {

  ImagePickerHandler _listener;
  AnimationController _controller;
  BuildContext context;

  ImagePickerDialog(this._listener, this._controller);

  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;

  void initState() {
    _drawerContentsOpacity = new CurvedAnimation(
      parent: new ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = new Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(new CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  getImage(BuildContext context) {
    if (_controller == null ||
        _drawerDetailsPosition == null ||
        _drawerContentsOpacity == null) {
      return;
    }
    _controller.forward();
    showDialog(
      context: context,
      builder: (BuildContext context) => new SlideTransition(
        position: _drawerDetailsPosition,
        child: new FadeTransition(
          opacity: new ReverseAnimation(_drawerContentsOpacity),
          child: this,
        ),
      ),
    );
  }

  void dispose() {
    _controller.dispose();
  }

  startTime() async {
    var _duration = new Duration(milliseconds: 200);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pop(context);
  }

  dismissDialog() {
    _controller.reverse();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new Material(
        type: MaterialType.transparency,
        child: new Opacity(
          opacity: 1.0,
          child: new Container(
            padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                 Container(
                  padding: EdgeInsets.all(2),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Kerem valassza ki a kep forrasat: ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,)
                          ,textAlign: TextAlign.center,),
                      ),
                      GestureDetector(
                        onTap: () => _listener.openCamera(),
                        child: roundedButton(
                            "Foto keszitese",
                            EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                            Colors.cyan,
                            const Color(0xFFFFFFFF)),
                      ),
                      GestureDetector(
                        onTap: () => _listener.openGallery(),
                        child: roundedButton(
                            "Valasztas galeriabol",
                            EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                                     Colors.cyan,
                            const Color(0xFFFFFFFF)),
                      ),
                      GestureDetector(
                        onTap: () => dismissDialog(),
                          child: roundedButton(
                              "Megse",
                              EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                              Colors.cyan,
                              const Color(0xFFFFFFFF)),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.blue
                  ),
                  constraints: BoxConstraints(
                    minHeight: 50,
                    minWidth: 400
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget roundedButton(
      String buttonLabel, EdgeInsets margin, Color bgColor, Color textColor) {
    var loginBtn =  Container(
      margin: margin,
      padding: EdgeInsets.only(top:15.0, bottom: 15.0),
      alignment: FractionalOffset.center,
      decoration:  BoxDecoration(
        color: bgColor,
      ),
      child: Text(
        buttonLabel,
        style:  TextStyle(
            color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }

}