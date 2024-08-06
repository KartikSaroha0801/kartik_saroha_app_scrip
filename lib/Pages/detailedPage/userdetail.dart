import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserDetail extends StatefulWidget {
  final int userId;

  UserDetail({required this.userId});

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  late Map<String, dynamic> userDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserDetail();
  }

  Future<void> fetchUserDetail() async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/users/${widget.userId}'));

    if (response.statusCode == 200) {
      setState(() {
        userDetail = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load user details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.blueAccent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name: ${userDetail['name']}',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          Text('Username: ${userDetail['username']}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                          Text('Email: ${userDetail['email']}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                          Text('Phone: ${userDetail['phone']}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                          Text('Website: ${userDetail['website']}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.blueAccent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Address:',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Text(
                            'Street: ${userDetail['address']['street']}',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Suite: ${userDetail['address']['suite']}',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'City: ${userDetail['address']['city']}',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Zipcode: ${userDetail['address']['zipcode']}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.blueAccent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Company:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                          Text('Name: ${userDetail['company']['name']}', style: TextStyle(color: Colors.white),),
                          Text(
                              'CatchPhrase: ${userDetail['company']['catchPhrase']}', style: TextStyle(color: Colors.white),),
                          Text('BS: ${userDetail['company']['bs']}', style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
