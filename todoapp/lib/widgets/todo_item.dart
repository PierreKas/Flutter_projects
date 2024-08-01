import 'package:flutter/material.dart';
import 'package:todoapp/constrants/colors.dart';
import 'package:todoapp/model/todo.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeletedItem;

  const TodoItem({Key? key, required this.todo,required this.onDeletedItem, required this.onToDoChanged}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: (){
          //print('Todo Item clicked');
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone? Icons.check_box_rounded : Icons.check_box_outline_blank,
          color: Colors.green[300],
          ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: blackColor,
            decoration: todo.isDone? TextDecoration.lineThrough :null,
          ),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: redColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: (){
              print('delete button clicked');
              onDeletedItem(todo.id);
            },
            ),
        ),
      )
      );
  }
}