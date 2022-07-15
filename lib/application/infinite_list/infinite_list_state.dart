part of 'infinite_list_bloc.dart';

abstract class InfiniteListState extends Equatable {
  const InfiniteListState();

  @override
  List<Object> get props => [];
}

class InfiniteListInitial extends InfiniteListState {}

class InfiniteListLoading extends InfiniteListState {}

class InifiniteListLoaded extends InfiniteListState {
  final List<PostModel> posts;
  final bool isfetching;

  const InifiniteListLoaded({required this.posts, required this.isfetching});

  @override
  List<Object> get props => [posts, isfetching];
}

class InifiniteListError extends InfiniteListState {
  final String error;

  const InifiniteListError({required this.error});

  @override
  List<Object> get props => [error];
}
