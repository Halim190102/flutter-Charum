import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(
    source: source,
  );

  if (file != null) {
    return file;
  }
}

Future cropImage(
  ImageSource source,
) async {
  XFile? xfile = await pickImage(source);

  if (xfile != null) {
    CroppedFile? cropped = await ImageCropper()
        .cropImage(sourcePath: xfile.path, aspectRatioPresets: [
      CropAspectRatioPreset.square,
    ], uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Crop',
          cropGridColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(title: 'Crop')
    ]);

    if (cropped != null) {
      return cropped.path;
    } else {
      return null;
    }
  }
}
