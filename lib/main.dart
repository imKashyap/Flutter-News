import 'package:flutter/material.dart';
import 'package:news/src/blocs/storiesProvider.dart';
import 'newsList.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        home: NewsList(),
        title: 'News',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

