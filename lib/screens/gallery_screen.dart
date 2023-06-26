import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '/widgets/asset_thumbnail.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  State createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<AssetEntity> assets = [];

  Future<void> _fetchAssets() async {
    assets = await PhotoManager.getAssetListRange(
      start: 0,
      end: 100000,
    );

    setState(() {});
  }

  @override
  void initState() {
    _fetchAssets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: assets.length,
        itemBuilder: (_, index) {
          return AssetThumbnail(
            asset: assets[index],
          );
        },
      ),
    );
  }
}
