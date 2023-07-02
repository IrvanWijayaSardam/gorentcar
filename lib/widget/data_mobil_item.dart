import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataMobilItem extends StatelessWidget {
  final String id;
  final String text1;
  final String text2;
  final String imageLink;
  final String text3;
  final String text4;
  final String text5;
  final String text6;
  final BuildContext bContext; // Added context as a member variable

  const DataMobilItem({
    Key? key,
    required this.id,
    required this.text1,
    required this.text2,
    required this.imageLink,
    required this.text3,
    required this.text4,
    required this.text5,
    required this.text6,
    required this.bContext, // Added context to the constructor
  }) : super(key: key);

  void deleteFirebaseData(String id) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('dataMobil');

    try {
      await collection.doc(id).delete();

      ScaffoldMessenger.of(bContext).showSnackBar(
        SnackBar(content: Text('Data deleted from Firebase')),
      );
      Navigator.pushNamed(bContext, '/dashboardAdmin');
    } catch (e) {
      ScaffoldMessenger.of(bContext).showSnackBar(
        SnackBar(content: Text('Error deleting values from Firebase')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add your logic here
      },
      child: Card(
        color: Color.fromRGBO(207, 207, 207, 1),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text2,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Card(
              child: Container(
                width: 350.0,
                height: 250.0,
                child: Image.network(
                  imageLink,
                  width: 30.0,
                  height: 30.0,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(text3),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(text4),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(text5),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(text6),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 120, // Set the desired width
                  child: TextButton.icon(
                    onPressed: () {
                      print('id${id}');
                      Navigator.pushNamed(context, '/insertMobil',arguments: {
                          'id': id,
                        },);
                    },
                    icon: Icon(
                        Icons.update), // Add the icon for the Update button
                    label: Text('Update'),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                  ),
                ),
                Container(
                  width: 120, // Set the desired width
                  child: TextButton.icon(
                    onPressed: () {
                      deleteFirebaseData(id); // Call the deleteFirebaseData function
                    },
                    icon: Icon(
                        Icons.delete), // Add the icon for the Delete button
                    label: Text('Delete'),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
