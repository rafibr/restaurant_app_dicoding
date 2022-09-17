import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final Duration duration;
  final double direction;
  final double period;
  final double intensity;
  final double opacity;
  final Color color;

  const ShimmerLoader({
    required this.child,
    required this.isLoading,
    this.duration = const Duration(milliseconds: 1000),
    this.direction = 1.0,
    this.period = 0.0,
    this.intensity = 0.5,
    this.opacity = 0.5,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                color: Colors.white,
              ),
              title: Container(
                width: 100,
                height: 20,
                color: Colors.white,
              ),
              subtitle: Container(
                width: 50,
                height: 20,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
