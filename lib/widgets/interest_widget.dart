import 'package:flutter/material.dart';

class InterestWidget extends StatefulWidget {
  final String interest;
  final Color colorSelected, color, textColor;

  const InterestWidget({Key key,this.textColor, this.interest, this.color, this.colorSelected}) : super(key: key);

  @override
  _InterestWidgetState createState() => _InterestWidgetState();
}

class _InterestWidgetState extends State<InterestWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      showCheckmark: false,
      padding: EdgeInsets.all(10.0),
      label: Text(widget.interest),
      labelStyle: TextStyle(color: widget.textColor, fontSize: 17.0),
      selected: _isSelected,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      // backgroundColor: widget.color.withOpacity(0.2),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey[400]),
          borderRadius: BorderRadius.circular(20.0)
      ),
      elevation: 10,
      shadowColor: Colors.grey,
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: widget.colorSelected,
    );
  }
}