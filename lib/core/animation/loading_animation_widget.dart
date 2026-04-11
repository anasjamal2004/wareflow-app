import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimation extends StatelessWidget {
  final Color loadingColor;
  const LoadingAnimation({this.loadingColor = Colors.transparent, super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.waveDots(color: loadingColor, size: 50);
  }
}
