import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '/screens/gallery_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            PhotoManager.requestPermissionExtend().then(
              (PermissionState state) {
                if (state.isAuth) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const GalleryScreen(),
                    ),
                  );
                }
              },
            );
          },
          child: const Text('Open Gallery'),
        ),
      ),
    );
  }
}
