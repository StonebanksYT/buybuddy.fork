import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/Screens/home/dashboard/dashboard.dart';
import 'package:flutter_auth/Screens/home/dashboard/productSection/firebaseStorage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:file_picker/file_picker.dart';

class ProductForm extends StatefulWidget {
  ProductForm({Key? key}) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

 
    final Storage storage = Storage();

  Uint8List? selectedFileInBytes=Uint8List(2);
  Future<void> filePicker()async{
  final results = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ["png", "jpg"]);
// converting picked file into byte data so that it could work on web app
  selectedFileInBytes=results!.files.first.bytes;   
  await storage.uploadFile(selectedFileInBytes, results.files.first.name);
  }
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
            width: 100,
            height: 35,
            child: ElevatedButton(
              /// picking the file and uploading the file on firebase storage
              onPressed: filePicker,
              child: const Text("photos"),
            ),
          ),
          SizedBox(
            height: 35,
            width: 100,
            child: ElevatedButton(
              onPressed: () async {
                /// fireStore setup and adding product data to a particular user
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
                      usersRef.doc(controller.userid.value);
                  CollectionReference productsRef =
                      userDocRef.collection('products');
                  await productsRef.doc().set({
                    'title': title,
                    'price': price,
                    'description': description,
                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  print(e);
                }
              },
              child: const Text("Create Ad"),
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

class CustomImage {
  Uint8List imageData;
  int id;

  CustomImage({required this.imageData, required this.id});
}
