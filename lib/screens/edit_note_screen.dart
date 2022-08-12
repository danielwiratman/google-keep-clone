import 'package:flutter/material.dart';
import 'package:google_keep_clone/db/notes_database.dart';
import 'package:google_keep_clone/models/note_model.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({Key? key, required int id}) : super(key: key);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late String title = "";
  late String content = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            if (title == '' && content == '') {
              debugPrint("No Data");
            } else {
              addNote(title, content);
            }
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          splashRadius: 20,
        ),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.push_pin_outlined),
              splashRadius: 20),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notification_add_outlined),
              splashRadius: 20),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.archive_outlined),
              splashRadius: 20),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          TextFormField(
            style: const TextStyle(fontSize: 20),
            maxLines: 1,
            onChanged: (value) => setState(() {
              title = value;
            }),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Title",
              contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: (value) => setState(() {
              content = value;
            }),
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Note",
                contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_box_outlined),
                splashRadius: 20),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.color_lens_outlined),
                splashRadius: 20),
            const Spacer(),
            const Text("Edited Aug 7"),
            const Spacer(),
            const Opacity(
              opacity: 0,
              child: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.more_vert_outlined),
                  splashRadius: 20),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert_outlined,
              ),
              splashRadius: 20,
            )
          ],
        ),
      ),
    );
  }

  Future<void> addNote(String title, String content) async {
    final note = NoteModel(
      title: title,
      content: content,
      createdTime: DateTime.now(),
      color: 'red',
    );
    await NotesDatabase.instance.createNote(note);
  }
}
