import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';

Future<String?> saveImageToLocal(XFile imageFile, String routineName) async {
  try {
    final directory = await getApplicationDocumentsDirectory();


    DateTime now = DateTime.now();

    String dateFolder = now.toIso8601String().split('T')[0];


    String timeStamp = DateFormat('hh-mm a').format(now);

    String folderPath = '${directory.path}/$dateFolder';


    await Directory(folderPath).create(recursive: true);

    String fileName = '${routineName}_$timeStamp.jpg';
    String filePath = '$folderPath/$fileName';

    File newImage = await File(imageFile.path).copy(filePath);

    return newImage.path;
  } catch (e) {
    log("Error saving image: $e");
    return null;
  }
}


Future<List<String>> getImagesByDate(String date) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    String folderPath = '${directory.path}/$date';

    Directory folder = Directory(folderPath);

    if (!await folder.exists()) {
      return [];
    }


    List<FileSystemEntity> files = folder.listSync();
    return files.map((file) => file.path).toList();
  } catch (e) {
    print("Error retrieving images: $e");
    return [];
  }
}


Future<List<String>> getAllImageDates() async {
  Directory imageDirectory = await getApplicationDocumentsDirectory(); // Update with actual path
  List<String> imageDates = [];

  if (await imageDirectory.exists()) {
    List<FileSystemEntity> files = imageDirectory.listSync();

    for (var file in files) {
      String fileName = file.uri.pathSegments.last;

      RegExp dateRegex = RegExp(r'\d{4}-\d{2}-\d{2}');
      Match? match = dateRegex.firstMatch(fileName);

      if (match != null) {
        String date = match.group(0)!;
        if (!imageDates.contains(date)) {
          imageDates.add(date);
        }
      }
    }
  }

  return imageDates;
}
