import 'package:flutter/material.dart';
import 'package:flutter_recycler_view_fast_scroller/Recycler%20View%20Fast%20Scroller/custom_fast_scroller.dart';

class FastScrollerDemo extends StatelessWidget {
  FastScrollerDemo({super.key});

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Custom Fast Scroller")),
      body: CustomFastScroller(
        controller: _controller,
        thumbColor: Colors.deepPurple,
        thumbHeight: 70,
        child: ListView.builder(
          controller: _controller,
          itemCount: 200,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("Item $index"),
            );
          },
        ),
      ),
    );
  }
}
