import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thoughtbox/pages/userform.dart';
import 'package:thoughtbox/pages/weathermap.dart';

class UserListScreen extends StatefulWidget {
  final List<User> users;

  const UserListScreen({Key? key, required this.users}) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getStringList('users') ?? [];

    setState(() {
      _users = usersJson.map((json) => User.fromJson(json)).toList();
    });
  }

  void _saveUsers() async {
    final prefs = await SharedPreferences.getInstance();
     List<String> usersJson = _users.map((user) => json.encode(user)).toList();
  prefs.setStringList('data', usersJson);
    // final usersJson = _users.map((user) => user.toJson()).toList();
    //  prefs.setStringList('users', usersJson);
  }

  void _addUser(User user) {
    setState(() {
      _users.add(user);
      _saveUsers();
    });
  }

  void _deleteUser(User user) {
    setState(() {
      _users.remove(user);
      _saveUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('User List Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserFormScreen(addUser: _addUser),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];

          return Dismissible(
            key: ValueKey(user),
            onDismissed: (direction) => _deleteUser(user),
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 16),
            ),
            child: GestureDetector(
              onTap: (() {
                 Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );
              }),
              child: ListTile(
                title: Text(user.firstName + ' ' + user.lastName),
                subtitle: Text(user.email),
              ),
            ),
          );
        },
      ),
    );
  }
}

class User {
  final String firstName;
  final String lastName;
  final String email;

  User({required this.firstName, required this.lastName, required this.email});

  factory User.fromJson(String json) {
    final map = Map<String, dynamic>.from(jsonDecode(json));
    return User(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      };

  static fromString(String str) {}
}



// hello dvee
// class User {
//   final String firstName;
//   final String lastName;
//   final String email;

//   User({required this.firstName, required this.lastName, required this.email});
// }
