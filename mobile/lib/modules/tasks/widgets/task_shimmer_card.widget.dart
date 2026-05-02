import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TaskShimmerCardWidget extends StatelessWidget {
  const TaskShimmerCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10),
          height: 80,
        ),
      ),
    );
  }
}
