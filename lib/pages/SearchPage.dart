import 'package:anaam/data/user.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 30,
              height: 30,
              child: ClipRRect(
                child: Image.network(
                  users[index]['pic'],
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            title: Text(users[index]['name']),
            subtitle: Text('10K Follwers'),
            trailing: Chip(
              label: Text(
                "  Follow  ",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
            ),
          );
        },
      ),
    );
  }
}
