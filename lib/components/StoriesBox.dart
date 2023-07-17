import 'package:anaam/data/user.dart';
import 'package:anaam/pages/Views/StoryView.dart';
import 'package:flutter/material.dart';

class StoriesBox extends StatelessWidget {
  const StoriesBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color.fromARGB(255, 204, 204, 204),
            width: 1.0,
          ),
        ),
      ),
      child: ListView.builder(
        itemCount: users.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StorypageView(),
                    ),
                  );
                },
                child: StoryBox(user: users[index])),
          );
        },
      ),
    );
  }
}

Widget StoryBox({required Map user}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 65,
        height: 65,
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border:
              Border.all(color: Color.fromARGB(255, 214, 35, 161), width: 2.5),
        ),
        child: Container(
          child: ClipRRect(
            child: Image.network(user['pic'], fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      SizedBox(
        width: 60,
        child: Text(
          user['name'],
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.clip,
          ),
        ),
      )
    ],
  );
}
