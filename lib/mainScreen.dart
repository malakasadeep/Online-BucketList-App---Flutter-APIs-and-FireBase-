import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> bucketlist = [];
  Future<void> getData() async {
    try {
      Response response = await Dio().get(
          "https://flutter-fire-62db0-default-rtdb.firebaseio.com/list.json");
      print(response);
      setState(() {
        bucketlist = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BucketList App"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: getData,
            child: Text("Get Data"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: bucketlist.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(bucketlist[index]["image"] ?? ""),
                    ),
                    title: Text(bucketlist[index]["item"] ?? ""),
                    trailing: Text(bucketlist[index]["cost"].toString() ?? "0"),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
