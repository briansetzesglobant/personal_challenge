import 'package:firebase_database/firebase_database.dart';
import 'package:personal_challenge/src/core/util/strings.dart';
import '../../../domain/entity/movie_entity.dart';
import '../../model/movie.dart';

class FavoriteMovieDatabase {
  FavoriteMovieDatabase._privateConstructor();

  static final FavoriteMovieDatabase instance =
      FavoriteMovieDatabase._privateConstructor();

  static final FirebaseDatabase _instanceRealtime = FirebaseDatabase.instance;

  static final DatabaseReference _favoriteMovieStructure =
      _instanceRealtime.ref().child(Strings.favoriteMovieDatabaseName);

  Future<void> dropFavoriteMovieTable() async =>
      await _favoriteMovieStructure.remove();

  Future<void> insertFavoriteMovie(MovieEntity movie) async {
    await _favoriteMovieStructure.push().set(
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

  Future<List<MovieEntity>> getFavoriteMovies() async {
    List<MovieEntity> moviesList = [];
    DataSnapshot dataSnapshot = await _favoriteMovieStructure.get();
    if (dataSnapshot.exists) {
      for (var element in dataSnapshot.children) {
        moviesList.add(
          Movie.fromJson(
            element.value as Map<String, dynamic>,
          ),
        );
      }
    }
    return moviesList;
  }
}
