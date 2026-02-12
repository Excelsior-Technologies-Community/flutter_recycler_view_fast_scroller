import 'package:flutter/material.dart';

class CustomFastScroller extends StatefulWidget {
  final Widget child;
  final ScrollController controller;

  final double thumbWidth;
  final double thumbHeight;
  final Color thumbColor;
  final Color trackColor;
  final double radius;
  final bool alwaysVisible;

  const CustomFastScroller({
    super.key,
    required this.child,
    required this.controller,
    this.thumbWidth = 8,
    this.thumbHeight = 60,
    this.thumbColor = Colors.blue,
    this.trackColor = Colors.grey,
    this.radius = 8,
    this.alwaysVisible = true,
  });

  @override
  State<CustomFastScroller> createState() => _CustomFastScrollerState();
}

class _CustomFastScrollerState extends State<CustomFastScroller> {
  double _thumbTop = 0;
  bool _isDragging = false;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_syncThumbPosition);
  }

  void _syncThumbPosition() {
    if (!widget.controller.hasClients) return;

    if (!_isDragging) {
      final maxScroll = widget.controller.position.maxScrollExtent;
      final currentScroll = widget.controller.offset;

      if (maxScroll == 0) return;

      final trackHeight = context.size?.height ?? 0;
      final scrollRatio = currentScroll / maxScroll;

      setState(() {
        _thumbTop = scrollRatio * (trackHeight - widget.thumbHeight);
      });
    }

    if (!widget.alwaysVisible) {
      setState(() => _isVisible = true);

      Future.delayed(const Duration(seconds: 1), () {
        if (!_isDragging) {
          setState(() => _isVisible = false);
        }
      });
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    final trackHeight = context.size?.height ?? 0;

    setState(() {
      _isDragging = true;
      _thumbTop += details.delta.dy;

      if (_thumbTop < 0) _thumbTop = 0;
      if (_thumbTop > trackHeight - widget.thumbHeight) {
        _thumbTop = trackHeight - widget.thumbHeight;
      }

      final scrollRatio =
          _thumbTop / (trackHeight - widget.thumbHeight);

      final maxScroll =
          widget.controller.position.maxScrollExtent;

      widget.controller.jumpTo(scrollRatio * maxScroll);
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    _isDragging = false;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_syncThumbPosition);
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
            if (_isVisible)
              Positioned(
                right: 2,
                top: 0,
                bottom: 0,
                child: Container(
                  width: widget.thumbWidth,
                  decoration: BoxDecoration(
                    color: widget.trackColor.withOpacity(0.2),
                    borderRadius:
                    BorderRadius.circular(widget.radius),
                  ),
                ),
              ),

            /// Thumb
            if (_isVisible)
              Positioned(
                right: 2,
                top: _thumbTop,
                child: GestureDetector(
                  onVerticalDragUpdate: _handleDragUpdate,
                  onVerticalDragEnd: _handleDragEnd,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: widget.thumbWidth,
                    height: widget.thumbHeight,
                    decoration: BoxDecoration(
                      color: widget.thumbColor,
                      borderRadius:
                      BorderRadius.circular(widget.radius),
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
