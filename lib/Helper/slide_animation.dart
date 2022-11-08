// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

enum SlideDirection { fromTop, fromLeft, fromRight, fromBottom }

class SlideAnimation extends StatefulWidget {
  final int position;
  final int itemCount;
  final Widget child;
  final SlideDirection slideDirection;
  final AnimationController animationController;

  // we have created a named parameter constructor
  const SlideAnimation({
    Key? key,
    required this.position,
    required this.itemCount,
    required this.slideDirection,
    required this.animationController,
    required this.child,
  }) : super(key: key);

  @override
  _SlideAnimationState createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation> {
  @override
  Widget build(BuildContext context) {
    // we need x and y translation variables to animate items in different direction using our enum
    var xTranslation = 0.0, yTranslation = 0.0;

    // we need to declare our animation for fade transition widget
    var animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: widget.animationController,
          // curve for the way you want to animate your list item widget. you can use anything from curves
          curve: Interval((1 / widget.itemCount) * widget.position, 1.0,
              curve: Curves.fastOutSlowIn)),
    );

    widget.animationController.forward();

    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) {
        if (widget.slideDirection == SlideDirection.fromTop) {
          // this will animate items from top with fade transition
          yTranslation = -50 * (1.0 - animation.value);
        } else if (widget.slideDirection == SlideDirection.fromBottom) {
          // this will animate items from bottom with fade transition
          yTranslation = 50 * (1.0 - animation.value);
        } else if (widget.slideDirection == SlideDirection.fromRight) {
          // this will animate items from right with fade transition
          xTranslation = 400 * (1.0 - animation.value);
        } else {
          // this will animate items from left with fade transition
          xTranslation = -400 * (1.0 - animation.value);
        }

        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform:
                Matrix4.translationValues(xTranslation, yTranslation, 0.0),
            child: widget.child,
          ),
        );
      },
    );
  }
}
