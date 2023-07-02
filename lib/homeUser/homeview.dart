import 'package:flutter/material.dart';
import '../homeUser/homebg.dart';
import '../homeUser/widgets.dart';

List<Map<String, dynamic>> listmerek = [
  {
    "gambarmerek":
        "https://awsimages.detik.net.id/community/media/visual/2020/10/26/logo-logo-pabrikan-mobil-otomotif-13.png?w=800"
  }
];

class homeviewbg extends StatelessWidget {
  const homeviewbg({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        homebackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              Container(
                padding:
                    EdgeInsets.only(right: 15, left: 15, top: 20, bottom: 10),
                child: TextField(
                    decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 05.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "Cari Merek Mobil",
                  prefixIcon: Icon(
                    Icons.search,
                    size: 27,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {},
                  ),
                )),
              ),
              Container(
                  padding:
                      EdgeInsets.only(top: 10, right: 5, left: 5, bottom: 5),
                  child: Text(
                    "Merek Mobil",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
              listmerekmobil(),
              listmobil(),
            ],
          ),
        ),
      ],
    );
  }
}

class listmobil extends StatelessWidget {
  const listmobil({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detailbrg',
                arguments: {'id': 'bkzby6ax7kisyyqAA59F'},
              );
            },
            child: Container(
              margin: EdgeInsets.all(10),
              width: 300,
              height: 200,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Center(
                child: Text("data 1"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class listmerekmobil extends StatelessWidget {
  // final String gambarmerek;
  const listmerekmobil({
    super.key,
    // required this.gambarmerek
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            width: 80,
            height: 80,
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://awsimages.detik.net.id/community/media/visual/2020/10/26/logo-logo-pabrikan-mobil-otomotif-13.png?w=800")),
                borderRadius: BorderRadius.circular(15),
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
