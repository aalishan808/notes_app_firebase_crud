import 'package:cloud_firestore/cloud_firestore.dart';

class Crud {
//get collection of notes from the database
late CollectionReference notes =
    FirebaseFirestore.instance.collection('notes');
  //create: adding a new note
  Future<void> addNote(String note){
  return notes.add({
    'note': note,
    'timestamp': Timestamp.now(),
});
}
  //read: getting note from database
  Stream<QuerySnapshot<Object?>> getNotesStream(){
    final notesStream =notes.orderBy('timestamp', descending:true).snapshots();
    return notesStream;
  }
  //update: updating a note
  Future<void> updateNote(String newNote, String docId){
    return notes.doc(docId).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }
  //delete: deleting a note
  Future<void> deleteNote(String docId){
    return notes.doc(docId).delete();
  }
}