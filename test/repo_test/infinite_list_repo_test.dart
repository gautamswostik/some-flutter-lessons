import 'package:flutter_test/flutter_test.dart';
import 'package:fluuter_boilerplate/infrastructure/infinite_list_repo/infinite_list_repo.dart';

void main() {
  test('infinite_list_repo_test', () async {
    GetPostsRepository getPosts = GetPostsRepository();
    final resp = await getPosts.getPosts(page: 1);
    expect(resp.isRight(), true);
  });
}
