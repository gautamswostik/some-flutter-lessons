import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluuter_boilerplate/application/infinite_list/infinite_list_bloc.dart';
import 'package:fluuter_boilerplate/infrastructure/infinite_list_repo/entites/post_model.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key, required this.posts, required this.isfetching})
      : super(key: key);
  final List<PostModel> posts;
  final bool isfetching;
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        BlocProvider.of<InfiniteListBloc>(context)
            .add(GetPosts(posts: widget.posts, isInitialFetch: false));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: <Widget>[
          ...widget.posts
              .map(
                (post) => Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.black,
                    width: 2,
                  )),
                  child: ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                  ),
                ),
              )
              .toList(),
          widget.isfetching
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
