import '../../../core/resource/data_state.dart';
import '../../../core/use_case/use_case_interface.dart';
import '../../../data/repository/movie_repository.dart';
import '../../entity/movies_list_entity.dart';

class MovieUseCase extends UseCaseInterface<DataState<MoviesListEntity>> {
  final MovieRepository movieRepository = MovieRepository();

  @override
  Future<DataState<MoviesListEntity>> call({
    String? nameMovie,
    int? id,
  }) async {
    return await movieRepository.getMoviesList(nameMovie!);
  }
}
