import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluuter_boilerplate/infrastructure/infinite_list_repo/entites/post_model.dart';
import 'package:fluuter_boilerplate/infrastructure/infinite_list_repo/infinite_list_repo.dart';

part 'infinite_list_event.dart';
part 'infinite_list_state.dart';

class InfiniteListBloc extends Bloc<InfiniteListEvent, InfiniteListState> {
  GetPostsRepository getPosts;
  int page = 1;
  InfiniteListBloc({required this.getPosts}) : super(InfiniteListInitial()) {
    on<InfiniteListEvent>((event, emit) {});
    on<GetPosts>(
      (event, emit) async {
        if (event.isInitialFetch) {
          emit(InfiniteListLoading());
        }

        final posts = await getPosts.getPosts(page: page);
        emit(
          posts.fold(
            (error) => InifiniteListError(error: error),
            (posts) {
              List<PostModel> allPosts = [...?event.posts, ...posts];
              if (allPosts.length == 100) {
                return InifiniteListLoaded(
                  posts: allPosts,
                  isfetching: false,
                );
              }
              return InifiniteListLoaded(
                posts: allPosts,
                isfetching: true,
              );
            },
          ),
        );
        page++;
      },
    );
  }
}
