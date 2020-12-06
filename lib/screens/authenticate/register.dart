import 'package:flutter/material.dart';
import 'package:flutter_project_with_firebase/services/auth.dart';
import 'package:flutter_project_with_firebase/shared/constant.dart';
import 'package:flutter_project_with_firebase/shared/loading.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();

  final Function toggleView;
  Register( {this.toggleView});
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //test field state
  String email = '';
  String password = '' ;
  String error= '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('SingUp and Register in to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('SignIn'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Enter email here'),
              validator: (val) => val.isEmpty ? 'Enter an email' : null,
              onChanged: (val){
              setState(() => email = val);
              }
            ),
            SizedBox(height: 20.0),
            TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Enter password here'),
                validator: (val) => val.length < 6 ? 'Enter an password more that 6 letters' : null,
              obscureText: true,
              onChanged: (val){
                 setState(() => password = val);
            }
          ),
            SizedBox(height: 20.0),
            RaisedButton(
              color: Colors.brown[400],
              child: Text(
                      'Register',
              style: TextStyle(color: Colors.white),
            ),
              onPressed: () async{
                setState(() => loading = true);
                if(_formKey.currentState.validate()){
                  dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                  if(result == null){
                    setState((){
                      error = 'Please enter valid email !!!';
                      loading = false;
                    });
                  }
                }
                },
              ),
              SizedBox(height: 12.0),
              Text(
              error,
              style:  TextStyle(color: Colors.red, fontSize: 14.0),
            ),
            ],
          ),
        ),
      ),
    );


  }
}
