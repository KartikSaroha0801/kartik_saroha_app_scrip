import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_scrip_assignment/Widgets/searchbar.dart'; 
import 'package:app_scrip_assignment/Pages/detailedPage/userdetail.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<dynamic> allUsers = [];
  List<dynamic> displayedUsers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUsers();
    searchController.addListener(() {
      filterUsers();
    });
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      setState(() {
        allUsers = json.decode(response.body);
        displayedUsers = allUsers;
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  void filterUsers() {
    String query = searchController.text.toLowerCase();
    setState(() {
      displayedUsers = allUsers.where((user) {
        return user['name'].toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> _refresh() async {
    await fetchUsers();
  }

  Future<bool> _onWillPop() async {
    return true; 
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () {
              SystemNavigator.pop();
            },
          ),
          title: Text("Home Page"),
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Searchbar(controller: searchController),
                displayedUsers.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: displayedUsers.length,
                        itemBuilder: (context, index) {
                          final user = displayedUsers[index];
                          return ListTile(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            leading: Icon(Icons.person),
                            title: Text(user['name'], style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                            subtitle: Text(user['email']),
                            trailing: Icon(Icons.arrow_right),
                            onTap: () {
                              Get.to(UserDetail(userId: user['id']));
                            },
                            iconColor: Colors.black,
                            
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
