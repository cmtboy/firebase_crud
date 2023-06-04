import 'package:firebase_crud/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = "";

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    final uid = AuthProvider().user!.uid;
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = snapshot.data() as Map<String, dynamic>;
    setState(() {
      _userName = data['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                child: FlutterLogo(
                  size: 80,
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 20),
              Text(
                _userName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Card(
                child: ListTile(
                  title: Text("Donate"),
                  trailing: Icon(Icons.health_and_safety),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Contact Us"),
                  trailing: Icon(Icons.contact_mail),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Logout'),
                  trailing: Icon(Icons.logout),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
