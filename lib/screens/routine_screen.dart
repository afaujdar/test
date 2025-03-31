import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../app_constants.dart';
import '../utilities/common_methods.dart';
import '../utilities/image_handling.dart';

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  Map<String, String?> uploadedImages = {}; // Stores {routine: time}
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    fetchImages();
    super.initState();
  }

  Future<void> pickAndSaveImage(String routineName) async {
    final XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      String? savedPath = await saveImageToLocal(imageFile, routineName);
      if (savedPath != null) {
        log("Image saved at: $savedPath");
        fetchImages(); // Refresh images after saving
      }
    }
  }

  Future<void> fetchImages() async {
    String today = DateTime.now().toIso8601String().split('T')[0];

    List<String> allTodayImages = await getImagesByDate(today);

    for (var routine in routines) {
      for (var image in allTodayImages) {
        if (image.contains(routine)) {
          uploadedImages[routine] = image;
          break;
        }
      }
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daily Skincare")),
      body: ListView.builder(
        itemCount: routines.length,
        itemBuilder: (context, ind) {
          String routine = routines[ind];
          String? uploadTime = uploadedImages[routine]?.split(routine)[1].replaceFirst("_", "").replaceFirst(".jpg", "").replaceFirst("-", ":");

          return ListTile(
            leading: Container(
              decoration: BoxDecoration(
                color: Colors.pink.shade800.withOpacity(.1),
                borderRadius: BorderRadius.circular(5),
              ),
              width: 40,
              height: 40,
              child: (uploadTime != null)?const Icon( Icons.check):null, // Icon to indicate image
            ),
            title: Text(getTitle(ind), style: const TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text(getSubtitle(ind), style: TextStyle(color: Colors.pink.shade800, fontSize: 16)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => (uploadTime == null) ? pickAndSaveImage(routine) : null,
                  child: const Icon(Icons.camera_alt_outlined),
                ),
                const SizedBox(width: 3,),
                if (uploadTime != null) Text(uploadTime, style: TextStyle(color: Colors.pink.shade800, fontSize: 16, fontWeight: FontWeight.w400)) // Show time
              ],
            ),
          );
        },
      ),
    );
  }

  String getSubtitle(int ind) {
    return [
      "Cetaphil Gentle Skin Cleanser",
      "Thayers Witch Hazel Toner",
      "Kiehl's Ultra Facial Cream",
      "Supergoop Unseen Sunscreen SPF 40",
      "Glossier Birthday Balm Dotcom"
    ][ind];
  }

  String getTitle(int ind) {
    return ind == 4 ? "Lip Balm" : capitalize(routines[ind]);
  }
}
