import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zigy_task/app_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  AppController controller = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.dialog(Dialog(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("First Name"),
                    TextField(
                      controller: controller.firstNameCtr.value,
                    ),
                    const SizedBox(height: 32),
                    const Text("Last Name"),
                    TextField(
                      controller: controller.lastNameCtr.value,
                    ),
                    const SizedBox(height: 32),
                    const Text("Email"),
                    TextField(
                      controller: controller.emailCtr.value,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(onPressed: (){
                      controller.createUser();
                      Get.back();
                    }, child: const Text("Create User"))
                  ],
                ),
              ),
            ),
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: controller.obx((state) => ListView.builder(
          itemCount: controller.usersList.value.data!.length,
          itemBuilder: (context, index){
            return Card(
              child: Row(
                children: [
                  Image.network(controller.usersList.value.data![index].avatar.toString()),
                  const SizedBox(width: 16,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${controller.usersList.value.data![index].firstName} ${controller.usersList.value.data![index].lastName}", style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 16,),
                      Text("Id: ${controller.usersList.value.data![index].id}"),
                      const SizedBox(height: 16,),
                      Text("Email: ${controller.usersList.value.data![index].email}"),
                    ],
                  )
                ],
              ),
            );
          }),
          onLoading: const Center(child: Text("Loading..."))
      ),
    );
  }
}
