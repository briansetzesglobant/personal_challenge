import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_challenge/src/presentation/provider/movie_provider.dart';
import '../../core/resource/data_state.dart';
import '../../core/util/assets.dart';
import '../../core/util/numbers.dart';
import '../../core/util/strings.dart';
import '../../domain/entity/movie_entity.dart';
import '../../domain/entity/movies_list_entity.dart';
import '../widget/favorite_movie_app_bar.dart';
import '../widget/movie_card.dart';

class FavoriteMoviePage extends ConsumerStatefulWidget {
  const FavoriteMoviePage({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  FavoriteMoviePageState createState() => FavoriteMoviePageState();
}

class FavoriteMoviePageState extends ConsumerState<FavoriteMoviePage> {
  Widget _grid(List<MovieEntity> moviesList) {
    return Padding(
      padding: const EdgeInsets.all(
        Numbers.firstSmallPadding,
      ),
      child: GridView.builder(
        itemCount: moviesList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Numbers.crossAxisCount,
          mainAxisSpacing: Numbers.mainAxisSpacing,
          crossAxisSpacing: Numbers.crossAxisSpacing,
        ),
        itemBuilder: (
          BuildContext context,
          int index,
        ) {
          return GridTile(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: Numbers.borderAll,
                ),
              ),
              child: SingleChildScrollView(
                child: MovieCard(
                  movie: moviesList[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getPage(DataState<MoviesListEntity> moviesList) {
    switch (moviesList.type) {
      case DataStateType.success:
        return _grid(moviesList.data!.results);
      case DataStateType.empty:
        return Center(
          child: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  image: AssetImage(
                    Assets.imageEmptyMovie,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Numbers.secondMediumPadding,
                  ),
                  child: AutoSizeText(
                    Strings.emptyMessageFavorite,
                    style: TextStyle(
                      fontSize: Numbers.secondMediumFontSize,
                    ),
                    maxLines: Numbers.autoSizeTextMaxLines,
                  ),
                ),
              ],
            ),
          ),
        );
      case DataStateType.error:
        return Center(
          child: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: Numbers.mediumSizedBox,
                  height: Numbers.mediumSizedBox,
                  child: Image(
                    image: AssetImage(
                      Assets.imageErrorMovie,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: Numbers.secondMediumPadding,
                  ),
                  child: AutoSizeText(
                    moviesList.error!,
                    style: const TextStyle(
                      fontSize: Numbers.secondMediumFontSize,
                    ),
                    maxLines: Numbers.autoSizeTextMaxLines,
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(getFavoriteMovieProvider);
    return Scaffold(
      appBar: const FavoriteMovieAppBar(),
      body: Container(
        color: Numbers.colorBackground,
        width: double.infinity,
        height: double.infinity,
        child: provider.when(
          data: (data) => _getPage(data),
          error: (e, __) => Center(
            child: FittedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: Numbers.mediumSizedBox,
                    height: Numbers.mediumSizedBox,
                    child: Image(
                      image: AssetImage(
                        Assets.imageErrorMovie,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Numbers.secondMediumPadding,
                    ),
                    child: AutoSizeText(
                      '${Strings.errorMessage} ${e.toString()}',
                      style: const TextStyle(
                        fontSize: Numbers.secondMediumFontSize,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
