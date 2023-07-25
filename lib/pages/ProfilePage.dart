import 'package:anaam/pages/UserProfile.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final userId;
  const ProfilePage({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return UserProfile(userid: userId);
  }
}
