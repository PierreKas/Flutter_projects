import 'package:flutter/material.dart';
import 'package:pharmacy/controllers/users_controller.dart';
import 'package:pharmacy/models/users.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUsers();
  }

  void _fetchUsers() async {
    await UsersController().getUsers(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Users list'),
        ),
        body: Stack(
          children: [
            Positioned.fill(
                child: Center(
              child: Opacity(
                opacity: 0.3,
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    'assets/logo-no-background.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )),
            ListView.builder(
                itemCount: UsersController.usersList.length,
                itemBuilder: (context, index) {
                  User user = UsersController.usersList[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.fullName,
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    user.phoneNumber,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                      ],
                    ),
                  );
                }),
          ],
        ));
  }
}
