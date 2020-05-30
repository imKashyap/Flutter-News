import 'package:flutter/material.dart';
import 'package:news/src/blocs/storiesProvider.dart';
import 'package:news/src/models/itemModels.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;
  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if(!snapshot.hasData)
          return Text('Still Loading');
        return FutureBuilder(
          future:snapshot.data[itemId],
          builder: (BuildContext context,
              AsyncSnapshot<ItemModel> itemSnapshot){
            if(!itemSnapshot.hasData)return Text('Still Loading $itemId');
            return Text(itemSnapshot.data.title);
          },
        );
      },
    );
  }
}
