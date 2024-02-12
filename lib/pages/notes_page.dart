import 'package:flutter/material.dart';
import 'package:noteapp/models/note.dart';
import 'package:noteapp/models/note_database.dart';
import 'package:provider/provider.dart';
import 'package:noteapp/components/drawer.dart';
import 'package:noteapp/components/note_tile.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();

}

class _NotesPageState extends State<NotesPage> {
 //text controller to access what the user typed
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();


    //on app startup, fetch existing notes
    readNotes();
  }
  // create a note
  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          content: TextField(
            controller: textController,
        ),
        actions: [
        //create button
        MaterialButton(
          onPressed: () {
            context.read<NoteDatabase>().addNote(textController.text);

            //clear context
            textController.clear();

            //pop dialog box
            Navigator.pop(context);

      },
          child: const Text("Создать"),
        )


    ],

    ),
    );
  }
  //read notes
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }
  //update a note
  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("Обновить"),
        content: TextField(controller: textController),
        actions: [
          MaterialButton(onPressed: () {
            //update note in database
            context
                .read<NoteDatabase>()
                .updateNote(note.id, textController.text);
            //clear controller
            textController.clear();
            //pop dialog
            Navigator.pop(context);

          },
          child: const Text("Обновить"),
          )

        ],
      ),
    );
  }

  //delete a note
 void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
 }

  @override
  Widget build(BuildContext context) {
    // note database
    final noteDatabase = context.watch<NoteDatabase>();

    //current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //HEADING
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text('Заметки'),
          ),
          //LIST OF NOTES
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
            //get individual note
            final note = currentNotes[index];

            //list title ui
            return NoteTile(
                text: note.text,
                onEditPressed: () => updateNote(note),
                onDeletePressed: () => deleteNote(note.id),
            );
            },
            ),
          ),
        ],
      ),
    );
  }
}