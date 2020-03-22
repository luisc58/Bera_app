
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Test example
class Post {
  final String title;
  final String description;
  Post(this.title, this.description);
}

Future<List<Post>> search(String search) async {
  await Future.delayed(Duration(seconds: 2));
  return List.generate(search.length, (int index) {
    return Post(
      "Title : $search $index",
      "Description : :$search $index",
    );
  });
}
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SearchBar<Post>(
            searchBarStyle: SearchBarStyle(
              backgroundColor: Colors.white70,
              padding: EdgeInsets.only(left: 10)
            ),
            onSearch: search,
            onItemFound: (Post post, int index) {
              return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.description),
              );
            },
          ),
        ),
      )
    );
  }
}