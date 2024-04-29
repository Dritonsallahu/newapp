import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ListAnimation extends StatefulWidget {
  final int? index;
  final Widget? child;
  final int? duration;
  const ListAnimation({Key? key,this.index, this.child, this.duration})
      : super(key: key);

  @override
  State<ListAnimation> createState() => _ListAnimationState();
}

class _ListAnimationState extends State<ListAnimation>
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
