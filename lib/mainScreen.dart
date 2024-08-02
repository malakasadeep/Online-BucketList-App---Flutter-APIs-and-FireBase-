import 'package:bucketlist_app/addBucketList.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> bucketlist = [];
  bool isloading = false;
  Future<void> getData() async {
    try {
      isloading = true;
      setState(() {});
      Response response = await Dio().get(
          "https://flutter-fire-62db0-default-rtdb.firebaseio.com/list.json");
      print(response);
      setState(() {
        bucketlist = response.data;
      });
      isloading = false;
    } catch (e) {
      isloading = false;
      setState(() {});
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddBucketList();
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("BucketList App"),
        actions: [
          InkWell(
            onTap: () {
              getData();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.refresh),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getData();
        },
        child: isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
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
                      trailing:
                          Text(bucketlist[index]["cost"].toString() ?? "0"),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
