import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget {
  const ImageView({
    Key? key,
    required this.imageFile,
  }) : super(key: key);

  final Future<File?> imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: FutureBuilder<File>(
        future: imageFile.then((value) => value!),
        builder: (_, snapshot) {
          final file = snapshot.data;
          if (file == null) return Container();
          return PhotoView(
            imageProvider: FileImage(file),
          );
        },
      ),
    );
  }
}
