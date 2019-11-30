import 'dart:io';
import 'dart:async';

import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel itemModel);
  Future<int> clear();
}

class Repository {
  List<Source> sources = <Source>[
    newsDBProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDBProvider,
  ];
  
  Future<List<int>> fetchTopIds() async {
    List<int> results;

    for (var source in sources) {
      results = await source.fetchTopIds();
      if (results != null) break;
    }
    
    return results;
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source;
    
    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) break;
    }

    for (var cache in caches) {
      if (source == cache) continue;
      cache.addItem(item);
    }

    return item;
  }

  clearCache() async {
    for (var cache in caches) await cache.clear();
  }
}