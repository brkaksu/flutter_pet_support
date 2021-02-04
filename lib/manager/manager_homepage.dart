import 'package:flutter/material.dart';
import 'package:flutter_pet_support/manager/drawer_menu.dart';
import 'package:flutter_pet_support/manager/navigationbar_kuryebilgi.dart';
import 'package:flutter_pet_support/manager/navigationbar_urunbilgi.dart';


class ManagerHomePage extends StatefulWidget {
  @override
  _ManagerHomePageState createState() => _ManagerHomePageState();
}

class _ManagerHomePageState extends State<ManagerHomePage> {
  KuryeBilgi kuryeBilgi;
  UrunBilgi urunbilgi;
  int secilenMenuItem = 0;
  List<Widget> tumSayfalar = List();

  @override
  void initState() {
    super.initState();
    urunbilgi = UrunBilgi();
    kuryeBilgi = KuryeBilgi();
    tumSayfalar  = [urunbilgi,kuryeBilgi];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: AppBar(
        title: Text("Manager Home Page"),
        centerTitle: true,
      ),
      body: tumSayfalar[secilenMenuItem],
      bottomNavigationBar: bottomNavMenu(),
    );
  }

  Theme bottomNavMenu() {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.blue,
      ),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business),
            label: "ÜrünBilgi",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_motorsports_rounded),
            label: "KuryeBilgi",
          ),
        ],
        currentIndex: secilenMenuItem,
        type: BottomNavigationBarType.shifting,
        onTap: (index){
          setState(() {
            secilenMenuItem = index;
          });
        },
      ),
    );
  }
}
