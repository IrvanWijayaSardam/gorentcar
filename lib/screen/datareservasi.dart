import 'package:flutter/material.dart';
import 'package:gorentcar/background/formbg.dart';

class DataReservasiScreen extends StatefulWidget {
  const DataReservasiScreen({Key? key}) : super(key: key);

  @override
  State<DataReservasiScreen> createState() => _DataReservasiScreenState();
}

class _DataReservasiScreenState extends State<DataReservasiScreen> {
  late int total = 0;
  late String merek;
  late String brand;
  late String harga;

  bool _isYaSelected = false;
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nomorHpController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _lamaSewaController = TextEditingController();
  final TextEditingController _metodePembayaranController =
      TextEditingController();
  final TextEditingController _merekController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    merek = arguments?['merek'] as String? ?? '';
    brand = arguments?['brand'] as String? ?? '';
    harga = arguments?['harga'] as String? ?? '';

    _merekController.text = brand.toString();
    _modelController.text = merek.toString();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nomorHpController.dispose();
    _alamatController.dispose();
    _lamaSewaController.dispose();
    _metodePembayaranController.dispose();
    _merekController.dispose();
    _modelController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        formbackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(top: 50.0, left: 30.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/detailbrg');
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 30.0,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 50.0),
                  child: Text(
                    "Data Reservasi",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 160.0, left: 30.0),
                    child: Text(
                      "Lengkapi Data",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(top: 200.0, left: 30.0, right: 30.0),
                    child: TextField(
                      controller: _namaController,
                      decoration: InputDecoration(labelText: "Nama Lengkap"),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(top: 260.0, left: 30.0, right: 30.0),
                    child: TextField(
                      controller: _nomorHpController,
                      decoration: InputDecoration(labelText: "Nomor HP"),
                      keyboardType: TextInputType.number,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(top: 320.0, left: 30.0, right: 30.0),
                    child: TextField(
                      controller: _alamatController,
                      decoration: InputDecoration(labelText: "Alamat"),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(top: 380.0, left: 30.0, right: 30.0),
                    child: TextField(
                      controller: _lamaSewaController,
                      decoration: InputDecoration(labelText: "Lama Sewa"),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (!value.isEmpty) {
                          total = int.parse(value.toString()) *
                              int.parse(harga.toString());
                          setState(() {
                            _hargaController.text = total.toString();
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(top: 440.0, left: 30.0, right: 30.0),
                    child: DropdownButtonFormField<String>(
                      decoration:
                          InputDecoration(labelText: "Metode Pembayaran"),
                      onChanged: (newValue) {
                        setState(() {
                          _metodePembayaranController.text = newValue!;
                        });
                      },
                      items: [
                        DropdownMenuItem<String>(
                          value: "Cash",
                          child: Text("Cash"),
                        ),
                        DropdownMenuItem<String>(
                          value: "Cashless",
                          child: Text("Cashless"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 510.0, left: 30.0),
                    child: Text(
                      "Merek",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 550.0, left: 30.0),
                    child: SizedBox(
                      width: 150.0,
                      child: TextField(
                        controller: _merekController,
                        decoration: InputDecoration(
                          hintText: 'Honda',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 550.0, left: 30.0),
                    child: SizedBox(
                      width: 150.0,
                      child: TextField(
                        controller: _modelController,
                        decoration: InputDecoration(
                          hintText: 'WRV',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 610.0, left: 30.0),
                    child: Text("Layanan Antar"),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 610.0, left: 30.0),
                    child: Row(
                      children: [
                        Radio(
                          value: true,
                          groupValue: _isYaSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              _isYaSelected = value ?? false;
                            });
                          },
                        ),
                        Text("Ya"),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 610.0, left: 30.0),
                    child: Row(
                      children: [
                        Radio(
                          value: false,
                          groupValue: _isYaSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              _isYaSelected = value ?? false;
                            });
                          },
                        ),
                        Text("Tidak"),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 660.0, left: 200.0),
                    child: SizedBox(
                      width: 150.0,
                      child: TextField(
                        controller: _hargaController,
                        decoration: InputDecoration(
                          hintText: 'Rp. 120.000',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: SizedBox(
                    width: 220.0, // Set the desired width
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/verifikasiktp");
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFE9677),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        "Lanjut",
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
        )
      ],
    );
  }
}
