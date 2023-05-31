import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_challenge/src/core/use_case/use_case_interface.dart';
import 'package:personal_challenge/src/domain/entity/movies_list_entity.dart';
import 'package:personal_challenge/src/domain/use_case/implementation/movie_use_case.dart';
import '../../core/resource/data_state.dart';
import '../../domain/use_case/implementation/get_favorite_movie_use_case.dart';
import '../../domain/use_case/implementation/insert_favorite_movie_use_case.dart';

final movieProvider = FutureProvider.family
    .autoDispose<DataState<MoviesListEntity>, String>((ref, nameMovie) async {
  final provider = ref.watch(movieUseCaseProvider);
  return await provider(nameMovie: nameMovie);
});

final insertFavoriteMovieProvider =
    FutureProvider.family<void, int>((ref, id) async {
  final provider = ref.watch(insertFavoriteMovieUseCaseProvider);
  await provider(id: id);
});

final getFavoriteMovieProvider =
    FutureProvider.autoDispose<DataState<MoviesListEntity>>((ref) async {
  final provider = ref.watch(getFavoriteMovieUseCaseProvider);
  return await provider();
});

final movieUseCaseProvider = StateProvider<UseCaseInterface>((ref) {
  return MovieUseCase();
});

final insertFavoriteMovieUseCaseProvider =
    StateProvider<UseCaseInterface>((ref) {
  return InsertFavoriteMovieUseCase();
});

final getFavoriteMovieUseCaseProvider = StateProvider<UseCaseInterface>((ref) {
  return GetFavoriteMovieUseCase();
});
