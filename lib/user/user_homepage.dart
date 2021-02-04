import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Oylama Ekranı

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  List<String> isimler = List();
  int voit = 0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("User Home Page"),
          centerTitle: true,
        ),

        body: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width:  375,
                height: 35,
                margin: EdgeInsets.all(6.0),

                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red[500],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        'Kalan Oy Hakkı: 6',
                        style: TextStyle(
                            color: Colors.red[500],
                            fontSize: 18),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 385,
                height: 550,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: Colors.green, width: 1),
                ),
                child: ListView.builder(
                  itemBuilder: _urunler,
                  itemCount: isimler.length,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  onPressed: _elemanEkle,
                  child: Text("Yardım Oluştur"),
                ),

              ],
            ),
          ],
        )
    );
  }
  Widget _urunler(BuildContext context, int index) {
    return Card(
      color: Colors.white70,
      child: ListTile(
        leading: Icon(Icons.add_location),
        title: Text("şehirim Ben"),
        subtitle: Text("Kullanıcı Açıklama"),
        trailing: Icon(Icons.add),
      ),
    );
  }
  void _elemanEkle (){
    setState(() {
      counterVote();
      isimler.add("Card ${voit}");

    });
  }
  void counterVote (){
    voit ++ ;
  }
}
