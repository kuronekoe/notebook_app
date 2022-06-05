import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({ Key? key }) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  String? new_note;
  String note_date='';
  @override
  Widget build(BuildContext context) {
    note_date='${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor:Colors.deepPurple,
        actions: [
          TextButton(
          onPressed: (){
            Navigator.pop(context,{
              'new_note':new_note,
              'note_date':note_date,
            });
          },
          child: const Text(
            'Save',
            style: TextStyle(
              color: Colors.white,
            ),
            ),
        ),
        ],
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          onChanged: (value){
            new_note=value;
          },

          maxLength: TextField.noMaxLength,
          maxLines: null,
          expands: true,
          decoration: const InputDecoration.collapsed(
            hintText: 'Enter note',
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}