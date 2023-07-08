import 'package:celient_project/res/colors/colors.dart';
import 'package:celient_project/view_model/controller/loadDetail/loadDetail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowBottom extends StatelessWidget {
  final loadVM = Get.put(loadDetailViewModel());
  final int containerIndex;
  final Function(String?)? onImageSelected;
  ShowBottom({Key? key, required this.containerIndex, this.onImageSelected }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: AppColor.whiteColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 5.2,
        margin: const EdgeInsets.only(top: 8.0),
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                child: const Column(
                  children: [
                    Icon(
                      Icons.image,
                      size: 60.0,
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      "Gallery",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        color: AppColor.blackColor,
                        fontSize: 19,),
                    ),
                  ],
                ),


                onTap: () async {
                  String? imagePath = await loadVM.imgFromGallery(containerIndex);
                  print('Gallery Image Path: $imagePath');
                  onImageSelected?.call(imagePath);
                  Get.back();
                },



              ),
            ),
            Expanded(
              child: InkWell(
                child: const SizedBox(
                  child: Column(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 60.0,
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        "Camera",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          color: AppColor.blackColor,
                          fontSize: 19,),
                      ),
                    ],
                  ),
                ),

                onTap: () async {
                  String? imagePath = await loadVM.imgFromCamera(containerIndex);
                  print('Camera Image Path: $imagePath');
                  onImageSelected?.call(imagePath);
                  Get.back();
                },



              ),
            ),
          ],
        ),
      ),
    );
  }
}


