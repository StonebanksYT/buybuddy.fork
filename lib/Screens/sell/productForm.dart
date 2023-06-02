import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/controllers/userIdController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProductForm extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  UserIdController userIdController = Get.put(UserIdController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // title,price,description,media, submit btn
          CustomField(titleController),
          CustomField(priceController),
          CustomField(descriptionController),
          SizedBox(
            height: 35,
            width: 100,
            child: ElevatedButton(
              onPressed: () async {
                var title = titleController.text.trim();
                var price = priceController.text.trim();
                var description = descriptionController.text.trim();
                if (title.isEmpty || price.isEmpty || description.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please fill all fields');
                  return;
                }
                try {
                  CollectionReference usersRef =
                      FirebaseFirestore.instance.collection('users');
                  DocumentReference userDocRef =
                      usersRef.doc(userIdController.userid.value);
                  CollectionReference productsRef =
                      userDocRef.collection('products');
                  await productsRef.doc().set({
                    'title': title,
                    'price':price,
                    'description': description,
                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  print(e);
                }
              },
              child: Text("Creat Ad"),
            ),
          )
        ],
      ),
    );
  }

  Widget CustomField(controller) {
    return SizedBox(
      width: 200,
      child: TextFormField(controller: controller),
    );
  }
}
