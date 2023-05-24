import 'package:firebase_database/firebase_database.dart';
import 'package:personal_challenge/src/core/util/strings.dart';
import '../../../domain/entity/movie_entity.dart';
import '../../model/movie.dart';

class MovieDatabase {
  MovieDatabase._privateConstructor();

  static final MovieDatabase instance = MovieDatabase._privateConstructor();

  static final FirebaseDatabase _instanceRealtime = FirebaseDatabase.instance;

  static final DatabaseReference _movieTable =
      _instanceRealtime.ref().child(Strings.movieDatabaseName);

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

  Future<List<MovieEntity>> getMovies() async {
    List<MovieEntity> moviesList = [];
    DataSnapshot dataSnapshot = await _movieTable.get();
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
