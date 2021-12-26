import 'package:Postly/core/error/exception.dart';
import 'package:Postly/data/repository/database/hive_service.dart';
import 'package:Postly/features/post/data/data_sources/post_local_data_source.dart';
import 'package:Postly/features/post/data/models/posts/post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockHiveServices extends Mock implements HiveServices {}

main() {
  PostLocalDataSourceImpl postLocalDataSourceImpl;
  MockHiveServices mockHiveServices;
  final postModel = [
    Post(userId: 1, title: 'title', body: "body", id: 1),
    Post(userId: 2, title: 'title', body: "body", id: 2)
  ];

  setUp(() {
    mockHiveServices = MockHiveServices();
    postLocalDataSourceImpl =
        PostLocalDataSourceImpl(hiveRepository: mockHiveServices);
  });

  group('Cache post', () {
    test('Put post in hive', () async {
      postLocalDataSourceImpl.cachePost(postModel);
      verify(mockHiveServices.insertPost(postModel));
      verifyNoMoreInteractions(mockHiveServices);
    });
  });

  group('Get post from local storage', () {
    test('Get post', () async {
      when(mockHiveServices.getHivePost()).thenReturn(postModel);

      var result = await postLocalDataSourceImpl.getLocalPost();

      verify(mockHiveServices.getHivePost());

      expect(result, equals(postModel));
    });

    test(
      'should throw a CacheExeption when there is not a cached value',
      () async {
        // arrange
        when(mockHiveServices.getHivePost()).thenReturn(null);
        // act
        final call = postLocalDataSourceImpl.getLocalPost;
        // assert
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });
}
