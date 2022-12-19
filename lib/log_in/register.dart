import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slacks_test/log_in/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slacks_test/screens/new_bar.dart';

class Log_in extends StatefulWidget {
  const Log_in({Key? key}) : super(key: key);

  @override
  State<Log_in> createState() => _Log_inState();
}

class _Log_inState extends State<Log_in> {
  bool _visible = true;
  final password_controller = TextEditingController();
  final CpassController = TextEditingController();
  final usernumber_controller = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  SharedPreferences? logindata;
  bool? newuser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata!.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => Barnew()));
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernumber_controller.dispose();
    password_controller.dispose();
    emailController.dispose();

    super.dispose();
  }

  var name, email, pass;
  dynamic phone;

  void writedData() async {
    _formkey.currentState?.save();
    var url =
        "https://slack-test-d83b8-default-rtdb.firebaseio.com/" + "Mydata.json";
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          "name": name,
          "phonenumner": phone,
          "email": email,
          "password": pass
        }),
      );
    } catch (e) {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            body: SafeArea(
          child: ListView(children: [
            Stack(
              children: [
                Container(
                    // decoration: BoxDecoration(
                    //   image:DecorationImage(image: AssetImage("assets/images/jeans.png"),
                    //  fit: BoxFit.fill,
                    // ),
                    // ),
                    //         ),
                    // Container(
                    // margin: EdgeInsets.zero,
                    // width: double.infinity,
                    // decoration: BoxDecoration(
                    // color: Colors.white, borderRadius: BorderRadius.circular(50)),
                    // child: Padding(
                    // padding: const EdgeInsets.all(30),
                    // child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // ))
                    ),
                Column(
                  children: [
                    Text(
                      "SIGN UP",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 19),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white24,
                              ),
                              child: TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(5),
                                    hintText: " name",
                                    hintStyle: TextStyle(color: Colors.black),
                                    icon: Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    )),
                                validator: (valuename) {
                                  if (valuename!.isEmpty ||
                                      !RegExp(r'^[a-z A-Z]+$')
                                          .hasMatch(valuename)) {
                                    return 'Invalid name';
                                  }
                                  return null;
                                },
                                onSaved: (value1) {
                                  name = value1!;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white24,
                              ),
                              child: TextFormField(
                                controller: usernumber_controller,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(5),
                                    hintText: "phone",
                                    hintStyle: TextStyle(color: Colors.black),
                                    icon: Icon(
                                      Icons.phone,
                                      color: Colors.black,
                                    )),
                                validator: (valuephone) {
                                  if (valuephone!.isEmpty) {
                                    return 'Enter  number';
                                  }
                                  if (valuephone.length < 10) {
                                    return 'Number minimum length is 10';
                                  }
                                  if (valuephone.length > 10) {
                                    return 'The number must be 10 digit';
                                  }
                                  if (RegExp(r'^[0-9]+$')
                                      .hasMatch(valuephone)) {
                                    return null;
                                  } else {
                                    return 'Numbers only';
                                  }
                                },
                                onSaved: (value1) {
                                  phone = int.parse(value1!);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white24,
                              ),
                              child: TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(5),
                                    hintText: "email",
                                    hintStyle: TextStyle(color: Colors.black),
                                    icon: Icon(
                                      Icons.email,
                                      color: Colors.black,
                                    )),
                                validator: (valuemail) {
                                  if (valuemail!.isEmpty) {
                                    return 'Invalid last name';
                                  }
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                                      .hasMatch(valuemail!)) {
                                    return 'Invalid email';
                                  }
                                  return null;
                                },
                                onSaved: (value1) {
                                  email = value1!;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white24,
                              ),
                              child: TextFormField(
                                controller: password_controller,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _visible,
                                decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          show();
                                        },
                                        child: Icon(
                                          Icons.visibility,
                                          color: Colors.black,
                                        )),
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: "Confirm password",
                                    icon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.black,
                                    )),
                                validator: (valuepassword) {
                                  if (valuepassword!.isEmpty) {
                                    return 'Enter your password';
                                  }
                                  if (valuepassword.length < 6) {
                                    return 'Password must be more than 6 Letters';
                                  }
                                  if (valuepassword.length > 12) {
                                    return 'Password must not be more than 12 Letters';
                                  }
                                  if (RegExp(
                                          r'^(?=^.{6,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$')
                                      .hasMatch(valuepassword)) {
                                    return null;
                                    writedData();
                                  } else {
                                    return "Password should Contain at least 1 symbol,Uppercase or number";
                                  }
                                },
                                onSaved: (value1) {
                                  pass = value1!;
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white24,
                              ),
                              child: TextFormField(
                                controller: CpassController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _visible,
                                decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          show();
                                        },
                                        child: Icon(
                                          Icons.visibility,
                                          color: Colors.black,
                                        )),
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: "Confirm password",
                                    icon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.black,
                                    )),
                                validator: (cpass) {
                                  // if(pass!=cpass){
                                  //   return 'Password must match';
                                  // }
                                  // return null;
                                },
                              ),
                            ),
                            SizedBox(),
                            Container(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: StadiumBorder()),
                                  onPressed: () {
                                    if (_formkey.currentState!.validate()) {
                                      writedData();
                                      // name = nameController.text;
                                      // phone = usernumber_controller.text;
                                      // email = emailController.text;
                                      // if (name != '' &&
                                      //     phone != '' &&
                                      //     email != '')
                                    {
                                        print("Succesfull");
                                        logindata!.setBool('login', true);
                                        logindata?.setString('name', name!);
                                        logindata!.setString('mail', email!);
                                        logindata!.setString('phone', phone!);
                                      }
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Barnew()));
                                    }
                                  },
                                  child: Text("Register")),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) => LOG()));
                                },
                                child: Text(
                                  "already have a acoount, LOG IN ",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ]),
        )));
  }

  void show() {
    setState(() {
      _visible = !_visible;
    });
  }
}
