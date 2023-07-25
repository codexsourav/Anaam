import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/SearchTill.dart';
import '../components/appbars/SearchAppbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _search = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> userdata = [];
  bool _isSearch = false;

  final fbDb = FirebaseFirestore.instance;

  searchUser() async {
    if (_search.text.isEmpty) {
      return false;
    }
    setState(() {
      _isSearch = true;
    });
    try {
      var data = await fbDb
          .collection("users")
          .orderBy('uname', descending: false)
          .where("uname", isGreaterThanOrEqualTo: _search.text)
          .limit(15)
          .get();
      setState(() {
        userdata = data.docs;
        _isSearch = false;
      });
    } catch (e) {
      setState(() {
        userdata = [];
        _isSearch = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SearchAppbar(onSearch: searchUser, controller: _search),
      body: _isSearch
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.black,
            ))
          : _search.text.isNotEmpty && userdata.isEmpty
              ? const Center(
                  child: Text("NO User Found!"),
                )
              : ListView.builder(
                  itemCount: userdata.length,
                  itemBuilder: (context, index) {
                    var userInfo = userdata[index].data();
                    return SearchTill(
                      userInfo: userInfo,
                      userID: userdata[index].id,
                    );
                  },
                ),
    );
  }
}
