import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_firebase_crud/services/crud.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Crud crud = Crud();
  final TextEditingController noteController = TextEditingController();
  void openNoteBox({String? docId}){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text('Add Note'),
          content: TextField(
            controller: noteController,
            decoration: const InputDecoration(
              hintText: 'Enter your note',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: (){
                //add note to the database
                if(docId == null){
                  crud.addNote(noteController.text);
                }
                else{
                  crud.updateNote(noteController.text, docId);
                }
                noteController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Notes App'),
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream: crud.getNotesStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

          //if we have data get all the docs from the snapshot
          if(snapshot.hasData){
            List notesList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (BuildContext context, int index){
                //get each individual doc
                DocumentSnapshot document = notesList[index];
                String docId = document.id;
                //get note from the doc
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String noteText = data['note'];
                //display as a list tile
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(noteText),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //update button
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: (){
                            noteController.text = noteText;
                            openNoteBox(docId: docId);
                          },
                        ),

                        //delete button
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: (){
                            //update note from the database
                            crud.deleteNote(docId);
                          },
                        ),
                      ],
                    ),

                  ),
                );
              },
            );
          }
          else{
            return const Text("No notes..");
          }

        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openNoteBox();
        },
        child: const Icon(Icons.add),
      )
    );
  }
}
