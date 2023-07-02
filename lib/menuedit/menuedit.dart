import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../menudataMobil/updateDeleteData.dart';
import '../menutambahBarang/tambahMobil.dart';

class menuEdit extends StatefulWidget {
  const menuEdit({super.key});

  @override
  State<menuEdit> createState() => _menuEditState();
}

class _menuEditState extends State<menuEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/adminbg.jpeg"), fit: BoxFit.cover)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => tambahMobil()),
                      );
                    },
                    child: Text("Tambah Barang"),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 54, 35, 109),
                        onPrimary: const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => updateDeleteMobil()),
                      );
                    },
                    child: Text("Data Mobil"),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 54, 35, 109),
                        onPrimary: const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
