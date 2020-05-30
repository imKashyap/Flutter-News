import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:news/src/models/itemModels.dart';
import '../repository.dart';

class ApiProvider implements Source{
  final String _root='https://hacker-news.firebaseio.com/v0';
  Client client=Client();
  Future<List<int>> fetchTopIds() async {
    var response = await client.get( '$_root/topstories.json?');
    final ids=json.decode(response.body);
    return ids;
  }

  Future<ItemModel> fetchItem(int id) async{
    var response= await client.get('$_root/user/$id.json?');
    final parsedJson=json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}
