import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news/src/widgets/loading_container.dart';
import '../models/item_model.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final int depth;
  final Map<int, Future<ItemModel>> itemMap;

  Comment({this.depth, this.itemId, this.itemMap});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) return LoadingContainer();

        final children = <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(
              left: 16.0 * (depth + 1), 
              right: 16.0
            ),
            title: buildText(snapshot.data),
            subtitle: snapshot.data.by == '' ? Text('(deleted comment)') : Text(snapshot.data.by),
          ),
          Divider(),
        ];

        snapshot.data.kids.forEach((kidId) {
          children.add(Comment(depth: depth + 1, itemId: kidId, itemMap: itemMap));
        });

        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(ItemModel item) {
    final text = item.text
      .replaceAll('&#x27;', '\'')
      .replaceAll('&quot;', '"')
      .replaceAll('<p>', '\n\n')
      .replaceAll('</p>', '');

      return Text(text);
  }

}