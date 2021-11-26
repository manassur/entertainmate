import 'package:flutter/material.dart';

class RoundedContainerBg extends StatelessWidget {
  final Widget child;
  const RoundedContainerBg({Key key,this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,

    );
  }
}
