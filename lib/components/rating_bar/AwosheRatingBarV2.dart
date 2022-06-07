import 'package:flutter/material.dart';

class AwosheRatingBarV2 extends StatefulWidget {
  final int starCount;
  final double rating;
  final bool editable;
  final ValueChanged<double> onRatingChanged;
  final Color color;
  final Color borderColor;
  final double size;
  final bool allowHalfRating;

  AwosheRatingBarV2(
      {this.starCount = 5,
        this.rating = 0.0,
        this.editable = false,
        this.onRatingChanged,
        this.color,
        this.borderColor,
        this.size,
        this.allowHalfRating = true});

  @override
  _AwosheRatingBarV2State createState() => _AwosheRatingBarV2State();
}

class _AwosheRatingBarV2State extends State<AwosheRatingBarV2> {

  double rating;

  @override
  void initState(){
    rating = widget.rating ?? 3.5;
    super.initState();
  }

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border,
        color: widget.borderColor ?? Theme.of(context).primaryColor,
        size: widget.size ?? 25.0,
      );
    }

    else if (index >= rating - (widget.allowHalfRating ? 0.5 : 1.0) &&
        index <= rating) {
      icon = new Icon(
        Icons.star_half,
        color: widget.color ?? Theme.of(context).primaryColor,
        size: widget.size ?? 25.0,
      );
    }
    else {
      icon = new Icon(
        Icons.star,
        color: widget.color ?? Theme.of(context).primaryColor,
        size: widget.size ?? 25.0,
      );
    }

    if (!widget.editable)
      return icon;

    return new GestureDetector(
      onTap: () {
        setState(() {
          if (widget.onRatingChanged != null){
            rating = index + 1.0;
            widget.onRatingChanged(rating);
          }
        });
      },

      onHorizontalDragUpdate: (dragDetails) {
        RenderBox box = context.findRenderObject();
        var _pos = box.globalToLocal(dragDetails.globalPosition);
        var i = _pos.dx / widget.size;

        setState(() {
          rating = widget.allowHalfRating ? i.abs() : i.round().toDouble();
          if (rating > widget.starCount) {
            rating = widget.starCount.toDouble();
          }

          if (rating < 0) {
            rating = 0.0;
          }

          if (widget.onRatingChanged != null)
            widget.onRatingChanged(rating);
        });

      },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.transparent,
      child: new Wrap(
          alignment: WrapAlignment.start,
          children: new List.generate(
              widget.starCount, (index) => buildStar(context, index ))),
    );
  }
}
