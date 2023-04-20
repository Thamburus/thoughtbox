
import 'package:flutter/material.dart';
import 'package:thoughtbox/pages/userlist.dart';

class UserFormScreen extends StatefulWidget {
  final Function(User) addUser;

  const UserFormScreen({Key? key, required this.addUser}) : super(key: key);

  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final user = User(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
      );
      widget.addUser(user);
    
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.black ,
        title: Text('Add User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: _submitForm,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 40,
                       width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(10),),
                      // color: Colors.black,
                      child: Center(child: Text('Save',style: TextStyle(fontSize: 20,color: Colors.white),))),
                ),
                
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 40,
                       width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(10),),
                      // color: Colors.black,
                      child: Center(child: Text('Cancel',style: TextStyle(fontSize: 20,color: Colors.white),))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}