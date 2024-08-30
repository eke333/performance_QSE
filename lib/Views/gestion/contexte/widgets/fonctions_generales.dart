import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FonctionsGenerales extends StatefulWidget {
  const FonctionsGenerales({Key? key}) : super(key: key);

  @override
  State<FonctionsGenerales> createState() => _FonctionsGeneralesState();
}

class _FonctionsGeneralesState extends State<FonctionsGenerales> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isEditing = false;
  int? _existingId;

  Future<void> _fetchTextFromAPI() async {
    final response = await http.get(Uri.parse('http://localhost:5000/get-text'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _existingId = data['id'];
        _textController.text = data['libelle'];
      });
    } else {
      throw Exception('Failed to load text');
    }
  }

  Future<void> _saveTextToAPI(String newText) async {
    if (_existingId == null) return;

    final response = await http.post(
      Uri.parse('http://localhost:5000/update-text'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'id': _existingId, 'libelle': newText}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save text');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTextFromAPI();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _saveTextToAPI(_textController.text);
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 800,
        height: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(1)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                color: Colors.amber,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Environnement de l\'entreprise',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isEditing ? Icons.check : Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isEditing = !_isEditing;
                        if (!_isEditing) {
                          _saveTextToAPI(_textController.text);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: _isEditing
                    ? TextFormField(
                  controller: _textController,
                  focusNode: _focusNode,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
                    : Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _textController.text,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
