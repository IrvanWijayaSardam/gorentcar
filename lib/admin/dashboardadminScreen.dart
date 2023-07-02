import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widget/data_mobil_item.dart';

class DashboardAdminScreen extends StatelessWidget {
  const DashboardAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bgadmdashboard.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 64,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, '/adminHome');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 220.0,
              bottom: 120.0,
              left: 10.0,
              right: 10.0,
            ),
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('dataMobil')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final itemList = snapshot.data!.docs;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: itemList.length,
                    itemBuilder: (context, index) {
                      final item = itemList[index];
                      final documentId = item.reference.id;

                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: SizedBox(
                          width: 370,
                          height: 200,
                          child: DataMobilItem(
                            id: documentId.toString(),
                            text1: "${item['Brand']} ${item['Merek']}" ?? '',
                            text2: "Rp. ${item['Harga']} / H" ?? '',
                            imageLink: item['GambarMobil'] ?? '',
                            text3: "Bluetooth: ${item['Bluetooth']}" ?? '',
                            text4: "Sensor: ${item['Sensor'].toString()}" ?? '',
                            text5: "Jumlah Pintu: ${item['Door']}" ?? '',
                            text6: "Wifi: ${item['Wifi']}" ?? '',
                            bContext: context,
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/insertMobil');
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
