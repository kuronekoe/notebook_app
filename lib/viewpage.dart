import 'package:flutter/material.dart';
import 'package:notebook/editpage.dart';

class ViewPage extends StatefulWidget {
  String notes;
  String note_date;
  ViewPage({ Key? key, required this.notes,required this.note_date}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor:Colors.deepPurple,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context,{
              'edited_note':widget.notes,
              'edited_date':widget.note_date,
            });
          },
          icon: const Icon(Icons.keyboard_arrow_left),
          ),
        title: const Text('Reading'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                widget.note_date,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
                //textAlign: TextAlign.center,
                ),
              Text(
                widget.notes,
                style: const TextStyle(
                  fontSize: 17,
                ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.deepPurple,
        onPressed: () async{
          Map result =await Navigator.push(context,MaterialPageRoute(builder:(BuildContext context)=>EditPage(note: widget.notes,)));
          setState(() {          
            widget.notes=result['edited_note'];
            widget.note_date=result['edited_date'];
          });
        },
        child: const Icon(Icons.edit),
        ),
    );
  }
}