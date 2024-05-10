import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'chat_page.dart'; // Import the chat page file

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _userEmails = []; // List to store user emails

  late Database _database;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'your_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, email TEXT, password TEXT)",
        );
      },
      version: 1,
    );
    _fetchUserEmails(); // Fetch user emails when the database is initialized
  }

//   Future<void> _fetchUserEmails() async {
//   final List<Map<String, dynamic>> users = await _database.query('users');
//   final String currentUserEmail = ''; // Provide the current user's email here

//   setState(() {
//     _userEmails = users
//         .map((user) => user['email'] as String)
//         .where((email) => email != currentUserEmail)
//         .toList();
//   });
// }

Future<void> _fetchUserEmails() async {
    final List<Map<String, dynamic>> users = await _database.query('users');
    setState(() {
      _userEmails = users.map((user) => user['email'] as String).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: _userEmails.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_userEmails[index]),
              onTap: () {
                // Navigate to the chat page when email is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage(email: _userEmails[index])),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
