import 'package:personal_challenge/src/domain/entity/movie_entity.dart';
import '../../core/resource/data_state.dart';
import '../entity/movies_list_entity.dart';

abstract class RepositoryInterface {
  Future<DataState<MoviesListEntity>> getMoviesList(String nameMovie);

  Future<void> insertFavoriteMovie(MovieEntity movie);

  Future<DataState<MoviesListEntity>> getFavoriteMovies();
}
