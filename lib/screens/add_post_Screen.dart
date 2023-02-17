// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:comnity/models/user_model.dart';
import 'package:comnity/providers/user_provider.dart';
import 'package:comnity/resources/firestore_methods.dart';
import 'package:comnity/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  bool _isLoading = false;

  Uint8List? _file;
  TextEditingController _descController = TextEditingController();

  _selectImage(BuildContext context) async{
    return showDialog(context: context, builder: (context){
      return SimpleDialog(
        title: const Text("Create a Post"),
        children: [

          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text("Take a Photo"),
            onPressed: () async {
               Navigator.of(context).pop();
               Uint8List file = await pickImage(ImageSource.camera);
               setState(() {
                 _file = file;
               });
            },
          ),

          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text("Choose from Gallery"),
            onPressed: () async {
               Navigator.of(context).pop();
               Uint8List file = await pickImage(ImageSource.gallery);
               setState(() {
                 _file = file;
               });
            },
          ),

          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text("Cancel"),
            onPressed: ()  {
               Navigator.of(context).pop();
            },
          ),

        ],
      );
    });
  }

  void postImage(
    String uid,
    String username,
    String profileImage
  ) async{
    setState(() {
      _isLoading = true;
    });
    try{
      String res = await FirestoreMethods().uploadPost(_descController.text, _file!, uid, username, profileImage);
      
      if(res=="success"){
        setState(() {
          _isLoading = false;
        });
        clearImage();
        showSnackBar("posted", context);

      }else{
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    }catch(err){
      showSnackBar(err.toString(), context);

    }

  }

  void clearImage(){
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final UserModel user = Provider.of<UserProvider>(context).getUser;

    return _file == null? Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(FeatherIcons.upload, size: 34, color: Colors.blueAccent,), 
            onPressed: () => _selectImage(context),
          ),
          SizedBox(height: 10,),
          Text("Upload Image", style: TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
    ) :
    Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: Icon(FeatherIcons.arrowLeft, color: Colors.black,), 
            onPressed: ()=> clearImage(),
          ),

          title: const Text("Post to", style: TextStyle(color: Colors.black),),
          centerTitle: true,
          actions: [
            TextButton(onPressed: ()=> postImage(user.uid, user.username, user.photoUrl), 
              child: const Text("post", style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold
            ),))
          ],
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 1),
              child: _isLoading? const LinearProgressIndicator() : 
              Padding(
                padding: EdgeInsets.only(top: 0)
              ),
            ),
            
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage:  NetworkImage(user.photoUrl),
                  ),
                  // profile photo
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      controller: _descController,
                      decoration: InputDecoration(
                        hintText: "write a caption...",
                        border: InputBorder.none,
                      ),
                      maxLines: 10,
                    ),
                  ),

                  // uploading image
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: AspectRatio(
                      aspectRatio: 487/451,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(_file!),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter
                          )
                        ),
                      ),
                    ),
                  ),
                  
                  const Divider(color: Colors.grey,)

                ],
              ),
            )
          ]
        ),
      );
  }
}