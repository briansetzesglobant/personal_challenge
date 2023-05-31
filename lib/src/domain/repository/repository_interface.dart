import '../../core/resource/data_state.dart';
import '../entity/movies_list_entity.dart';

abstract class RepositoryInterface {
  Future<DataState<MoviesListEntity>> getMoviesList(String nameMovie);

  Future<void> insertFavoriteMovieId(int id);

  Future<DataState<MoviesListEntity>> getFavoriteMovies();
}
