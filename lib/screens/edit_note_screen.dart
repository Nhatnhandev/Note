import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/note.dart';
import '../services/database_helper.dart';

class EditNoteScreen extends StatefulWidget {
  final Note? note;
  EditNoteScreen({this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  int _selectedColor = 0xFFFFFFFF;
  bool _isPinned = false;

  final List<int> _colors = [
    0xFFFFFFFF,
    0xFFFFCDD2,
    0xFFC8E6C9,
    0xFFBBDEFB,
    0xFFFFF9C4,
  ];

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
      _selectedColor = widget.note!.colorValue;
      _isPinned = widget.note!.isPinned == 1;
    }
  }

  _saveNote() async {
    final title = _titleController.text;
    final content = _contentController.text;
    if (title.isEmpty) return;

    final note = Note(
      id: widget.note?.id,
      title: title,
      content: content,
      isPinned: _isPinned ? 1 : 0,
      colorValue: _selectedColor,
      createdAt: DateFormat('dd/MM HH:mm').format(DateTime.now()),
    );

    if (widget.note == null) {
      await DatabaseHelper.instance.insert(note);
    } else {
      await DatabaseHelper.instance.update(note);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(_selectedColor),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isPinned ? Icons.push_pin : Icons.push_pin_outlined),
            onPressed: () => setState(() => _isPinned = !_isPinned),
          ),
          IconButton(icon: Icon(Icons.check), onPressed: _saveNote),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Tiêu đề",
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _contentController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Nội dung...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          _colorPicker(),
        ],
      ),
    );
  }

  Widget _colorPicker() {
    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _colors.length,
        itemBuilder: (ctx, i) => GestureDetector(
          onTap: () => setState(() => _selectedColor = _colors[i]),
          child: Container(
            margin: EdgeInsets.all(8),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(_colors[i]),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
