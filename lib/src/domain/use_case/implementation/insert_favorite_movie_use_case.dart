import '../../../core/use_case/use_case_interface.dart';
import '../../../data/repository/movie_repository.dart';

class InsertFavoriteMovieUseCase extends UseCaseInterface<void> {
  final MovieRepository movieRepository = MovieRepository();

  @override
  Future<void> call({
    String? nameMovie,
    int? id,
  }) async {
    await movieRepository.insertFavoriteMovieId(id!);
  }
}
