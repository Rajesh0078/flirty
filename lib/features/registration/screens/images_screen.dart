import 'dart:io';
import 'package:flirty/commons/widgets/loader_screen.dart';
import 'package:flirty/commons/widgets/logo_title.dart';
import 'package:flirty/constants/colors.dart';
import 'package:flirty/features/home/screens/home_screen.dart';
import 'package:flirty/features/registration/services/registration_service.dart';
import 'package:flirty/utils/helpers/show_toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class ImagesScreen extends ConsumerStatefulWidget {
  const ImagesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends ConsumerState<ImagesScreen> {
  RegistrationService registrationService = RegistrationService();
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  List<XFile?> selectedImages = [null, null, null, null, null, null];

  // Function to pick an image
  Future<void> pickImage(int index) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImages[index] = image;
    });
  }

  Future<void> imageUploads() async {
    // Filter out null images from selectedImages
    if (selectedImages[0] == null) {
      ShowToaster()
          .succeesToast(context, "Select first image for profile picture");
      return;
    }
    List<XFile?> validImages =
        selectedImages.where((image) => image != null).toList();

    if (validImages.length < 3) {
      ShowToaster().succeesToast(context, "Upload at least 3 images!");
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Upload the images
    bool success = await registrationService.uploadImges(
      context,
      ref,
      validImages[0],
      validImages.sublist(1),
    );

    // Handle success or failure
    if (success) {
      ShowToaster().succeesToast(context, "Images uploaded successfully!");
      Navigator.pushAndRemoveUntil(
        context,
        PageAnimationTransition(
          page: HomeScreen(),
          pageAnimationType: FadeAnimationTransition(),
        ),
        (route) => false,
      );
    } else {
      ShowToaster()
          .succeesToast(context, "Failed to upload images. Please try again.");
    }

    // Reset loading state
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const LogoWidget(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Upload Your Images",
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Select Up to 5 Images of You! (1 mandatory)",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                buildImagePickerContainer(context, true, 0),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    buildImagePickerContainer(
                                        context, false, 1),
                                    SizedBox(width: 16),
                                    buildImagePickerContainer(
                                        context, false, 2),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width: 16),
                            Column(
                              children: [
                                buildImagePickerContainer(context, false, 3),
                                SizedBox(height: 16),
                                buildImagePickerContainer(context, false, 4),
                                SizedBox(height: 16),
                                buildImagePickerContainer(context, false, 5),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              imageUploads();
                            },
                            child: const Text("Continue"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            if (isLoading) const OverlayLoaderScreen(),
          ],
        ),
      ),
    );
  }

  Widget buildImagePickerContainer(
    BuildContext context,
    bool isWide,
    int index,
  ) {
    double containerWidth = isWide
        ? (((MediaQuery.of(context).size.width) - 24) * (2 / 3) - 24)
        : (((MediaQuery.of(context).size.width) - 24) * (1 / 3) - 20);

    return SizedBox(
      width: containerWidth,
      height: containerWidth,
      child: GestureDetector(
        onTap: () {
          pickImage(index);
        },
        child: DottedBorder(
          dashPattern: const [6, 3],
          color: CColors.secondary,
          strokeWidth: 1,
          borderType: BorderType.RRect,
          radius: const Radius.circular(16),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color:
                      selectedImages[index] == null ? Colors.transparent : null,
                ),
                child: selectedImages[index] != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16), // Clip corners
                        child: Image.file(
                          File(selectedImages[index]!.path),
                          fit: BoxFit.cover, // Use cover to fill the space
                          width: double.infinity, // Ensure it uses full width
                          height: double.infinity, // Ensure it uses full height
                        ),
                      )
                    : Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add,
                            color: CColors.secondary,
                            size: 38,
                          ),
                          Text(
                            index == 0 ? "Profile Icon" : "Images",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          )
                        ],
                      )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
