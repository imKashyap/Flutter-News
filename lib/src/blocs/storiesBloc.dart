import 'package:news/src/models/itemModels.dart';
import 'package:news/src/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {

  Stream<Map<int,Future<ItemModel>>> items;
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _items= BehaviorSubject<int>();

  Stream<List<int>> get topIds => _topIds.stream;
  Function(int) get fetchItem=>_items.sink.add;

  StoriesBloc(){
    items= _items.stream.transform(_itemsTransformer());
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _itemsTransformer(){
    return ScanStreamTransformer(
        (Map<int, Future<ItemModel>>cache, int id,_){
            cache[id]=_repository.fetchItem(id);
            return cache;
        },
      <int ,Future<ItemModel>>{}
    );
  }

  dispose() {
    _topIds.close();
    _items.close();
  }
}
