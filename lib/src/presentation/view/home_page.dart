import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:personal_challenge/src/domain/entity/movie_entity.dart';
import '../../core/resource/data_state.dart';
import '../../core/util/api_service.dart';
import '../../core/util/assets.dart';
import '../../core/util/numbers.dart';
import '../../core/util/strings.dart';
import '../../domain/entity/movies_list_entity.dart';
import '../widget/home_app_bar.dart';
import '../provider/movie_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  String search = Strings.homePageEmptySearch;

  Widget _swiper(List<MovieEntity> movies) {
    return SizedBox(
      width: Numbers.bigSizedBox,
      height: Numbers.extraBigSizedBox,
      child: Swiper(
        itemBuilder: (
          BuildContext context,
          int index,
        ) {
          return FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: Numbers.secondSmallPadding,
                  ),
                  child: SizedBox(
                    width: Numbers.extraBigSizedBox,
                    height: Numbers.extraBigSizedBox,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      placeholder: (
                        context,
                        url,
                      ) =>
                          Image.asset(
                        Assets.imageDefaultThumb,
                        fit: BoxFit.fill,
                      ),
                      imageUrl:
                          '${ApiService.imageNetwork}${movies[index].posterPath}',
                      errorWidget: (
                        context,
                        url,
                        error,
                      ) =>
                          Image.asset(
                        Assets.imageDefaultThumb,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: Numbers.firstSmallPadding,
                  ),
                  child: SizedBox(
                    width: Numbers.extraBigSizedBox,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            ref.watch(
                                insertFavoriteMovieProvider(movies[index].id));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Color(
                                  Numbers.colorAppBar,
                                ),
                                content: Text(
                                  Strings.homePageSnackBar,
                                  style: TextStyle(
                                    fontSize: Numbers.thirdSmallFontSize,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(
                                Numbers.colorAppBar,
                              ),
                            ),
                          ),
                          child: const AutoSizeText(
                            Strings.homePageAddButton,
                            style: TextStyle(
                              fontSize: Numbers.firstBigFontSize,
                            ),
                            maxLines: Numbers.autoSizeTextMaxLines,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: Numbers.thirdSmallFontSize,
                    bottom: Numbers.thirdSmallFontSize,
                  ),
                  child: SizedBox(
                    width: Numbers.extraBigSizedBox,
                    child: Center(
                      child: AutoSizeText(
                        movies[index].title,
                        style: const TextStyle(
                          fontSize: Numbers.thirdBigFontSize,
                        ),
                        maxLines: Numbers.autoSizeTextMaxLines,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: movies.length,
        viewportFraction: Numbers.viewportFraction,
        scale: Numbers.scale,
        pagination: const SwiperPagination(),
        control: const SwiperControl(
          color: Color(
            Numbers.colorAppBar,
          ),
          size: Numbers.swiperControl,
        ),
      ),
    );
  }

  Widget _getPage(DataState<MoviesListEntity> moviesList) {
    switch (moviesList.type) {
      case DataStateType.success:
        return _swiper(moviesList.data!.results);
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
                    Strings.emptyMessage,
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
                  width: Numbers.extraShortSizedBox,
                  height: Numbers.extraShortSizedBox,
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

  void _executeSearch(String param) {
    setState(() {
      search = param;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(movieProvider(search));
    return Scaffold(
      appBar: HomeAppBar(
        onChanged: _executeSearch,
      ),
      body: Container(
        color: const Color(
          Numbers.colorBackground,
        ),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: provider.when(
            data: (data) => _getPage(data),
            error: (e, __) => Center(
              child: FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: Numbers.extraShortSizedBox,
                      height: Numbers.extraShortSizedBox,
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
                        maxLines: Numbers.autoSizeTextMaxLines,
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
      ),
    );
  }
}
