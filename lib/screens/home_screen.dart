import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../models/note.dart';
import '../services/database_helper.dart';
import 'edit_note_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> allNotes = [];
  List<Note> filteredNotes = [];
  bool isGridView = true;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  _refreshNotes() async {
    final data = await DatabaseHelper.instance.getAllNotes();
    setState(() {
      allNotes = data;
      _filterNotes(searchQuery);
    });
  }

  _filterNotes(String query) {
    setState(() {
      searchQuery = query;
      filteredNotes = allNotes
          .where(
            (n) =>
                n.title.toLowerCase().contains(query.toLowerCase()) ||
                n.content.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ghi chú cá nhân"),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () => setState(() => isGridView = !isGridView),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Tìm kiếm ghi chú...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white10,
              ),
              onChanged: _filterNotes,
            ),
          ),
        ),
      ),
      body: filteredNotes.isEmpty
          ? Center(child: Text("Không có ghi chú nào"))
          : isGridView
          ? _buildGrid()
          : _buildList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openEdit(null),
      ),
    );
  }

  Widget _buildGrid() {
    return MasonryGridView.count(
      padding: EdgeInsets.all(8),
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: filteredNotes.length,
      itemBuilder: (context, index) => _noteCard(filteredNotes[index]),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: filteredNotes.length,
      itemBuilder: (context, index) => _noteCard(filteredNotes[index]),
    );
  }

  Widget _noteCard(Note note) {
    return GestureDetector(
      onTap: () => _openEdit(note),
      onLongPress: () => _confirmDelete(note.id!),
      child: Card(
        color: Color(note.colorValue),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      note.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (note.isPinned == 1)
                    Icon(Icons.push_pin, size: 16, color: Colors.blue),
                ],
              ),
              SizedBox(height: 8),
              Text(note.content, maxLines: 6, overflow: TextOverflow.ellipsis),
              SizedBox(height: 10),
              Text(
                note.createdAt,
                style: TextStyle(fontSize: 10, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _openEdit(Note? note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditNoteScreen(note: note)),
    );
    _refreshNotes();
  }

  _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Xóa ghi chú?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text("Hủy")),
          TextButton(
            onPressed: () async {
              await DatabaseHelper.instance.delete(id);
              Navigator.pop(ctx);
              _refreshNotes();
            },
            child: Text("Xóa"),
          ),
        ],
      ),
    );
  }
}
