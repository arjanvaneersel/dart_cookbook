import 'dart:convert';

import 'package:news/src/resources/news_api_provider.dart';
import 'package:test_api/test_api.dart';
// import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('FetchTopIds returns a list of ids', () async {
    final expected = [1,2,3,4];
    
    final api = NewsApiProvider();
    api.client = MockClient((r) async {
      return Response(json.encode(expected), 200);
    });

    final got = await api.fetchTopIds();
    expect(got, expected);
  });

  test('FetchItem returns an item model', () async {
    final api = NewsApiProvider();
    api.client = MockClient((r) async {
      return Response(json.encode({
        'by' : 'dhouston',
        'descendants' : 71,
        'id' : 123,
        'kids' : [ 8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940, 9067, 8908, 9055, 8865, 8881, 8872, 8873, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8878, 8870, 8980, 8934, 8876 ],
        'score' : 111,
        'time' : 1175714200,
        'title' : 'My YC app: Dropbox - Throw away your USB drive',
        'type' : 'story',
        'url' : 'http://www.getdropbox.com/u/2/screencast.html'
      }), 200);
    });

    final got = await api.fetchItem(123);
    expect(got.id, 123);
  });
}