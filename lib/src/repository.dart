import 'dart:async';
import 'package:news/src/apiProvider/apiProvider.dart';
import 'package:news/src/dbProvider/dbProvider.dart';
import 'package:news/src/models/itemModels.dart';

class Repository{
  List<Source> sources=[
  dbProvider,
  ApiProvider()
  ];

  List<Cache> caches=[
    dbProvider,
  ];

  Future<List<int>> fetchTopIds(){
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async{
    ItemModel item;
    Source source;
    for (source in sources){
      item=await source.fetchItem(id);
      if(item!=null)
        break;
    }

    Cache cache;
    for (cache in caches){
      cache.addItem(item);
    }
    return item;
  }

}

abstract class Source{
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

 abstract class Cache{
   Future<int> addItem(ItemModel item);
}