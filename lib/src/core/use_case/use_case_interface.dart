import 'package:personal_challenge/src/domain/entity/movie_entity.dart';

abstract class UseCaseInterface<T> {
  Future<T> call({
    String? nameMovie,
    MovieEntity? movie,
  });
}
