import 'package:flutter/material.dart';
import 'package:flutter_recycler_view_fast_scroller/Recycler%20View%20Fast%20Scroller/custom_fast_scroller.dart';

class FastScrollerDemo extends StatefulWidget {
  const FastScrollerDemo({super.key});

  @override
  State<FastScrollerDemo> createState() => _FastScrollerDemoState();
}

class _FastScrollerDemoState extends State<FastScrollerDemo> {
  final ScrollController _scrollController = ScrollController();

  final List<String> items =
  List.generate(200, (index) => "Item ${index + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Fast Scroller Demo"),
        centerTitle: true,
      ),
      body: CustomFastScroller(
        controller: _scrollController,
        thumbColor: Colors.deepPurple,
        trackColor: Colors.grey,
        thumbHeight: 70,
        thumbWidth: 10,
        radius: 12,
        alwaysVisible: true,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              margin:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: Text(
                    "${index + 1}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(items[index]),
                subtitle: const Text("Scrollable content"),
              ),
            );
          },
        ),
      ),
    );
  }
}
