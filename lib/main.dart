import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notebook/createpage.dart';
import 'package:notebook/editpage.dart';
import 'package:notebook/viewpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Notebook',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key,}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState(){
    super.initState();
    retrieve_note();
  }

  List<String> notes=[];
  List<String> note_date=[];
  //String new_note='';
  //String note_date='';

  SharedPreferences? prefs;

  save_note() async{
    prefs =await SharedPreferences.getInstance();
    prefs!.setStringList('notes', notes);
    prefs!.setStringList('note_date', note_date);
  }

  retrieve_note() async{
    prefs =await SharedPreferences.getInstance();
    notes = prefs!.getStringList('notes')!;
    note_date = prefs!.getStringList('note_date')!;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notebook'),
        actions: [
          // IconButton(
          //   onPressed: (){
          //     setState(() {

          //     });
          //   },
          //   icon: Icon(Icons.pin_drop),
          //   ),
          IconButton(
            onPressed: (){
              setState(() {
                notes=notes.reversed.toList();
                note_date=note_date.reversed.toList();
              });
            },
            icon: Icon(Icons.reorder),
            ),
        ],
        elevation: 0,
      ),

      body:ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: notes.length,
        separatorBuilder:(BuildContext context, int idx) => const SizedBox(height: 5,),
        itemBuilder: (BuildContext context, int idx){
          return ListTile(
            tileColor: Colors.blue[50],
            title: Text(
              notes[idx],
              maxLines:1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            subtitle: Text(
              note_date[idx],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 1,
                color: Colors.grey[500],
              ),
              ),
            trailing: IconButton(
              onPressed: (){
                //add alert dialogue box
                showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      title:Text('Delete Note'),
                      content: Text('Do you want to delete this note?'),
                      actions: [
                        TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          }, 
                          child: Text('No')
                          ),
                          TextButton(
                          onPressed: (){
                              setState(() { 
                                notes.removeAt(idx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.grey[400],
                                    content: Text(
                                      "Note Deleted",
                                      style:TextStyle(
                                        color:Colors.black,
                                      ),
                                      ),
                                    ),
                                  );
                                save_note();
                              });
                            Navigator.pop(context);
                          }, 
                          child: Text('Yes')
                          ),
                      ],
                    );
                  }
                  );
              },
              icon: Icon(Icons.delete),
            ),
            onTap: () async{
            Map result =await Navigator.push(context,MaterialPageRoute(builder:(BuildContext context)=>ViewPage(notes: notes[idx],note_date: note_date[idx],)));
              setState(() {            
              notes[idx]=result['edited_note'];
              //take newest edit to top
              String new_top_note;
              new_top_note=notes.removeAt(idx);
              notes.insert(0,new_top_note);
              note_date[idx]=result['edited_date'];
              //using the same variable for date
              new_top_note=note_date.removeAt(idx);
              note_date.insert(0,new_top_note);
              save_note();
              });
              
            },
            onLongPress: () {
              
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          //return data from editpage and also navigator to editpage
          Map result =await Navigator.push(context,MaterialPageRoute(builder:(BuildContext context)=>CreatePage()));
          setState(() {
            if(result['new_note']!=null && result['new_note']!=''){
            notes.insert(0,result['new_note']);
            note_date.insert(0,result['note_date']);
            ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.grey[400],
                      content: Text(
                        "Note Created",
                        style:TextStyle(
                          color:Colors.black,
                        ),
                        ),
                      ),
                    );
            save_note();
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.grey[400],
                      content: Text(
                        "Empty note not created",
                        style:TextStyle(
                          color:Colors.black,
                        ),
                        ),
                      ),
                    );
            }
          });
        },
        tooltip: 'Add new note',
        child: Icon(Icons.add),
      ),
    );
  }
}
