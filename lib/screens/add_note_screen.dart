import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.push_pin_outlined),
              splashRadius: 20),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.notification_add_outlined),
              splashRadius: 20),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.archive_outlined),
              splashRadius: 20),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          TextFormField(
            style: TextStyle(fontSize: 20),
            maxLines: 1,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Title",
              contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
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
                icon: Icon(Icons.add_box_outlined),
                splashRadius: 20),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.color_lens_outlined),
                splashRadius: 20),
            Spacer(),
            Text("Edited Aug 7"),
            Spacer(),
            Opacity(
              opacity: 0,
              child: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.more_vert_outlined),
                  splashRadius: 20),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert_outlined,
              ),
              splashRadius: 20,
            )
          ],
        ),
      ),
    );
  }
}
