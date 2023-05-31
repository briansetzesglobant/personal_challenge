import 'package:flutter/material.dart';
import '../../core/util/assets.dart';
import '../../core/util/numbers.dart';
import '../../core/util/strings.dart';

class FavoriteMovieAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const FavoriteMovieAppBar({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Size get preferredSize => const Size.fromHeight(
        Numbers.favoriteMoviePreferredSizeHeight2,
      );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (
        BuildContext context,
        BoxConstraints constraints,
      ) {
        return ColoredBox(
          color: const Color(
            Numbers.colorAppBar,
          ),
          child: Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: Numbers.firstSmallPaddingYY,
                    top:
                        constraints.maxWidth > Numbers.mediumConstraintsMaxWidth
                            ? Numbers.firstSmallPadding
                            : Numbers.thirdSmallPadding,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(
                        Strings.homeRoute,
                      );
                    },
                    child: Image(
                      image: const AssetImage(
                        Assets.imageBackArrow,
                      ),
                      width: constraints.maxWidth >
                              Numbers.mediumConstraintsMaxWidth
                          ? Numbers.mediumImageSize
                          : Numbers.secondMediumPadding,
                      height: constraints.maxWidth >
                              Numbers.mediumConstraintsMaxWidth
                          ? Numbers.mediumImageSize
                          : Numbers.secondMediumPadding,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    Strings.favoriteMovieAppBarTitle,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: constraints.maxWidth >
                              Numbers.mediumConstraintsMaxWidth
                          ? Numbers.firstBigPadding
                          : Numbers.firstMediumFontSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
