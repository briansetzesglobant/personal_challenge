import 'package:flutter/material.dart';
import 'package:personal_challenge/src/presentation/view/favorite_movie_page.dart';
import '../../core/util/strings.dart';
import '../../presentation/view/home_page.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Strings.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case Strings.favoriteMoviePageRoute:
        return MaterialPageRoute(
          builder: (_) => const FavoriteMoviePage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                Strings.appRouteDefault,
              ),
            ),
          ),
        );
    }
  }
}
