import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height);
    var intKoef = 300.0/400.0;

    var firstEndPoint = Offset(size.width * .5*intKoef, size.height - 30.0*intKoef);
    var firstControlpoint = Offset(size.width * 0.25*intKoef, size.height - 50.0*intKoef);
    path.quadraticBezierTo(firstControlpoint.dx, firstControlpoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 80.0*intKoef);
    var secondControlPoint = Offset(size.width * .75*intKoef, size.height - 10*intKoef);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;


}