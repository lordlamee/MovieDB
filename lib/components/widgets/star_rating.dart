import 'package:flutter/material.dart';

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;
  final double iconSize;

  StarRating(
      {this.starCount = 5,
      this.iconSize,
      this.rating = .0,
      this.onRatingChanged,
      this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border,
        size: iconSize,
        color: Theme.of(context).accentColor,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half,
        size: iconSize,
        color: color ?? Theme.of(context).accentColor,
      );
    } else {
      icon = new Icon(
        Icons.star,
        size: iconSize,
        color: color ?? Theme.of(context).accentColor,
      );
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children:
            new List.generate(starCount, (index) => buildStar(context, index)));
  }
}
