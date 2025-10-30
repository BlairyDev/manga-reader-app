import 'package:flutter/material.dart';

Route<void> slideFromRightRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}

Route<void> noTransitionRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: Duration.zero, // no animation duration
    reverseTransitionDuration: Duration.zero, // disable pop animation too
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child; // directly show the new page
    },
  );
}
