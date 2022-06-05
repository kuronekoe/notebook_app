import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  String note;
  EditPage({ Key? key,required this.note }) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String edited_date='';
  final myController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    edited_date='${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
    myController.text=widget.note;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor:Colors.deepPurple,
        actions: [
          TextButton(
          onPressed: (){
            if(widget.note!=''){
            Navigator.pop(context,{
              'edited_note':widget.note,
              'edited_date':edited_date,
            });
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.grey[400],
                  content: const Text(
                    "Empty note",
                    style:TextStyle(
                      color:Colors.black,
                    ),
                    ),
                  ),
                );
            }
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
          style:const TextStyle(
                fontSize: 17,
              ),
          controller: myController,
          onChanged: (value){
            widget.note=value;
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