import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fhe_template/state_util.dart';
import '../view/home_view.dart';

class HomeController extends State<HomeView> implements MvcController {
  static late HomeController instance;
  late HomeView view;

  addProduct() async {
    try {
      await FirebaseFirestore.instance.collection("products").add({
        "product_name": "ProductXXX",
        "price": 25,
      });
    } catch (e) {
      debugPrint("status: data kosong");
    }
  }

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
