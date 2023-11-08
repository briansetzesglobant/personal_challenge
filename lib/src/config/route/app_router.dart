import 'package:auto_route/auto_route.dart';
import '../../core/util/strings.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, path: Strings.homeRoute, initial: true),
        AutoRoute(
            page: FavoriteMovieRoute.page,
            path: Strings.favoriteMoviePageRoute),
      ];
}
