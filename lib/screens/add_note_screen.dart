import 'package:flutter/material.dart';
import 'package:google_keep_clone/db/notes_database.dart';
import 'package:google_keep_clone/models/note_model.dart';
import 'package:google_keep_clone/screens/home_screen.dart';
import 'package:intl/intl.dart';

class AddNoteScreen extends StatefulWidget {
  final NoteModel? note;

  const AddNoteScreen({Key? key, this.note}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  late String title;
  late String content;
  late DateTime createdTime;
  late String color;
  late String properDate;

  @override
  void initState() {
    super.initState();
    title = widget.note?.title ?? '';
    content = widget.note?.content ?? '';
    createdTime = widget.note?.createdTime ?? DateTime.now();
    color = widget.note?.color ?? '';
    properDate = DateFormat.yMMMd().format(createdTime);
  }

  @override
  Widget build(BuildContext context) {
    Color noteBgColor = Theme.of(context).scaffoldBackgroundColor;
    switch (color) {
      case 'red':
        noteBgColor = Colors.red.shade700;
        break;
      case 'orange':
        noteBgColor = Colors.orange.shade700;
        break;
      case 'yellow':
        noteBgColor = Colors.yellow.shade700;
        break;
      case 'green':
        noteBgColor = Colors.green.shade700;
        break;
      case 'blue':
        noteBgColor = Colors.blue.shade700;
        break;
      case 'violet':
        noteBgColor = Colors.purple.shade700;
        break;
      case 'purple':
        noteBgColor = Colors.deepPurple.shade700;
        break;
      default:
    }
    return Scaffold(
      backgroundColor: noteBgColor.withOpacity(0.7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            if (title == '' && content == '') {
              debugPrint("No Data");
            } else {
              if (widget.note == null) {
                addNote();
              } else {
                updateNote();
              }
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
            initialValue: title,
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
            initialValue: content,
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
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.all(14),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                colorCircle(context, Colors.red, 'red'),
                                colorCircle(context, Colors.orange, 'orange'),
                                colorCircle(context, Colors.yellow, 'yellow'),
                                colorCircle(context, Colors.green, 'green'),
                                colorCircle(context, Colors.blue, 'blue'),
                                colorCircle(context, Colors.purple, 'violet'),
                                colorCircle(
                                    context, Colors.deepPurple, 'purple'),
                              ],
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              "Pick a background color.",
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.color_lens_outlined),
                splashRadius: 20),
            const Spacer(),
            Text("Created $properDate"),
            const Spacer(),
            const Opacity(
              opacity: 0,
              child: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.more_vert_outlined),
                  splashRadius: 20),
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.all(14),
                    child: ListView(
                      children: [
                        ListTile(
                          visualDensity: VisualDensity(vertical: -3),
                          leading: Icon(Icons.delete),
                          title: Text("Delete Note"),
                          onTap: () async {
                            if (widget.note == null) {
                              Navigator.popUntil(
                                  context, ModalRoute.withName('/'));
                            } else {
                              await NotesDatabase.instance
                                  .delete(widget.note!.id!);
                              Navigator.popUntil(
                                  context, ModalRoute.withName('/'));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
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

  InkWell colorCircle(BuildContext context, Color c, String s) {
    return InkWell(
      onTap: () {
        setState(() {
          color = s;
        });
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.all(6),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Theme.of(context).primaryColorLight.withOpacity(0.8),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: c,
          ),
        ),
      ),
    );
  }

  Future<void> addNote() async {
    final note = NoteModel(
      title: title,
      content: content,
      createdTime: createdTime,
      color: color,
    );
    await NotesDatabase.instance.createNote(note);
  }

  Future<void> updateNote() async {
    final note = NoteModel(
      id: widget.note!.id,
      title: title,
      content: content,
      createdTime: createdTime,
      color: color,
    );
    await NotesDatabase.instance.updateNote(note);
  }
}
