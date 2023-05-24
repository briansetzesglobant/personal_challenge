import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/util/assets.dart';
import '../../core/util/numbers.dart';
import '../../core/util/strings.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({
    Key? key,
    required this.onChanged,
  }) : super(
          key: key,
        );

  final Function(String) onChanged;

  @override
  Size get preferredSize => const Size.fromHeight(
        Numbers.homePreferredSizeHeight,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (
        BuildContext context,
        BoxConstraints constraints,
      ) {
        return ColoredBox(
          color: Numbers.colorAppBar,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: constraints.maxWidth > Numbers.smallConstraintsMaxWidth
                      ? Numbers.thirdSmallPaddingYY
                      : Numbers.firstSmallPaddingYY,
                  right: constraints.maxWidth > Numbers.smallConstraintsMaxWidth
                      ? Numbers.thirdSmallPadding
                      : Numbers.firstSmallPaddingYY,
                ),
                child: Text(
                  Strings.homeAppBarSearch,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize:
                        constraints.maxWidth > Numbers.bigConstraintsMaxWidth
                            ? Numbers.thirdMediumFontSize
                            : Numbers.thirdSmallFontSize,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                width: constraints.maxWidth > Numbers.bigConstraintsMaxWidth
                    ? Numbers.bigContainerWidth
                    : Numbers.smallContainerWidth,
                height: constraints.maxWidth > Numbers.bigConstraintsMaxWidth
                    ? Numbers.bigContainerHeight
                    : Numbers.smallContainerHeight,
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize:
                        constraints.maxWidth > Numbers.bigConstraintsMaxWidth
                            ? Numbers.thirdSmallFontSize
                            : Numbers.firstSmallFontSizeYY,
                  ),
                  onSubmitted: (nameMovie) {
                    onChanged(nameMovie);
                  },
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed(
                          Strings.favoriteMoviePageRoute,
                        );
                      },
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: Numbers.paddingYY,
                            right: Numbers.secondSmallPadding,
                            bottom: Numbers.paddingYY,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: const AssetImage(
                                  Assets.imageFavoriteMovie,
                                ),
                                width: constraints.maxWidth >
                                        Numbers.bigConstraintsMaxWidth
                                    ? Numbers.bigImageSize
                                    : Numbers.smallImageSize,
                                height: constraints.maxWidth >
                                        Numbers.bigConstraintsMaxWidth
                                    ? Numbers.bigImageSize
                                    : Numbers.smallImageSize,
                              ),
                              Text(
                                Strings.favoriteMovieAppBarTitle,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: constraints.maxWidth >
                                          Numbers.bigConstraintsMaxWidth
                                      ? Numbers.secondSmallFontSizeYY
                                      : Numbers.firstSmallFontSizeXX,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
