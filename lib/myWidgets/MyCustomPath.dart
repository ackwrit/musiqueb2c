import 'package:flutter/material.dart';

class MyCustomPath extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    path.lineTo(0, size.height/2);
    path.quadraticBezierTo(size.width/4, size.height/2, size.width/3, size.height/3);
    path.quadraticBezierTo(size.width, size.height/4, size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }

}