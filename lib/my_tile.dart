import 'package:flutter/material.dart';
class MyTile extends StatefulWidget {
  const MyTile({super.key});

  @override
  State<MyTile> createState() => _MyTileState();
}

class _MyTileState extends State<MyTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
         Text('data'),
         IconButton(
             onPressed: (){},
             icon: const Icon(Icons.edit),

         ),
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.edit),

          ),
        ],
      ),
    );
  }
}
