import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../background/detailbg.dart';
import 'dart:io';

class DetailBarangScreen extends StatefulWidget {
  const DetailBarangScreen({super.key});

  @override
  State<DetailBarangScreen> createState() => _DetailBarangScreenState();
}

class _DetailBarangScreenState extends State<DetailBarangScreen> {
  String idBrg = '';
  String brand = '';
  String merek = '';
  String cc = '';
  String wifi = '';
  String bluetooth = '';
  String sensor = '';
  String door = '';
  String harga = '';
  String gambar = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies(){
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    idBrg = arguments?['id'] as String? ?? '';
    fetchData();
  }

  Future<void> fetchData() async {
    QuerySnapshot dataMobilSnapshot = await FirebaseFirestore.instance
        .collection('dataMobil')
        .where(FieldPath.documentId, isEqualTo: idBrg)
        .get();

    // Check if the snapshot contains documents
    if (dataMobilSnapshot.docs.isNotEmpty) {
      // Retrieve the first document in the snapshot
      DocumentSnapshot firstDocument = dataMobilSnapshot.docs.first;

      // Retrieve the data map for the first document
      Map<String, dynamic>? data =
          firstDocument.data() as Map<String, dynamic>?;

      // Check if the data map is not null
      if (data != null) {
        // Retrieve the values you need from the 'data' map
        final dataMerek = data['Merek'];
        final datacc = data['CC'];
        final datawifi = data['Wifi'];
        final databluetooth = data['Bluetooth'];
        final datasensor = data['Sensor'];
        final datadoor = data['Door'];
        final dataHarga = data['Harga'];
        final dataGambar = data['GambarMobil'];
        final dataDoor = data['Door'];
        final dataBrand = data['Brand'];

        // Use the retrieved values as needed
        print('CC: $datacc');
        print('WiFi: $datawifi');
        print('Bluetooth: $databluetooth');
        print('Sensor: $datasensor');
        print('Door: $datadoor');
        print('Gambar: $dataGambar');

        setState(() {
          cc = datacc.toString();
          wifi = datawifi.toString();
          bluetooth = databluetooth.toString();
          sensor = datasensor.toString();
          harga = dataHarga.toString();
          gambar = dataGambar.toString();
          door = dataDoor.toString();
          merek = dataMerek.toString();
          brand = dataBrand.toString();
        });
      }
    } else {
      print('No documents found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        detailbackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(top: 70.0, left: 30.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/userHome');
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 30.0,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(top: 100.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: gambar.isNotEmpty ? Image.network(
                          gambar,
                          fit: BoxFit.cover,
                          width: 250.0,
                          height: 200.0,
                        ) : Icon(Icons.upload_file, size: 30),
                      ),
                      SizedBox(height: 60.0),
                      Text(
                        "${brand.toString()} ${merek.toString()}",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCard("images/cc.png", "CC", cc),
                          _buildCard("images/wifi.png", "WiFi", wifi),
                          _buildCard(
                              "images/bluetooth.png", "Bluetooth", bluetooth),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCard("images/sensor.png", "Sensor", sensor),
                          _buildCard("images/door.png", "Door", door),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                    margin: EdgeInsets.only(bottom: 40.0, left: 30.0),
                    child: Text(
                      "Rp. ${harga}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.only(bottom: 40.0, right: 30.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        "/datareservasi",
                        arguments: {
                          'merek': merek,
                          'brand': brand,
                          'harga': harga
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFE9677),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Proses Sewa",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard(String imagePath, String title, String subtitle) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        color: Color(0xFF3A559F),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(imagePath),
              width: 30.0,
              height: 30.0,
              color: Colors.white,
            ),
            SizedBox(height: 5.0),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
