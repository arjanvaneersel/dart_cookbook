import 'package:flutter/material.dart';
import 'package:news/src/screens/news_detail.dart';
import 'blocs/stories_provider.dart';
import 'blocs/comments_provider.dart';
import 'screens/news_list.dart';
import 'screens/news_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: CommentsProvider(
        child: MaterialApp(
          title: 'News',
          onGenerateRoute: routes,
        ),
      ), 
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/')
      return MaterialPageRoute(
        builder: (context) { 
          final bloc = StoriesProvider.of(context);
          bloc.fetchTopIds();
          
          return NewsList();
        },
      );
    
    return MaterialPageRoute(
      builder: (context) {
        final id = int.parse(settings.name.replaceFirst('/', ''));
        final bloc = CommentsProvider.of(context);
        
        bloc.fetchItemWithComments(id);
        return NewsDetail(itemId: id);
      },
    );
  }
}
