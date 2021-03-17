import 'dart:ui';
import 'package:cust/providers/userprovider.dart';


import 'package:cust/widgets/authtitle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cust/screens/home.dart';


class Authscreen extends StatefulWidget {
  static const String route = '/auth';

  @override
  _AuthscreenState createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
  bool login;
  bool hidepassword, hideconfirmpassword;
  String password, email;
  GlobalKey<FormState> form;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    login = true;
    hidepassword = true;
    hideconfirmpassword = true;
    form = GlobalKey<FormState>();
  }

  void validatetologin() async {
    if (form.currentState.validate()) {
      String error = await Provider.of<Userprovider>(context, listen: false)
          .login(email, password);
      if (error == null) {
        Navigator.of(context).pushNamed(MyHomePage.route);
      }
    }
  }

  void validatetosignup() async {
    if (form.currentState.validate()) {
      String error = await Provider.of<Userprovider>(context, listen: false)
          .register(email, password);
      if (error == null) {
        Navigator.of(context).pushNamed(MyHomePage.route);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25).add(
                    EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (login)
                        ? Authtitle(UniqueKey(), 'Login into')
                        : Authtitle(UniqueKey(), 'Create'),
                    Form(
                      key: form,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.mail,
                                color: Colors.grey,
                              ),
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 3,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            validator: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextFormField(
                            obscureText: hidepassword,
                            // ignore: missing_return
                            validator: (value) {
                              setState(() {
                                password = value;
                              });
                              if (password.length >= 8) {
                                return null;
                              }
                              return 'password must contain 8 charcter at least';
                            },

                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              suffix: InkWell(
                                child: (hidepassword)
                                    ? Icon(
                                        Icons.visibility,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                      ),
                                onTap: () {
                                  setState(() {
                                    hidepassword = !hidepassword;
                                  });
                                },
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 3,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                          if (!login)
                            TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.phone,
                                  color: Colors.grey,
                                ),
                                hintText: 'Mobile',
                                hintStyle: TextStyle(color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 3,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                         
                        ],
                      ),
                    ),
                   
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03),
                      width: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        shape: StadiumBorder(),
                        color: Colors.blueAccent,
                        onPressed: () {
                          (login) ? validatetologin() : validatetosignup();
                        },
                        child: (login)
                            ? Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )
                            : Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(
                        milliseconds: 400,
                      ),
                      child: (login)
                          ? Row(
                              key: UniqueKey(),
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don\'t Have Account?'),
                                FlatButton(
                                  child: Text(
                                    'Signup',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      login = !login;
                                    });
                                  },
                                ),
                              ],
                            )
                          : Row(
                              key: UniqueKey(),
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Already Have Account?'),
                                FlatButton(
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      login = !login;
                                    });
                                  },
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
