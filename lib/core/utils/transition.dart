import 'package:flutter/material.dart';

/// [Custom Transition] for navigating from dashboard to create invoice or estimate
class CustomPageTransition extends PageRouteBuilder {
  final Widget child;
  final Duration duration;
  final Offset beginOffset;
  final Curve curve;
  final bool fadeTransition;

  CustomPageTransition({
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.beginOffset = const Offset(0.0, 1.0), // Default: Bottom to Top
    this.curve = Curves.easeInOut,
    this.fadeTransition = false, // Optionally add fade effect
  }) : super(
          transitionDuration: duration,
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var slideTween = Tween(begin: beginOffset, end: Offset.zero)
                .chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(slideTween);

            if (fadeTransition) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: offsetAnimation,
                  child: child,
                ),
              );
            }

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}
