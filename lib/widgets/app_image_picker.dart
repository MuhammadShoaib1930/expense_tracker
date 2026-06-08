import 'package:expense_tracker/services/image_picker_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class AppImagePicker extends StatelessWidget {
  const AppImagePicker({super.key, required this.isDark});
  final bool isDark;
  @override
  Widget build(BuildContext context) {
    final ImagePickerServices imagePickerServices = ImagePickerServices();
    return Dialog(
      child: SizedBox(
        height: 230.h,
        width: 100.w,
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Column(
            spacing: 10,
            children: [
              Shimmer.fromColors(
                baseColor: (isDark) ? Colors.white : Colors.black,
                highlightColor: Colors.blue,
                child: Text(
                  "Pick image",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  await imagePickerServices.imagePick(isCamera: true);
                },
                label: Text("Camera"),
                icon: Icon(Icons.camera),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  await imagePickerServices.imagePick(isCamera: false);
                },
                label: Text("Gallery"),
                icon: Icon(Icons.folder),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 15,
                children: [
                  ElevatedButton.icon(onPressed: () async{
                      await imagePickerServices.saveImage();

                  }, label: Text("Set"), icon: Icon(Icons.save)),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.pop();
                    },
                    label: Text("Close"),
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
