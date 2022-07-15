part of 'infinite_list_bloc.dart';

abstract class InfiniteListEvent extends Equatable {
  const InfiniteListEvent();

  @override
  List<Object> get props => [];
}

class GetPosts extends InfiniteListEvent {
  final List<PostModel>? posts;
  final bool isInitialFetch;

  const GetPosts({required this.posts, required this.isInitialFetch});

  @override
  List<Object> get props => [posts!, isInitialFetch];
}
