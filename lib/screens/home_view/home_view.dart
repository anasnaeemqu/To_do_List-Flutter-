import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController controller = Get.put(HomeController());
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("M Anas"),
              accountEmail: Text("anas@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.black),
              ),
              decoration: BoxDecoration(color: Colors.black87),
            ),

            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Edit Profile"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                Navigator.pop(context);
                // Get.to(() => ProfileView());
              },
            ),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
                // Get.to(() => SettingsView());
              },
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context);
                // Logout code
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _scaffoldkey.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu, color: Colors.white),
        ),
        title: Text("To-Do", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            GetBuilder(
              init: controller,
              builder: (_) {
                return ListView.separated(
                  itemCount: controller.todoList.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          width: 400,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black, Colors.black54],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  controller.todoList[index].title?? "",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              IconButton(
                                onPressed: () {
                                  controller.editTodo(index);
                                },
                                icon: Icon(Icons.edit, color: Colors.white),
                              ),
                              IconButton(
                                onPressed: () {
                                  // controller.deleteTodo(index)
                                  controller.deleteTodo(todoId: "");
                                },
                                icon: Icon(Icons.delete, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addTodo(context);
        },
        backgroundColor: Colors.black87,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
