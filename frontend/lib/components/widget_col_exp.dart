// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';

class ColExpand extends StatefulWidget {
  const ColExpand({super.key, required this.title, required this.content});
  final String title;
  final String content;

  @override
  State<ColExpand> createState() => _ColExpandState();
}

class _ColExpandState extends State<ColExpand> {
  bool _showContent = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 3, bottom: 5, top: 2, right: 3),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.grey, width: .5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.title,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _showContent = !_showContent;
                });
              },
              icon: Icon(
                _showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              ),
            ),
          ),
          _showContent ? Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              widget.content,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          )
          : Container()
        ],
      ),
    );
  }
}
