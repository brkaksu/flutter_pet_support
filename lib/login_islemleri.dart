import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pet_support/user/user_homepage.dart';

class LoginIslemleri extends StatefulWidget {
  @override
  _LoginIslemleriState createState() => _LoginIslemleriState();
}

class _LoginIslemleriState extends State<LoginIslemleri> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _email = "";
  String _password = "";
  var girisKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        debugPrint('Giriş yapmış bir kullanıcı yok!');
      } else {
        debugPrint(
            'Giriş Yapmış bir kullanıcı var Email: ${_auth.currentUser.email}');
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
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: girisKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "Email Giriniz! ",
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.purpleAccent, width: 5),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onSaved: (girilenEmail) {
                  _email = girilenEmail;
                },
                validator: (String girilenVeri) {
                  if (!(girilenVeri.contains("@gmail.com") || girilenVeri.contains("@hotmail.com") || girilenVeri.contains("@outlook.com") || girilenVeri.contains("@bil.omu.edu.tr"))) {
                    return "Lütfen geçerli bir e mail giriniz";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: "Şifre Giriniz! ",
                  labelText: "Şifre",
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.purpleAccent, width: 5),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onSaved: (girilenSifre) {
                  _password = girilenSifre;
                },
                validator: (String girilenVeri){
                  if(girilenVeri.length <= 6 ){
                    return "Şifre 6 karakterden az olamaz";
                  }else{
                    return null;
                  }
                },

              ),
              SizedBox(
                height: 10,
              ),

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
      ),
    );
  }

  void _emailSifreKullaniciOlustur() async {
    String _email = "burakaksu576@gmail.com";
    String _password = "password";

    try {
      UserCredential _credential = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
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
    girisKey.currentState.save();
    girisKey.currentState.validate();

    try {
      if (_auth.currentUser == null) {
        User _oturumAcanUser = (await _auth.signInWithEmailAndPassword(
                email: _email, password: _password))
            .user;
        debugPrint("Oturum açan kişinin emaili: " + _oturumAcanUser.email);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>UserHomePage()));
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
