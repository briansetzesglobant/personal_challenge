import 'package:personal_challenge/src/core/util/numbers.dart';
import '../../core/resource/data_state.dart';
import '../../core/util/strings.dart';
import '../../domain/entity/movie_entity.dart';
import '../../domain/entity/movies_list_entity.dart';
import '../data_source/local/movie_data_base.dart';
import '../data_source/remote/movie_api_service.dart';
import '../../domain/repository/repository_interface.dart';

class MovieRepository extends RepositoryInterface {
  final MovieApiService movieApiService = MovieApiService();
  final MovieDatabase movieDataBase = MovieDatabase.instance;

  @override
  Future<DataState<MoviesListEntity>> getMoviesList(String nameMovie) async {
    DataState<MoviesListEntity> moviesList =
        await movieApiService.getMoviesList(nameMovie);
    switch (moviesList.type) {
      case DataStateType.success:
        try {
          for (var movie in moviesList.data!) {
            await movieDataBase.insertMovie(movie);
          }
          return DataSuccess(
            moviesList.data!.copyWith(
              results: await movieDataBase.getMovies(
                  moviesList.data!.map((movie) => movie.id).toList()),
            ),
          );
        } catch (exception) {
          return DataFailed(
            '${Strings.errorMessage} ${exception.toString()}',
          );
        }
      case DataStateType.empty:
        return await _getDataOfDataBase(nameMovie);
      case DataStateType.error:
        return await _getDataOfDataBase(nameMovie);
    }
  }

  Future<DataState<MoviesListEntity>> _getDataOfDataBase(
      String nameMovie) async {
    try {
      List<MovieEntity> results =
          await movieDataBase.getMoviesBySearch(nameMovie);
      if (results.isNotEmpty) {
        return DataSuccess(
          MoviesListEntity(
            page: Numbers.moviePageDefaultValue,
            results: results,
            totalResults: Numbers.movieTotalResultsDefaultValue,
            totalPages: Numbers.movieTotalPagesDefaultValue,
          ),
        );
      } else {
        return const DataEmpty();
      }
    } catch (exception) {
      return DataFailed(
        '${Strings.errorMessage} ${exception.toString()}',
      );
    }
  }

  @override
  Future<void> insertFavoriteMovieId(int id) async {
    await movieDataBase.insertFavoriteMovieId(id);
  }

  @override
  Future<DataState<MoviesListEntity>> getFavoriteMovies() async {
    try {
      List<MovieEntity> results = await movieDataBase.getFavoriteMovies();
      if (results.isNotEmpty) {
        return DataSuccess(
          MoviesListEntity(
            page: Numbers.moviePageDefaultValue,
            results: results,
            totalResults: Numbers.movieTotalResultsDefaultValue,
            totalPages: Numbers.movieTotalPagesDefaultValue,
          ),
        );
      } else {
        return const DataEmpty();
      }
    } catch (exception) {
      return DataFailed(
        '${Strings.errorMessage} ${exception.toString()}',
      );
    }
  }
}
