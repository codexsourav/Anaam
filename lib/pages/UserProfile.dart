import 'package:anaam/model/setOnline.dart';
import 'package:anaam/pages/EditProfilePage.dart';
import 'package:anaam/pages/Views/Auth/LoginPage.dart';
import 'package:anaam/utils/ImageLoder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../components/UserPostFeed.dart';
import '../model/SetFollow.dart';
import 'Messages/MessagePage.dart';

class UserProfile extends StatefulWidget {
  final userid;

  const UserProfile({super.key, required this.userid});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final myid = FirebaseAuth.instance.currentUser!.uid;
  bool isFolllow = false;
  final fbDB = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: fbDB.collection('users').doc(widget.userid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userData = snapshot.data!.data();
            bool isFolllow = userData!['follower'].contains(myid);
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
                title: Text(
                  "@" + userData['uname'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.w300),
                ),
                centerTitle: true,
                actions: myid != widget.userid
                    ? null
                    : [
                        PopupMenuButton(
                          color: const Color.fromARGB(255, 250, 250, 250),
                          elevation: 0,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 5),
                            child: Icon(
                              Ionicons.ellipsis_vertical_outline,
                              size: 18,
                            ),
                          ),
                          onSelected: (value) async {
                            if (value == 'edit') {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    EditProfilePage(userData: userData),
                              ));
                            } else if (value == 'logout') {
                              await FirebaseAuth.instance.signOut();
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                            }
                          },
                          itemBuilder: (context) {
                            return [
                              const PopupMenuItem(
                                  child: Text('Edit Profile'), value: 'edit'),
                              const PopupMenuItem(
                                  child: Text('Logout'), value: "logout"),
                            ];
                          },
                        )
                      ],
              ),
              body: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 50, bottom: 20),
                            alignment: Alignment.center,
                            height: 90,
                            width: 90,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: chackOnline(
                                          onlineTime: userData['online'] ?? "0")
                                      ? const Color.fromARGB(255, 38, 168, 60)
                                      : const Color.fromARGB(
                                          255, 221, 221, 221),
                                  width: 4),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: ImageLoder(
                                imgurl: userData['pic'].toString(),
                                imgWidget: 90,
                                imgHeight: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(userData['name'].toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 22)),
                          Text('@${userData['uname']}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 12)),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(userData['bio'].toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 15)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 30, bottom: 30, right: 10, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    const Text('Followers',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)),
                                    const SizedBox(height: 5),
                                    Text(userData['follower'].length.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('Following',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)),
                                    const SizedBox(height: 5),
                                    Text(
                                        userData['following'].length.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16)),
                                  ],
                                )
                              ],
                            ),
                          ),
                          myid == widget.userid
                              ? const SizedBox()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        bool res = await setFollow(
                                            isFolllow: isFolllow,
                                            userID: widget.userid);
                                        setState(() {
                                          isFolllow = res;
                                        });
                                      },
                                      child: Container(
                                        width: 120,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: isFolllow
                                              ? const Color.fromARGB(
                                                  255, 197, 197, 197)
                                              : Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Center(
                                          child: Text(
                                            isFolllow ? "Following" : 'Follow',
                                            style: TextStyle(
                                              color: !isFolllow
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => MessagePage(
                                              userId: widget.userid),
                                        ));
                                      },
                                      child: Container(
                                        width: 120,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 55, 129, 172),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Message',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                        ],
                      ),
                      const SizedBox(height: 30),
                      UserPostFeed(userID: widget.userid),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              )),
            );
          }
        });
  }
}
