import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:gorentcar/menuedit/menuedit.dart';
import 'package:image_picker/image_picker.dart';

class tambahMobil extends StatefulWidget {
  const tambahMobil({super.key});

  @override
  State<tambahMobil> createState() => _tambahMobilState();
}

class _tambahMobilState extends State<tambahMobil> {
  String? idMobil;
  File? _image1;
  File? _image2;
  String? _uploadGambar1;
  String? _uploadGambar2;

  String appBarName = 'Tambah Data Mobil';

  final TextEditingController merekController = TextEditingController();
  final TextEditingController typemobilController = TextEditingController();
  final TextEditingController ccController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this._checkArguments();
  }

  void _checkArguments() {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    idMobil = arguments?['id'] as String? ?? null;
    if (idMobil != null) {
      fetchData();
      appBarName = 'Update data mobil';
    }
    print(idMobil);
  }

  Future<void> fetchData() async {
    QuerySnapshot dataMobilSnapshot = await FirebaseFirestore.instance
        .collection('dataMobil')
        .where(FieldPath.documentId, isEqualTo: idMobil)
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
        final dataBrandLogo = data['BrandLogo'];
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
          ccController.text = datacc.toString();
          hargaController.text = dataHarga.toString();
          merekController.text = dataMerek.toString();
          typemobilController.text = dataBrand.toString();
          _uploadGambar1 = dataBrandLogo.toString();
          _uploadGambar2 = dataGambar.toString();
          pilihPintu = datadoor.toString();
          ftWifi = datawifi;
          ftSensor = datasensor;
          ftBluetooth = databluetooth;
        });
      }
    } else {
      print('No documents found');
    }
  }

  void kosongkan() {
    setState(() {
      typemobilController.clear();
      merekController.clear();
      ccController.clear();
      hargaController.clear();
      stockController.clear();
      pilihPintu = '';
      ftWifi = false;
      ftSensor = false;
      ftBluetooth = false;
    });
  }

  Future<void> _pickImage(ImageSource source, int imageIndex) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: source);

    setState(() {
      if (pickedImage != null) {
        if (imageIndex == 1) {
          _image1 = File(pickedImage.path);
        } else if (imageIndex == 2) {
          _image2 = File(pickedImage.path);
        }
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String?> _uploadImageToFirebase(File? imageFile) async {
    if (imageFile == null) {
      return null;
    }

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('images/${DateTime.now()}.jpg');
    UploadTask uploadTask = ref.putFile(imageFile);

    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
    String imageUrl = await snapshot.ref.getDownloadURL();

    return imageUrl;
  }

  File? file;
  ImagePicker image = ImagePicker();
  String pilihPintu = '';
  String pilihSeats = '';
  bool ftWifi = false;
  bool ftSensor = false;
  bool ftBluetooth = false;

  Future<void> addToFirebase() async {
    if (_image1 == null || _image2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both images')),
      );
      return;
    }

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref1 = storage.ref().child('images/${DateTime.now()}_1.jpg');
    UploadTask uploadTask1 = ref1.putFile(_image1!);

    Reference ref2 = storage.ref().child('images/${DateTime.now()}_2.jpg');
    UploadTask uploadTask2 = ref2.putFile(_image2!);

    await Future.wait([uploadTask1, uploadTask2]);

    String imageUrl1 = await ref1.getDownloadURL();
    String imageUrl2 = await ref2.getDownloadURL();

    CollectionReference collection =
        FirebaseFirestore.instance.collection('dataMobil');

    try {
      await collection.add({
        'BrandLogo': imageUrl1,
        'GambarMobil': imageUrl2,
        'Brand': typemobilController.text,
        'Merek': merekController.text,
        'CC': int.tryParse(ccController.text) ?? 0,
        'Stock': int.tryParse(stockController.text) ?? 0,
        'Harga': int.tryParse(hargaController.text) ?? 0,
        'Door': pilihPintu,
        'Wifi': ftWifi,
        'Sensor': ftSensor,
        'Bluetooth': ftBluetooth,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data added to Firebase')),
      );
      Navigator.pushNamed(context, '/dashboardAdmin');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding values to Firebase')),
      );
    }
  }

  Future<void> updateFirebaseData(String id) async {
    bool isImage1Updated = _image1 != null;
    bool isImage2Updated = _image2 != null;

    FirebaseStorage storage = FirebaseStorage.instance;

    String imageUrl1;
    if (isImage1Updated) {
      Reference ref1 = storage.ref().child('images/${DateTime.now()}_1.jpg');
      UploadTask uploadTask1 = ref1.putFile(_image1!);
      await uploadTask1;
      imageUrl1 = await ref1.getDownloadURL();
    } else {
      imageUrl1 = _uploadGambar1!;
    }

    String imageUrl2;
    if (isImage2Updated) {
      Reference ref2 = storage.ref().child('images/${DateTime.now()}_2.jpg');
      UploadTask uploadTask2 = ref2.putFile(_image2!);
      await uploadTask2;
      imageUrl2 = await ref2.getDownloadURL();
    } else {
      imageUrl2 = _uploadGambar2!;
    }

    CollectionReference collection =
        FirebaseFirestore.instance.collection('dataMobil');

    try {
      Map<String, dynamic> updateData = {
        'Brand': typemobilController.text,
        'Merek': merekController.text,
        'CC': int.tryParse(ccController.text) ?? 0,
        'Stock': int.tryParse(stockController.text) ?? 0,
        'Harga': int.tryParse(hargaController.text) ?? 0,
        'Door': pilihPintu,
        'Wifi': ftWifi,
        'Sensor': ftSensor,
        'Bluetooth': ftBluetooth,
      };

      if (isImage1Updated) {
        updateData['BrandLogo'] = imageUrl1;
      }
      if (isImage2Updated) {
        updateData['GambarMobil'] = imageUrl2;
      }

      await collection.doc(id).update(updateData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data updated in Firebase')),
      );
      Navigator.pushNamed(context, '/dashboardAdmin');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating values in Firebase')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference admins = firestore.collection('dataMobil');
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 35),
          child: Text(
            appBarName,
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 166, 15, 98),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: ListView(
        padding: EdgeInsets.only(left: 5, right: 5),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text('Brand Logo'),
                  GestureDetector(
                    onTap: () => _pickImage(ImageSource.gallery, 1),
                    child: Container(
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: _image1 != null
                            ? Image.file(
                                _image1!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              )
                            : _uploadGambar1 != null
                                ? Image.network(
                                    _uploadGambar1!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  )
                                : Icon(Icons.upload_file, size: 30),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text('Gambar Mobil'),
                  GestureDetector(
                    onTap: () => _pickImage(ImageSource.gallery, 2),
                    child: Container(
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: _image2 != null
                            ? Image.file(
                                _image2!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              )
                            : _uploadGambar2 != null
                                ? Image.network(
                                    _uploadGambar2!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  )
                                : Icon(Icons.upload_file, size: 30),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  SizedBox(
                    width: 300,
                    height: 40,
                    child: TextField(
                      controller: typemobilController,
                      decoration: InputDecoration(
                        label: Text("Type Mobil"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  SizedBox(
                    width: 300,
                    height: 40,
                    child: TextField(
                      controller: merekController,
                      decoration: InputDecoration(
                        label: Text("Merek"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  SizedBox(
                    width: 300,
                    height: 40,
                    child: TextField(
                      controller: stockController,
                      decoration: InputDecoration(
                        label: Text("Plat Nomor"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  SizedBox(
                    width: 300,
                    height: 40,
                    child: TextField(
                      controller: ccController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Text("Fitur cc"),
                          border: OutlineInputBorder()),
                    ),
                  )
                ],
              ),
              const Text("Jumlah Pintu"),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                            title: const Text("2"),
                            value: "2",
                            groupValue: pilihPintu,
                            onChanged: (jumlahPintu) {
                              setState(() {
                                pilihPintu = jumlahPintu!;
                              });
                            }),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                            title: const Text("4"),
                            value: "4",
                            groupValue: pilihPintu,
                            onChanged: (String? jumlahPintu) {
                              setState(() {
                                pilihPintu = jumlahPintu!;
                              });
                            }),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                            title: const Text("5"),
                            value: "5",
                            groupValue: pilihPintu,
                            onChanged: (String? jumlahPintu) {
                              setState(() {
                                pilihPintu = jumlahPintu!;
                              });
                            }),
                      )
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  const Text("Fitur Lainnya"),
                  Row(
                    children: [
                      SizedBox(
                        height: 10,
                        width: 20,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Checkbox(
                                checkColor: Colors.white,
                                value: ftWifi,
                                onChanged: (bool? value) {
                                  setState(() {
                                    ftWifi = value!;
                                  });
                                }),
                            const Text("Wifi")
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Checkbox(
                                checkColor: Colors.white,
                                value: ftSensor,
                                onChanged: (bool? value) {
                                  setState(() {
                                    ftSensor = value!;
                                  });
                                }),
                            const Text("Sensor")
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Checkbox(
                                checkColor: Colors.white,
                                value: ftBluetooth,
                                onChanged: (bool? value) {
                                  setState(() {
                                    ftBluetooth = value!;
                                  });
                                }),
                            const Text("Bluetooth")
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                width: 300,
                height: 40,
                child: TextField(
                  controller: hargaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text("Harga"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (idMobil == null) {
                          admins.add({
                            if (typemobilController.text.isNotEmpty &&
                                merekController.text.isNotEmpty &&
                                ccController.text.isNotEmpty &&
                                stockController.text.isNotEmpty &&
                                hargaController.text.isNotEmpty &&
                                _image1 != null &&
                                _image2 != null &&
                                pilihPintu != null &&
                                ftWifi != null &&
                                ftSensor != null &&
                                ftBluetooth != null)
                              {
                                addToFirebase(),
                              }
                            else
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Please fill in all fields')),
                                ),
                              }
                          });
                        } else {
                          updateFirebaseData(idMobil!);
                        }
                      },
                      child: Text(idMobil != null ? 'Update' : 'Simpan'),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 136, 32, 89),
                          onPrimary: const Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                    ),
                    ElevatedButton(
                      onPressed: kosongkan,
                      child: Text('Kosong'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
