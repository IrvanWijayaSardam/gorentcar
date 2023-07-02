import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileAdminScreen extends StatefulWidget {
  const ProfileAdminScreen({Key? key}) : super(key: key);

  @override
  _ProfileAdminScreenState createState() => _ProfileAdminScreenState();
}

class _ProfileAdminScreenState extends State<ProfileAdminScreen> {
  late String currentUserId;

  @override
  void initState() {
    super.initState();
    // Get the currently logged-in user ID
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      currentUserId = currentUser.uid;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchData() async {
    final userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where(FieldPath.documentId, isEqualTo: currentUserId)
        .get();
    return userSnapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/adminprofilebg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            children: [
              // Image Widget
              Image.asset(
                "images/profile.png",
                width: 100,
                height: 100,
              ),

              // TextView
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final data = snapshot.data!.docs.first.data();
                      final phoneNumber = data['hp'] as String?;
                      return Text(
                        phoneNumber ?? '',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return Text('No data');
                    }
                  },
                ),
              ),

              // Card with ElevatedButtons
              Container(
                width: 360, // Set the desired width
                height: 400,
                margin: const EdgeInsets.only(top: 60.0),
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child: SizedBox(
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/dashboardAdmin");
                            },
                            child: Text("Dashboard"),
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 54, 35, 109),
                              onPrimary:
                                  const Color.fromARGB(255, 255, 255, 255),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/menuEdit");
                          },
                          child: Text("Edit Barang"),
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 54, 35, 109),
                            onPrimary: const Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your logic here
                          },
                          child: Text("Transaksi"),
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 54, 35, 109),
                            onPrimary: const Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 360, // Set the desired width
                height: 70,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/loginPage');
                  },
                  child: Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.logout,
                        size: 30.0,
                      ),
                      title: Text(
                        "Keluar",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
