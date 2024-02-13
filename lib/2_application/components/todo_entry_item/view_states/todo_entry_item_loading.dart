import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ToDoEntryItemLoading extends StatelessWidget {
  const ToDoEntryItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black38,
      highlightColor: Colors.white,
      child: const ListTile(
        title: Text('Loading Data..'),
        leading: CircularProgressIndicator(),
      ),
    );
  }
}
