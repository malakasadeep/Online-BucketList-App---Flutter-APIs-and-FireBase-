import 'package:flutter/material.dart';

class AddBucketList extends StatefulWidget {
  const AddBucketList({super.key});

  @override
  State<AddBucketList> createState() => _AddBucketListState();
}

class _AddBucketListState extends State<AddBucketList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add BucketList"),
      ),
    );
  }
}
