import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class RandomAnimation extends StatefulWidget {
  final Widget? child;
  final int? duration;
  const RandomAnimation({Key? key, this.child, this.duration})
      : super(key: key);

  @override
  State<RandomAnimation> createState() => _RandomAnimationState();
}

class _RandomAnimationState extends State<RandomAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration!),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) =>
      FadeTransition(opacity: _animation, child: widget.child);
}
