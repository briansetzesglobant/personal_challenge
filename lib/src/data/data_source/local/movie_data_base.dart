import 'package:firebase_database/firebase_database.dart';
import 'package:personal_challenge/src/core/util/strings.dart';
import '../../../domain/entity/movie_entity.dart';
import '../../model/movie.dart';

class MovieDatabase {
  MovieDatabase._privateConstructor();

  static final MovieDatabase instance = MovieDatabase._privateConstructor();

  static final FirebaseDatabase _instanceRealtime = FirebaseDatabase.instance;

  static final DatabaseReference _movieTable =
      _instanceRealtime.ref().child(Strings.movieDatabaseNameTable);

  static final DatabaseReference _favoriteMovieTable =
      _instanceRealtime.ref().child(Strings.favoriteMovieDatabaseNameTable);

  Future<void> dropMovieTable() async => await _movieTable.remove();

  Future<void> insertMovie(MovieEntity movie) async {
    await _movieTable.push().set(
          Movie(
            posterPath: movie.posterPath,
            adult: movie.adult,
            overview: movie.overview,
            releaseDate: movie.releaseDate,
            genreIds: movie.genreIds,
            id: movie.id,
            originalTitle: movie.originalTitle,
            originalLanguage: movie.originalLanguage,
            title: movie.title,
            backdropPath: movie.backdropPath,
            popularity: movie.popularity,
            voteCount: movie.voteCount,
            video: movie.video,
            voteAverage: movie.voteAverage,
          ).toJson(),
        );
  }

  Future<List<MovieEntity>> getMovies(List<int> listId) async {
    List<MovieEntity> moviesList = [];
    DataSnapshot dataSnapshotMovie = await _movieTable.get();
    if (dataSnapshotMovie.exists) {
      for (var id in listId) {
        moviesList.add(
          Movie.fromJson(
            dataSnapshotMovie.children
                .where((elementMovie) =>
                    (elementMovie.value
                        as Map<String, dynamic>)[Strings.movieDatabaseId] ==
                    id)
                .first
                .value as Map<String, dynamic>,
          ),
        );
      }
    }
    return moviesList;
  }

  Future<List<MovieEntity>> getMoviesBySearch(String nameMovie) async {
    List<MovieEntity> moviesList = [];
    DataSnapshot dataSnapshotMovie = await _movieTable.get();
    if (dataSnapshotMovie.exists && nameMovie.isNotEmpty) {
      moviesList.addAll(dataSnapshotMovie.children
          .where((elementMovie) => ((elementMovie.value
                      as Map<String, dynamic>)[Strings.movieDatabaseTitle]
                  as String)
              .toLowerCase()
              .contains(nameMovie.toLowerCase()))
          .map(
            (elementMovie) => Movie.fromJson(
              elementMovie.value as Map<String, dynamic>,
            ),
          ));
    }
    return moviesList;
  }

  Future<void> dropFavoriteMovieTable() async =>
      await _favoriteMovieTable.remove();

  Future<void> insertFavoriteMovieId(int id) async {
    await _favoriteMovieTable.push().set(
          id,
        );
  }

  Future<List<MovieEntity>> getFavoriteMovies() async {
    List<MovieEntity> moviesList = [];
    DataSnapshot dataSnapshotFavoriteMovie = await _favoriteMovieTable.get();
    DataSnapshot dataSnapshotMovie = await _movieTable.get();
    if (dataSnapshotFavoriteMovie.exists && dataSnapshotMovie.exists) {
      for (var elementId in dataSnapshotFavoriteMovie.children) {
        moviesList.add(
          Movie.fromJson(
            dataSnapshotMovie.children
                .where((elementMovie) =>
                    (elementMovie.value
                        as Map<String, dynamic>)[Strings.movieDatabaseId] ==
                    elementId.value as int)
                .first
                .value as Map<String, dynamic>,
          ),
        );
      }
    }
    return moviesList;
  }
}
