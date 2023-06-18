import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freshsoc/services/database.dart';

class IdentityCard extends StatefulWidget {
  final User? user;
  const IdentityCard({required this.user, Key? key}) : super(key: key);

  @override
  _IdentityCardState createState() => _IdentityCardState();
}

class _IdentityCardState extends State<IdentityCard> {
  bool _isEditingNusnetId = false;
  bool _isEditingMatriculationNumber = false;

  late TextEditingController _nusnetIdController;
  late TextEditingController _matriculationNumberController;

  @override
  void initState() {
    super.initState();
    _nusnetIdController = TextEditingController();
    _matriculationNumberController = TextEditingController();

    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final db = DatabaseService(user: widget.user);
    final userData = await db.getUserDetails();
    _nusnetIdController.text = userData.nusnetId ?? '';
    _matriculationNumberController.text = userData.matriculationNumber ?? '';
  }

  @override
  void dispose() {
    _nusnetIdController.dispose();
    _matriculationNumberController.dispose();
    super.dispose();
  }

  void _toggleEditingNusnetId() {
    setState(() {
      _isEditingNusnetId = !_isEditingNusnetId;
      if (!_isEditingNusnetId) {
        _saveNUSNETId();
      }
    });
  }

  void _toggleEditingMatriculationNumber() {
    setState(() {
      _isEditingMatriculationNumber = !_isEditingMatriculationNumber;
      if (!_isEditingMatriculationNumber) {
        _saveMatriculationNumber();
      }
    });
  }

  Future<void> _saveNUSNETId() async {
    if (_nusnetIdController.text.isNotEmpty) {
      final db = DatabaseService(user: widget.user);
      await db.updateUserNUSNETID(
        widget.user!.uid,
        _nusnetIdController.text,
      );
    }
  }

  Future<void> _saveMatriculationNumber() async {
    if (_matriculationNumberController.text.isNotEmpty) {
      final db = DatabaseService(user: widget.user);
      await db.updateUserMatriculationNumber(
        widget.user!.uid,
        _matriculationNumberController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
                controller: _nusnetIdController,
                decoration: InputDecoration(labelText: 'NUSNET ID'),
                enabled: _isEditingNusnetId,
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: _toggleEditingNusnetId,
              child: Text(_isEditingNusnetId ? 'Save' : 'Edit'),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
                controller: _matriculationNumberController,
                decoration: InputDecoration(labelText: 'Matriculation Number'),
                enabled: _isEditingMatriculationNumber,
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: _toggleEditingMatriculationNumber,
              child: Text(_isEditingMatriculationNumber ? 'Save' : 'Edit'),
            ),
          ],
        ),
      ],
    );
  }
}
