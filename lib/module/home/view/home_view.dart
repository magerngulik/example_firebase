import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fhe_template/core.dart';
import '../controller/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  Widget build(context, HomeController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () => controller.addProduct(),
            icon: const Icon(
              Icons.add,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("products")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return const Text("Error");
                  if (snapshot.data == null) return Container();
                  if (snapshot.data!.docs.isEmpty) {
                    return const Text("No Data");
                  }
                  final data = snapshot.data!;
                  return ListView.builder(
                    itemCount: data.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> item =
                          (data.docs[index].data() as Map<String, dynamic>);
                      item["id"] = data.docs[index].id;
                      return Card(
                        child: ListTile(
                          title: Text("${item['product_name']}"),
                          subtitle: Text("${item['price']}"),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            FutureBuilder(
              future: Dio().get(
                "https://reqres.in/api/users",
                options: Options(
                  contentType: "application/json",
                ),
              ),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) return Container();
                Response response = snapshot.data;
                Map obj = response.data;
                List items = obj["data"];

                return ListView.builder(
                  itemCount: items.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var item = items[index];

                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          backgroundImage: NetworkImage(
                            item["avatar"],
                          ),
                        ),
                        title: Text("${item["first_name"]}"),
                        subtitle: Text("${item["email"]}"),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<HomeView> createState() => HomeController();
}
