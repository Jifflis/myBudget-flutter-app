import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybudget/controller/image_selector_controller.dart';
import 'package:oktoast/oktoast.dart';

import 'budget_button.dart';


class ImageSelectorWidget extends StatelessWidget {
   const ImageSelectorWidget({
    Key key, 
    @required  this.imageName,
    @required  this.callbackPath,
  }) : super(key: key);

  final String imageName;
  final Function(String) callbackPath;

  @override
  Widget build(BuildContext context) {
    final ImageSelectorController controller = Get.put(ImageSelectorController());
    controller.initImagefile(imageName);

    return WillPopScope(
      onWillPop: () async {
        await controller.reset();
        Navigator.pop(context, false);
        return false;
      }, 
      child: GetBuilder<ImageSelectorController>(builder: (_){
        return Container(
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 40),
        margin: const EdgeInsets.symmetric(vertical: 17, horizontal: 17),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 20),
            imageViewer(controller),
            const SizedBox(height: 20),
            imageOptions(controller),
            const SizedBox(height: 30),
            BudgetButton( !controller.changes ? null : () async{
              final String finalPath = await controller.saveImage();
              if(finalPath!=null){
                showToast('Success', position: ToastPosition.bottom);
                callbackPath(finalPath);
              }else{
                showToast('Failed to save image', position: ToastPosition.bottom);
              }
            }, 'Save'),
            const SizedBox(height: 10),
            BudgetButton(() {
              controller.reset();
              callbackPath(null);
            }, 'Cancel'),
            const SizedBox(height: 20),
          ],
        ),
      );
    }));
  }

  /// Image Options
  /// 
  /// 
  Widget imageOptions(ImageSelectorController controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          imageOption(
            label: 'Camera',
            icon: Icons.camera_alt,
            onPressed: () async {
              
              try{
                final String path = await controller.platform.invokeMethod('showCamera', <dynamic, String>{'name':'img_$imageName'});
                if(path != null){
                  controller.imagePath = path;
                  imageCache.clear();
                  imageCache.clearLiveImages();
                  controller.imageFile = File(controller.imagePath);
                }
              }on PlatformException catch(e){
                print(e.toString());
              }
            },
          ),
          imageOption(
            label: 'Gallery',
            icon: Icons.image,
            onPressed: () async {
              await controller.platform.invokeMethod('showGallery');
            },
          ),
        ],
      );

  /// Image Viewer
  /// 
  /// 
  Widget imageViewer(ImageSelectorController controller) => Container(
        height: 200,
        width: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          border: Border.all(
            color: Colors.purple,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children:  <Widget>[
            if(controller.imageFile == null)
            Container(
              height: 198,
              width: 200,
              alignment: Alignment.center,
              child: const Text(
                'No Image',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.purple,
                ),
              ),
            ),
            if(controller.imageFile != null)
            Container(
              padding: EdgeInsets.zero,
              height: 198,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                image: DecorationImage(
                  alignment: const Alignment(-.2, 0),
                  image: FileImage(controller.imageFile),
                  fit: BoxFit.fill
                )
              ),
             
            )
          ],
        ),
      );

  /// Image Option
  /// 
  /// 
  Widget imageOption({
    @required String label,
    @required IconData icon,
    @required Function onPressed,
  }) =>
      InkWell(
        onTap: onPressed,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                border: Border.all(color: Colors.purple),
              ),
              child: Icon(
                icon,
                size: 50,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.purple,
              ),
            )
          ],
        ),
      );
}



