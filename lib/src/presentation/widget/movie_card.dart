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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: Numbers.firstSmallPadding,
            bottom: Numbers.firstSmallPadding,
          ),
          child: Center(
            child: Text(
              movie.title,
              style: const TextStyle(
                fontSize: Numbers.thirdSmallFontSize,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: Numbers.smallSizedBox,
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
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: Numbers.firstSmallPadding,
            left: Numbers.secondSmallPadding,
          ),
          child: Text(
            Strings.movieCarDescription,
            style: TextStyle(
              fontSize: Numbers.secondSmallFontSize,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: Numbers.secondSmallPadding,
            right: Numbers.secondSmallPadding,
          ),
          child: SizedBox(
            height: Numbers.shortSizedBox,
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  Text(
                    movie.overview,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
