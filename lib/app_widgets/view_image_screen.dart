import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';

import 'custom_loading_widget.dart';

class ViewImageScreen extends StatefulWidget {
  final String imgUrl;
  const ViewImageScreen({super.key, required this.imgUrl});

  @override
  State<ViewImageScreen> createState() => _ViewImageScreenState();
}

class _ViewImageScreenState extends State<ViewImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(),
        actions: [
          IconButton(
              onPressed: () {
                downloadImage();
              },
              icon: const Icon(Icons.download_rounded))
        ],
      )
      ,
      extendBodyBehindAppBar: true, 
      body: Center(
          child: PhotoView(
              backgroundDecoration:
                  const BoxDecoration(color: Colors.transparent),
              loadingBuilder: (context, event) => const CustomLoadingWidget(),
              imageProvider: NetworkImage(widget.imgUrl))),
    );
  }

  Future<void> downloadImage() async {
    // var saveDir = await getTemporaryDirectory();
    final permission = await Permission.photos.request();
    if (permission.isGranted) {
      GallerySaver.saveImage(widget.imgUrl, albumName: "luck-kay")
          .then((value) => BotToast.showText(text: "Downloaded"));
    } else {
      debugPrint('Permission denied =(');
    }
  }
}
