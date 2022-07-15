import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluuter_boilerplate/application/infinite_list/infinite_list_bloc.dart';
import 'package:fluuter_boilerplate/infrastructure/infinite_list_repo/infinite_list_repo.dart';
import 'package:mockito/mockito.dart';

import '../mocks/app_mocks.mocks.dart';

void main() {
  group(
    'Testing Infinite Bloc',
    () {
      late InfiniteListBloc mockInfiniteListBloc;
      late GetPostsRepository mockGetPostsRepository;
      setUp(() {
        mockInfiniteListBloc = MockInfiniteListBloc();
        mockGetPostsRepository = MockGetPostsRepository();
      });
      test(
        'The InfiniteListBloc should emit InfiniteListInitial as its initial state',
        () {
          when(mockInfiniteListBloc.state).thenReturn(InfiniteListInitial());

          expect(mockInfiniteListBloc.state, isA<InfiniteListInitial>());

          verify(mockInfiniteListBloc.state);
        },
      );

      blocTest<InfiniteListBloc, InfiniteListState>(
        'Should add note and emit [InfiniteListLoading , InifiniteListLoaded] when AddLocalNote',
        setUp: () {
          when(mockGetPostsRepository.getPosts(page: 1))
              .thenAnswer((_) async => const Right([]));
        },
        build: () => InfiniteListBloc(
          getPosts: mockGetPostsRepository,
        ),
        act: (bloc) =>
            bloc.add(const GetPosts(posts: [], isInitialFetch: true)),
        expect: () => [isA<InfiniteListLoading>(), isA<InifiniteListLoaded>()],
        verify: (bloc) {
          mockGetPostsRepository.getPosts(page: 1);
        },
      );
    },
  );
}
