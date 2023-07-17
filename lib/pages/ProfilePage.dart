import 'package:anaam/data/user.dart';
import 'package:anaam/pages/Views/PostBox.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../components/appbars/ProfileAppbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2 - 60,
                      height: 130,
                      color: const Color.fromARGB(255, 241, 241, 241),
                      child: Image.network(
                        "https://i.insider.com/5e50382ba9f40c0fae40f5d4?width=700",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 130,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tony Stark",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "@Tony1",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 117, 117, 117),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Ionicons.location,
                              color: Color.fromARGB(255, 5, 4, 4),
                              size: 18,
                            ),
                            Text(
                              "Malibu Point, 90265",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 117, 117, 117),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width -
                              (MediaQuery.of(context).size.width / 2 + 50),
                          margin: EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "1.2M",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 49, 49, 49),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "Follower",
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 117, 117, 117),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "4",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 49, 49, 49),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "Following",
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 117, 117, 117),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About",
                    style: TextStyle(
                      color: Color.fromARGB(255, 44, 44, 44),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 117, 117, 117),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                "Photos",
                style: TextStyle(
                  color: Color.fromARGB(255, 44, 44, 44),
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: Text('View All'),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return PostBox();
                  },
                )),
          ],
        ),
      ),
    );
  }
}
