import 'package:flutter/material.dart';
import 'package:share_stuff/database/auth_database.dart';
import 'package:share_stuff/models/user_info.dart';
import 'package:share_stuff/services/auth.dart';
import 'package:share_stuff/shared/using.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isUsing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final AuthDatabase _authDatabase = AuthDatabase();

  List<UserInfo> list = [
    UserInfo(name: 'Nam', phone: '0912323456'),
    UserInfo(name: 'Hai', phone: '080234056')
  ];

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return (isUsing)
        ? Using()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: const Text('Share stuff'),
              actions: [
                TextButton.icon(
                    onPressed: () async {
                      await _auth.signOut();
                    },
                    icon: const Icon(Icons.person),
                    label: const Text('logout')),
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your name',
                            )),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter a your phone number',
                            )),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _authDatabase.insertData(
                                _nameController.text, _phoneController.text);
                          },
                          child: const Text('Add'))
                    ],
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const FlutterLogo(size: 50),
                        title: Text(list[index].name.toString()),
                        subtitle: Text(list[index].phone.toString()),
                        trailing: TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.delete),
                          label: const Text(''),
                        ),
                      );
                    })
              ],
            ),
          );
  }
}
