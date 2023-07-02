// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class updateDeleteMobil extends StatefulWidget {
  const updateDeleteMobil({super.key});

  @override
  State<updateDeleteMobil> createState() => _updateDeleteMobilState();
}

class _updateDeleteMobilState extends State<updateDeleteMobil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 114, 24, 63),
      body: Stack(
        children: [
          TextField(
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                hintText: "Cari Data Mobil",
                prefixIcon: Icon(
                  Icons.search,
                  size: 27,
                )),
          ),
          // StreamBuilder<QuerySnapshot>(
          //     stream: FirebaseFirestore.instance
          //         .collection('dataMobil')
          //         .snapshots(),
          //     builder: (BuildContext context,
          //         AsyncSnapshot<QuerySnapshot> snapshot) {
          //       if (snapshot.hasError) {
          //         return Center(
          //           child: Text('Error: ${snapshot.error}'),
          //         );
          //       }

          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }
          //       if (snapshot.hasData) {
          //         return ListView.builder(
          //           itemCount: snapshot.data!.docs.length,
          //           itemBuilder: (BuildContext context, int index) {
          //             DocumentSnapshot document = snapshot.data!.docs[index];
          //             String Brand = document['Brand'];
          //             String Merek = document['Merek'];

          //             return ListTile(
          //               title: Text(Brand),
          //               subtitle: Text(Merek),
          //             );
          //           },
          //         );
          //       }
          //       return Center(
          //         child: Text('No data available'),
          //       );
          //     })
        ],
      ),
    );
  }
}
