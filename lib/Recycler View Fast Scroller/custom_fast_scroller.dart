import 'package:flutter/material.dart';

class CustomFastScroller extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final double thumbWidth;
  final double thumbHeight;
  final Color thumbColor;
  final Color trackColor;

  const CustomFastScroller({
    super.key,
    required this.child,
    required this.controller,
    this.thumbWidth = 8,
    this.thumbHeight = 60,
    this.thumbColor = Colors.blue,
    this.trackColor = Colors.grey,
  });

  @override
  State<CustomFastScroller> createState() => _CustomFastScrollerState();
}

class _CustomFastScrollerState extends State<CustomFastScroller> {
  double _thumbTop = 0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_syncThumbWithScroll);
  }

  void _syncThumbWithScroll() {
    if (!_isDragging && widget.controller.hasClients) {
      final maxScroll = widget.controller.position.maxScrollExtent;
      final currentScroll = widget.controller.offset;
      final scrollRatio = currentScroll / maxScroll;

      final trackHeight = context.size?.height ?? 1;
      setState(() {
        _thumbTop = scrollRatio * (trackHeight - widget.thumbHeight);
      });
    }
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final trackHeight = context.size?.height ?? 1;

    setState(() {
      _isDragging = true;
      _thumbTop += details.delta.dy;

      if (_thumbTop < 0) _thumbTop = 0;
      if (_thumbTop > trackHeight - widget.thumbHeight) {
        _thumbTop = trackHeight - widget.thumbHeight;
      }

      final scrollRatio = _thumbTop / (trackHeight - widget.thumbHeight);
      final maxScroll = widget.controller.position.maxScrollExtent;

      widget.controller.jumpTo(scrollRatio * maxScroll);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    _isDragging = false;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_syncThumbWithScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            widget.child,

            /// Track
            Positioned(
              right: 2,
              top: 0,
              bottom: 0,
              child: Container(
                width: widget.thumbWidth,
                color: widget.trackColor.withOpacity(0.2),
              ),
            ),

            /// Thumb
            Positioned(
              right: 2,
              top: _thumbTop,
              child: GestureDetector(
                onVerticalDragUpdate: _onDragUpdate,
                onVerticalDragEnd: _onDragEnd,
                child: Container(
                  width: widget.thumbWidth,
                  height: widget.thumbHeight,
                  decoration: BoxDecoration(
                    color: widget.thumbColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
