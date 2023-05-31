import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:personal_challenge/src/core/util/numbers.dart';
import 'package:personal_challenge/src/domain/entity/movie_entity.dart';
import '../../core/util/api_service.dart';
import '../../core/util/assets.dart';
import '../../core/util/strings.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.movie,
  }) : super(
          key: key,
        );

  final MovieEntity movie;

  void _showDialogFavoriteMovie(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return FittedBox(
          child: AlertDialog(
            backgroundColor: const Color(
              Numbers.colorBackground,
            ),
            title: SizedBox(
              width: Numbers.extraMediumSizedBox,
              child: Text(
                movie.title,
                style: const TextStyle(
                  fontSize: Numbers.secondMediumFontSize,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            content: Row(
              children: [
                SizedBox(
                  width: Numbers.mediumSizedBox,
                  height: Numbers.mediumSizedBox,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: '${ApiService.imageNetwork}${movie.posterPath}',
                    placeholder: (
                      context,
                      url,
                    ) =>
                        Image.asset(
                      Assets.imageDefaultThumb,
                      fit: BoxFit.fill,
                    ),
                    errorWidget: (
                      context,
                      url,
                      error,
                    ) =>
                        Image.asset(
                      Assets.imageErrorMovie,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: Numbers.secondSmallPadding,
                        top: Numbers.firstSmallPadding,
                        bottom: Numbers.firstSmallPadding,
                      ),
                      child: Text(
                        Strings.movieCarDescription,
                        style: TextStyle(
                          fontSize: Numbers.firstMediumFontSizeYY,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: Numbers.secondSmallPadding,
                        right: Numbers.secondSmallPadding,
                      ),
                      child: SizedBox(
                        width: Numbers.mediumSizedBox,
                        height: Numbers.extraSmallSizedBox,
                        child: SingleChildScrollView(
                          child: Wrap(
                            children: [
                              Text(
                                movie.overview,
                                style: const TextStyle(
                                  fontSize: Numbers.firstMediumFontSize,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color(
                      Numbers.colorAppBar,
                    ),
                  ),
                ),
                child: const Text(
                  Strings.movieCarCloseButton,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(
            Numbers.firstSmallPadding,
          ),
          child: SizedBox(
            width: Numbers.smallSizedBox,
            height: Numbers.shortSizedBox,
            child: FittedBox(
              child: Text(
                movie.title,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: Numbers.smallSizedBox,
          height: Numbers.extraShortSizedBox,
          child: InkWell(
            onTap: () {
              _showDialogFavoriteMovie(context);
            },
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: '${ApiService.imageNetwork}${movie.posterPath}',
              placeholder: (
                context,
                url,
              ) =>
                  Image.asset(
                Assets.imageDefaultThumb,
                fit: BoxFit.fill,
              ),
              errorWidget: (
                context,
                url,
                error,
              ) =>
                  Image.asset(
                Assets.imageErrorMovie,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
