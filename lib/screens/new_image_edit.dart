import 'dart:io';
import 'dart:typed_data';

import 'package:akugbe/providers/home_provider.dart';
import 'package:akugbe/screens/create_post.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

class NewImageEdit extends ConsumerStatefulWidget {
  const NewImageEdit({super.key});

  @override
  ConsumerState createState() => _NewImageEditState();
}

class _NewImageEditState extends ConsumerState<NewImageEdit>
    with AppNavigator, TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeRef = ref.watch(homeProvider);
    return Scaffold(
        body: ProImageEditor.file(File(homeRef.newImageToPost!.path),
            callbacks: ProImageEditorCallbacks(
                onImageEditingComplete: (Uint8List image) async {
                  print(image.length);
                  homeRef.editedImageToPost = image;
                  pushTo(context, const CreatePost());

                })));
  }
}
