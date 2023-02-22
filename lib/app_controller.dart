import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'models/users_llist.dart';

class AppController extends GetxController with StateMixin{

  String baseUrl = "https://reqres.in/api";

  Rx<UsersList> usersList = UsersList().obs;

  @override
  onInit(){
    super.onInit();
    getUsers();
  }

 getUsers() async{
try{
  debugPrint('start'.toString());
  change(null, status: RxStatus.loading());
  debugPrint('loading'.toString());
  var response = await Dio().get('$baseUrl/users?page=2');
  if(response.statusCode==200){
     usersList.value = UsersList.fromJson(response.data);
    change(null, status: RxStatus.success());
  }else{
    throw Exception('Failed to load users');
  }
}catch(e){
  change(null, status: RxStatus.error());
  print(e);
  }
}


  Rx<TextEditingController> firstNameCtr = TextEditingController().obs;
  Rx<TextEditingController> lastNameCtr = TextEditingController().obs;
  Rx<TextEditingController> emailCtr = TextEditingController().obs;

  createUser() async{
    if(firstNameCtr.value.text.isNotEmpty&&lastNameCtr.value.text.isNotEmpty&&emailCtr.value.text.isNotEmpty){
      try{
        change(null, status: RxStatus.loading());
        var response = await Dio().post('$baseUrl/users', data: User(
          firstName: firstNameCtr.value.text,
          lastName: lastNameCtr.value.text,
          email: emailCtr.value.text,
          avatar: "/akash",
        ));
        if(response.statusCode==201){
          change(null, status: RxStatus.success());
          Get.dialog(const Dialog(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("User Created Successfully."),
              ),
            ),
          ));
          getUsers();
        }else{
          debugPrint(response.statusCode.toString());
          throw Exception('Failed to create user');
        }
      }catch(e){
        change(null, status: RxStatus.error());
        print(e);
      }
    }else{
      Get.snackbar("Please enter all details.","");
    }
  }

}