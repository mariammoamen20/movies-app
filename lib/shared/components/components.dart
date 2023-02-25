import 'package:flutter/material.dart';
import 'package:movie_app/models/popular_movies_model.dart';
import 'package:movie_app/shared/styles/icon_broken.dart';

import '../styles/colors.dart';

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

//video player section
//assets/images/movie.png
Widget videoPlayerItem({required String image}) {
  return Stack(
    alignment: Alignment.center,
    children:  [
      Image(
        image: NetworkImage(image),
        fit: BoxFit.cover,
      ),
      const Image(
        image: AssetImage(
          'assets/images/play_button_1.png',
        ),
        fit: BoxFit.cover,
      ),
    ],
  );
}


Widget defaultText({
  required String text,
  required Color color,
  required double fontSize,
  required FontWeight fontWeight,
  TextOverflow textOverflow = TextOverflow.ellipsis,
  int maxLine = 1,
}) {
  return Text(
    text,
    maxLines: maxLine,
    style: TextStyle(
      overflow: textOverflow,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}



