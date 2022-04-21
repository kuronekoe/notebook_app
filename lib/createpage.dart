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
    note_date='${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        actions: [
          IconButton(
          onPressed: (){
            
          },
          icon: Icon(
            Icons.mic,
            color: Colors.white,
            ),
        ),
          TextButton(
          onPressed: (){
            Navigator.pop(context,{
              'new_note':new_note,
              'note_date':note_date,
            });
          },
          child: Text(
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
          decoration: InputDecoration.collapsed(
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