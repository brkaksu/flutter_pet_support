import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginIslemleri extends StatefulWidget {
  @override
  _LoginIslemleriState createState() => _LoginIslemleriState();
}

class _LoginIslemleriState extends State<LoginIslemleri> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        debugPrint('Giriş yapmış bir kullanıcı yok!');
      } else{
        debugPrint('Giriş Yapmış bir kullanıcı var Email: ${_auth.currentUser.email}');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giris Yap"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
                child: Text("Email/Sifree User Create"),
                color: Colors.blueAccent,
                onPressed: _emailSifreKullaniciOlustur),
            RaisedButton(
                child: Text("Email/Sifree User LogIn"),
                color: Colors.greenAccent,
                onPressed: _emailSifreKullaniciGirisYap),
            RaisedButton(
                child: Text("Çıkış Yap"),
                color: Colors.greenAccent,
                onPressed: _cikisYap),

          ],
        ),
      ),
    );
  }

  void _emailSifreKullaniciOlustur() async {
    String _email = "burakaksu576@gmail.com";
    String _password = "password";

    try {
      UserCredential _credential = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
      User _yeniUser = _credential.user;
      await _yeniUser.sendEmailVerification();
      if (_auth.currentUser != null) {
        debugPrint("Size bir mail attık lütfen onaylayın");
        await _auth.signOut();
        debugPrint("Kullanıcıyı sistemden attık");
      }
      debugPrint(_yeniUser.toString());
    } catch (e) {
      debugPrint("***************** HATA VAR ****************");
      debugPrint(e.toString());
    }
  }

  void _emailSifreKullaniciGirisYap() async {
    String _email = "burakaksu576@gmail.com";
    String _password = "password";

    try {
      if (_auth.currentUser == null) {
        User _oturumAcanUser = (await _auth.signInWithEmailAndPassword(email: _email, password: _password)).user;
        debugPrint("Oturum açan kişinin emaili: " + _oturumAcanUser.email);
      } else {
        debugPrint("Oturum açmış kullanıcı zaten var");
      }
    } catch (e) {
      debugPrint("***************** HATA VAR ****************");
      debugPrint(e.toString());
    }
  }


  void _cikisYap() async {
    try {
      // sistemde kullanıcı varsa çıkış yap
      if (_auth.currentUser != null) {
        debugPrint("${_auth.currentUser.email} sistemden çıkıyor");
        await _auth.signOut();
      } else {
        // sistemde zaten bir kullanıcı yoksa sorun yok
        debugPrint("Zaten oturum açmış bir kullanıcı yok");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
