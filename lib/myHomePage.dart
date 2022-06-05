import 'package:flutter/material.dart';
import 'package:notebook/createpage.dart';
import 'package:notebook/viewpage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> notes=[];
  List<String> note_date=[];

  SharedPreferences? prefs;

  void save_note() async{
    prefs =await SharedPreferences.getInstance();
    prefs!.setStringList('notes', notes);
    prefs!.setStringList('note_date', note_date);
  }

  void retrieve_note() async{
    prefs =await SharedPreferences.getInstance();
    notes = prefs!.getStringList('notes')!;
    note_date = prefs!.getStringList('note_date')!;
    setState(() {
      
    });
  }

  @override
  void initState(){
    super.initState();
    retrieve_note();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.deepPurple,
        title: const Text('My Notebook'),
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                notes=notes.reversed.toList();
                note_date=note_date.reversed.toList();
              });
            },
            icon: const Icon(Icons.reorder),
            ),
        ],
        elevation: 0,
      ),

      body:ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: notes.length,
        separatorBuilder:(BuildContext context, int idx) => const SizedBox(height: 5,),
        itemBuilder: (BuildContext context, int idx){
          return ListTile(
            tileColor: Colors.deepPurple[50],
            title: Text(
              notes[idx],
              maxLines:1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
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
                showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      title:const Text('Delete Note'),
                      content: const Text('Do you want to delete this note?'),
                      actions: [
                        TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          }, 
                          child: const Text('No')
                          ),
                          TextButton(
                          onPressed: (){
                              setState(() { 
                                notes.removeAt(idx);
                                note_date.removeAt(idx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.grey[400],
                                    content: const Text(
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
                          child: const Text('Yes')
                          ),
                      ],
                    );
                  }
                  );
              },
              icon: const Icon(Icons.delete),
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
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.deepPurple,
        onPressed: () async{
          //return data from editpage and also navigator to editpage
          Map result =await Navigator.push(context,MaterialPageRoute(builder:(BuildContext context)=>const CreatePage()));
          setState(() {
            if(result['new_note']!=null && result['new_note']!=''){
            notes.insert(0,result['new_note']);
            note_date.insert(0,result['note_date']);
            ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.grey[400],
                      content: const Text(
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
                      content: const Text(
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
