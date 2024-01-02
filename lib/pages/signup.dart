import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodDeliveryApp/admin/admin_login.dart';
import 'package:foodDeliveryApp/pages/bottomnav.dart';
import 'package:foodDeliveryApp/pages/login.dart';
import 'package:foodDeliveryApp/service/database.dart';
import 'package:foodDeliveryApp/service/shared_pref.dart';
import 'package:foodDeliveryApp/widgets/widget_support.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "";

  TextEditingController namecontroller = new TextEditingController();

  TextEditingController passwordcontroller = new TextEditingController();

  TextEditingController mailcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Registrado con éxito",
            style: TextStyle(fontSize: 18.0),
          ),
        )));
        String Id = randomAlphaNumeric(10);
        Map<String, dynamic> addUserInfo = {
          "Name": namecontroller.text,
          "Email": mailcontroller.text,
          "Wallet": "0",
          "Id": Id,
        };
        await DatabaseMethods().addUserDetail(addUserInfo, Id);
        await SharedPreferenceHelper().saveUserName(namecontroller.text);
        await SharedPreferenceHelper().saveUserEmail(mailcontroller.text);
        await SharedPreferenceHelper().saveUserWallet('0');
        await SharedPreferenceHelper().saveUserId(Id);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNav()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'Contraseña debil') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "La contraseña proporcionada es demasiado débil",
                style: TextStyle(fontSize: 18.0),
              )));
        } else if (e.code == "correo electrónico ya en uso") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "La cuenta ya existe",
                style: TextStyle(fontSize: 18.0),
              )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color(0xFFff5c30),
                  Color(0xFFe74b1a),
                ])),
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Text(""),
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/logo.png",
                      width: MediaQuery.of(context).size.width / 1.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Form(
                        key: _formkey,
                        child: Column(children: [
                          SizedBox(height: 30.0),
                          Text(
                            "Sign up",
                            style: AppWidget.HeadlineTextFeildStyle(),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            controller: namecontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese el nombre';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Nombre',
                                hintStyle: AppWidget.semiBooldTextFeildStyle(),
                                prefixIcon: Icon(Icons.person_outline)),
                          ),
                          SizedBox(height: 30.0),
                          TextFormField(
                            controller: mailcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese el E-mail';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: AppWidget.semiBooldTextFeildStyle(),
                                prefixIcon: Icon(Icons.email_outlined)),
                          ),
                          SizedBox(height: 30.0),
                          TextFormField(
                            controller: passwordcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese la contraseña';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: AppWidget.semiBooldTextFeildStyle(),
                                prefixIcon: Icon(Icons.password_outlined)),
                          ),
                          SizedBox(height: 80.0),
                          GestureDetector(
                            onTap: () async {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  email = mailcontroller.text;
                                  name = namecontroller.text;
                                  password = passwordcontroller.text;
                                });
                              }
                              registration();
                            },
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Color(0xffff5722),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Text(
                                    "SIGN UP",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontFamily: 'Poppins1',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LogIn()));
                    },
                    child: Text(
                      "Already have an account? Login",
                      style: AppWidget.semiBooldTextFeildStyle(),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminLogin()));
                    },
                    child: Text(
                      "Admin",
                      style: AppWidget.LightTextFeildStyle(),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
