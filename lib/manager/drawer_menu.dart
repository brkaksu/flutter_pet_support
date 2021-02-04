import 'package:flutter/material.dart';


class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Burak Aksu"),
            accountEmail: Text("burakaksu576@gmail.com"),
            currentAccountPicture: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/ekran2.png"),
                )
              ),
            ),
          ),
          InkWell(
            child: ListTile(
              leading: Icon(Icons.add_business_outlined),
              title: Text("Ürün Islemleri"),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
          InkWell(
            child: ListTile(
              leading: Icon(Icons.add_business_outlined),
              title: Text("Kurye Islemleri"),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
    );
  }
}
