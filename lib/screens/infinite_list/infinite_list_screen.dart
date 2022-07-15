import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluuter_boilerplate/application/infinite_list/infinite_list_bloc.dart';
import 'package:fluuter_boilerplate/screens/infinite_list/list_screen.dart';

class InfiniteListScreen extends StatefulWidget {
  const InfiniteListScreen({Key? key}) : super(key: key);

  @override
  State<InfiniteListScreen> createState() => _InfiniteListScreenState();
}

class _InfiniteListScreenState extends State<InfiniteListScreen> {
  @override
  void initState() {
    BlocProvider.of<InfiniteListBloc>(context)
        .add(const GetPosts(posts: [], isInitialFetch: true));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite List'),
      ),
      body: BlocBuilder<InfiniteListBloc, InfiniteListState>(
        builder: (context, state) {
          if (state is InfiniteListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is InifiniteListLoaded) {
            return ListScreen(
              posts: state.posts,
              isfetching: state.isfetching,
            );
          }
          if (state is InifiniteListError) {
            return Center(
              child: Text(state.error),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
