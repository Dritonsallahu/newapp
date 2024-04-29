import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomAnimatedList extends StatefulWidget {
  final int? index;
  final Widget? child;
  final Duration? duration;
  final double? begin;
  final double? end;
  const CustomAnimatedList({Key? key, this.index,this.child,this.duration,this.begin,this.end}) : super(key: key);

  @override
  State<CustomAnimatedList> createState() => _CustomAnimatedListState();
}

class _CustomAnimatedListState extends State<CustomAnimatedList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration:  widget.duration ?? Duration(milliseconds: 100 + (widget.index! * 100)),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return   ScaleTransition(
      scale:  Tween<double>(begin: widget.begin ?? 0.7, end: widget.end ?? 1.0)
          .animate(_controller),
      child: widget.child,
    );
  }
}
