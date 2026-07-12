import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final List todoList = [];

  @override
  onInit(){
    super.onInit();
    getTodoList();
    getcurrentUser();
  }

  getTodoList() async {

    final response = await Dio().get("https://api.freeapi.app/api/v1/todos");
    print(response.data);
    //anasnaeem

    for (var element in response.data["data"]) {
      todoList.add(element["title"]);
    }
  }

  getcurrentUser() async {
    final response = await Dio().get("https://api.freeapi.app/api/v1/users/current-user", options: Options(headers: {
      "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2YTUzOTM3MTM4OTNmYjhmOWUxNWI0MjQiLCJlbWFpbCI6InVzZXIuYW5hc0BnbWFpbC5jb20iLCJ1c2VybmFtZSI6ImFuYXNuYWVlbSIsInJvbGUiOiJBRE1JTiIsImlhdCI6MTc4Mzg2MjE3OCwiZXhwIjoxNzgzOTQ4NTc4fQ.yeHAqGbkpPk48vbL-hvAC6D3nDuDNcjFxSBd1xtCspM"
    }));
    print(response.data);
  }

  //  void deleteTodo(int index) {
  //   todoList.removeAt(index);
  //   update();
  // }
  void deleteTodo(int index) {
    todoList.removeAt(index);
    update();
  }

  void editTodo(int index) {
    TextEditingController controller = TextEditingController(
      text: todoList[index],
    );

    Get.dialog(
      Dialog(
        child: Container(
          width: 300,
          padding: EdgeInsets.all(12),
          child: Column(
            spacing: 12,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Edit Your ToDo",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: controller,
                minLines: 4,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Update your text",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(), 
                      child: Text("Cancel"),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.text.trim().isNotEmpty) {
                          todoList[index] = controller.text
                              .trim(); 
                          Get.back();
                          update(); 
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black87),
                      ),
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addTodo(BuildContext context) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 300,
            padding: EdgeInsets.all(12),
            child: Column(
              spacing: 12,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add Your ToDo",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: controller,
                  minLines: 4,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Write your text",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          todoList.add(controller.text);
                          Navigator.pop(context);
                          update();
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.black87,
                          ),
                        ),
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
