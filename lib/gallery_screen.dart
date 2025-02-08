import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/Image_list.dart';


class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final List<XFile> selectedImages = [];
  final ImagePicker picker = ImagePicker();

  Future<void> pickImages(ImageSource source) async {
    if (source == ImageSource.gallery) {
      // Pick multiple images from the gallery
      final List<XFile> images = await picker.pickMultiImage();
      if (images.isNotEmpty) {
        setState(() => selectedImages.addAll(images));
      }
    } else if (source == ImageSource.camera) {
      // Capture an image using the camera
      final XFile? image = await picker.pickImage(source: source);
      if (image != null) {
        setState(() => selectedImages.add(image));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,),
      body:  Column(
        children: [
          Expanded(
            child: selectedImages.isEmpty
                ? const Center(child: Text('No images to view, Please pick image or take a photo'))
                : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: selectedImages.length,
              itemBuilder: (context, index) => ImageList(
                imagePath: selectedImages[index].path,

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => pickImages(ImageSource.gallery),
                  child: const Text('Pick Images'),
                ),
                ElevatedButton(
                  onPressed: () => pickImages(ImageSource.camera),
                  child: const Text('Take Photo'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}