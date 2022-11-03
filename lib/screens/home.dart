import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textFieldController = TextEditingController();
 void _addtask(){

   FirebaseFirestore.instance.collection('todos').add({"title":_textFieldController});
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(drawer:Drawer(),
      appBar: AppBar(title: Text('to do list'),),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textFieldController,
                  decoration: InputDecoration(
                    hintText: "Type here"
                  ),
                ),
              ),
              TextButton(onPressed: (){
                print(_textFieldController);
               _addtask();
              }, child: Text('add task'))
            ],
          )
        ], 
      )

      // floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add),),
    );
  }
}
