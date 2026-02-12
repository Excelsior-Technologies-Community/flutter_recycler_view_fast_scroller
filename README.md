# 🚀 Custom Fast Scroller (Flutter)

A lightweight, dependency-free Fast Scroller widget for Flutter that provides draggable scroll thumb functionality similar to Android’s RecyclerView FastScroller.

Built using pure Flutter (ScrollController + Stack) — fast, flexible, and fully customizable.

---

## ✨ Features

✅ Draggable vertical thumb

✅ Syncs with ListView scroll position

✅ Fully customizable thumb size & color

✅ Customizable track design

✅ Works with ListView & GridView

✅ No third-party dependencies

✅ Lightweight & reusable
---

## ✨ Preview







https://github.com/user-attachments/assets/6d15ea14-ae58-491d-bc5f-808621c81cd1




---

## ✨ Installation
Add this to your package's pubspec.yaml file:
```
dependencies:
  custom_fast_scroller:
    path: ../custom_fast_scroller

```
▶️ From GitHub
```
dependencies:
  custom_fast_scroller:
    git:
      url: https://github.com/yourusername/custom_fast_scroller.git

```
Then Run:
```
flutter pub get
```
## 📁 Folder Structure
```
custom_fast_scroller/
│
├── lib/
│   ├── custom_fast_scroller.dart
│   │
│   └── demo/
│       └── fast_scroller_demo.dart
│
├── example/
│   └── lib/
│       └── main.dart
│
├── test/
│   └── custom_fast_scroller_test.dart
│
├── README.md
├── CHANGELOG.md
├── LICENSE
├── analysis_options.yaml
└── pubspec.yaml

  ```
## 🚀 Usage 
```

import 'package:flutter/material.dart';
import 'package:custom_fast_scroller/custom_fast_scroller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserFastScrollerScreen(),
    );
  }
}

class UserFastScrollerScreen extends StatefulWidget {
  const UserFastScrollerScreen({super.key});

  @override
  State<UserFastScrollerScreen> createState() =>
      _UserFastScrollerScreenState();
}

class _UserFastScrollerScreenState
    extends State<UserFastScrollerScreen> {

  final ScrollController _scrollController = ScrollController();

  final List<String> products =
      List.generate(300, (index) => "Product ${index + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products List"),
        centerTitle: true,
      ),
      body: CustomFastScroller(
        controller: _scrollController,
        thumbColor: Colors.orange,
        trackColor: Colors.black,
        thumbHeight: 80,
        thumbWidth: 10,
        radius: 12,
        alwaysVisible: true,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 6),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Text(
                    "${index + 1}",
                    style:
                        const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(products[index]),
                subtitle:
                    const Text("Fast scroll enabled"),
              ),
            );
          },
        ),
      ),
    );
  }
}

```
## 📜 License
MIT License
```
Copyright (c) 2025 Excelsior Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy  
of this software and associated documentation files (the "Software"), to deal  
in the Software without restriction, including without limitation the rights  
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
copies of the Software, and to permit persons to whom the Software is  
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all  
copies or substantial portions of the Software.

