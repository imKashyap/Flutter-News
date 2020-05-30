import 'package:flutter/material.dart';
import 'storiesBloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc = StoriesBloc();
  StoriesProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static StoriesBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StoriesProvider)
            as StoriesProvider)
        .bloc;
  }
}
