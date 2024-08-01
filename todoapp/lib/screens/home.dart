import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todoapp/constrants/colors.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/widgets/todo_item.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';


class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  final _todoController= TextEditingController();
  List<ToDo> _foundToDo=[];
  File? _image;


@override
  void initState() {
    _foundToDo=todosList;
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BGColor,
      appBar: _buildAppBar(),
      body: Stack(
      children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          children: [
            searchBox(),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 50, 
                      bottom: 20
                    ),
                    child: Text(
                      'My Todo list',
                      style: TextStyle(
                        fontSize: 30, 
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  for (ToDo todoo in _foundToDo.reversed)
                    TodoItem(
                      todo: todoo,
                      onToDoChanged: _handleToDoChange,
                      onDeletedItem: _deleteToDoItem,
                    ),
                ],
              ),
            )
          ],
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Row(children: [
          Expanded(
            child: Container(
            margin: EdgeInsets.only(
              bottom: 20,
              right: 20,
              left: 20,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                ),],
                borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _todoController,
              decoration: InputDecoration(
                hintText: 'Add a new item',
                border: InputBorder.none),
              ),
            )
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 20,
              right: 20,
            ),
            child: ElevatedButton(
              child: Text(
                '+',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
              onPressed: (){
               // print('Add button clicked');
               _addToDoItem(_todoController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[300],
                //minimumSize: Size(60,60),
                elevation: 10
              ),
              ),
          )
        ],),
      )
      ],
    ),
    );
  }

void _handleToDoChange(ToDo todo){
  setState(() {
    todo.isDone = !todo.isDone;
  });
}

void _deleteToDoItem(String id){
  setState(() {
    todosList.removeWhere((item)=>item.id==id);
  });
}

void _addToDoItem(String toDo){
  setState(() {
    todosList.add(ToDo(id: DateTime.now().microsecondsSinceEpoch.toString(), todoText: toDo));
    });
    _todoController.clear();
  }

  void _runfilter(String enteredKeyword){
    List<ToDo> results=[];
    if(enteredKeyword.isEmpty){
      results= todosList;
    }
    else{
      results=todosList.where((item)=>item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }
    setState(() {
      _foundToDo=results;
    });
  }

// Future<void> _pickImage()async{
//   final picker= ImagePicker();
//   final PickedFile= await picker.pickImage(source: ImageSource.gallery);
//   if (PickedFile!=null){
//     setState(() {
//       _image =File(PickedFile.path);
//     });
//   }
// }

Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Gallery'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Camera'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _runfilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: blackColor,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: greyColor)),
      ),
    );
  }

  // AppBar _buildAppBar() {
  //   return AppBar(
  //     backgroundColor: BGColor,
  //     elevation: 0,
  //     title: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Icon(
  //           //Icons.menu,
  //           Icons.arrow_back,
  //           color: blackColor,
  //           size: 30,
  //         ),
  //         GestureDetector(
  //           onTap: _pickImage,
  //           child: Container(
  //             height: 40,
  //             width: 40,
  //             color: Colors.white,
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(20),
  //               child: _image != null
  //                   ? Image.file(
  //                       _image!,
  //                       fit: BoxFit.cover,
  //                     )
  //                   : Center(child: Text('P')),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: BGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.arrow_back,
            color: blackColor,
            size: 30,
          ),
          GestureDetector(
            onTap: () => _showImageSourceActionSheet(context),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: _image != null
                    ? Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      )
                    : Center(child: Text('P')),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
