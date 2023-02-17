import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comnity/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController _searchController = TextEditingController();

  bool isShowUser = false;

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title: TextFormField(
            controller: _searchController,
            autocorrect: true,
            decoration: InputDecoration(
              label: Text("search..."),
            ),
            onFieldSubmitted: (String _){
              setState(() {
                isShowUser = true;
              });
            },
          ),
      ),
      body: isShowUser ? FutureBuilder(
        future: FirebaseFirestore.instance.collection('users')
        .where('username', isGreaterThanOrEqualTo: _searchController.text )
        .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
              return InkWell(
                onTap: () =>  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen(uid: snapshot.data!.docs[index]['uid']),)),
                child: ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data!.docs[index]['photoUrl']),),                  
                  title: Text(snapshot.data!.docs[index]['username']),
                  
                ),
              );
            },
          );
        }
        
      ) : Center(child: Text("search..")),
    );
  }
}