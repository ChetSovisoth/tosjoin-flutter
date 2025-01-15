import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tosjoin/service/cloudflarr2.dart';
import 'package:tosjoin/service/color.dart';
import 'package:tosjoin/service/size.dart';

class ProfileUserWidget extends StatelessWidget {
  const ProfileUserWidget(
      {super.key, this.image, this.onGallery, this.onCamera});
  final dynamic image;
  final Function()? onCamera;
  final Function()? onGallery;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _dynamicProfile(image),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            child: CircleAvatar(
              backgroundColor:
                  Get.isDarkMode ? Colors.white24 : Colors.grey.shade100,
              child: Icon(
                Icons.camera_alt,
                color: Get.isDarkMode ? Colors.white70 : Colors.grey.shade800,
              ),
            ),
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kBorderRadius * 2),
                    topRight: Radius.circular(kBorderRadius * 2),
                  ),
                ),
                backgroundColor: Colors.white,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 150,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.photo),
                            title: Text('gallery'.tr),
                            onTap: onGallery,
                          ),
                          Divider(
                            height: 1,
                            color: Colors.grey,
                            indent: Get.width * 0.04,
                            endIndent: Get.width * 0.04,
                          ),
                          ListTile(
                            leading: const Icon(Icons.camera_alt),
                            title: Text('camera'.tr),
                            onTap: onCamera,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _dynamicProfile(Object? obj) {
    if (obj == null) {
      return CircleAvatar(
        radius: 56,
        backgroundColor: Get.isDarkMode ? Colors.white12 : kTextFieldColor,
        child: Icon(Icons.account_circle,
            size: 64,
            color: Get.isDarkMode ? Colors.white70 : Colors.grey.shade800),
      );
    }
    if (obj is String) {
      final cloudflareService = CloudflareR2Service();
      final imageUrl =
          obj.startsWith("http") ? obj : cloudflareService.getImageUrl(obj);

      return CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: 56,
          backgroundImage: imageProvider,
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return CircleAvatar(
            radius: 56,
            child: CircularProgressIndicator(
              value: downloadProgress.progress,
              valueColor: const AlwaysStoppedAnimation(kPrimaryColor),
              strokeWidth: 2,
            ),
          );
        },
        errorWidget: (context, url, error) {
          return CircleAvatar(
            radius: 56,
            backgroundColor: Get.isDarkMode ? Colors.white12 : kTextFieldColor,
            child: Icon(
              Icons.person,
              color: Get.isDarkMode ? Colors.white70 : Colors.grey.shade800,
              size: kIconSize,
            ),
          );
        },
      );
    } else if (obj is XFile) {
      return CircleAvatar(
        radius: 56,
        backgroundColor: kMainColor,
        backgroundImage: FileImage(File(obj.path)),
      );
    } else if (obj is File) {
      return CircleAvatar(
        radius: 56,
        backgroundColor: kMainColor,
        backgroundImage: FileImage(obj),
      );
    } else {
      return const CircleAvatar(
        radius: 56,
        child: Icon(Icons.error, size: 64, color: Colors.black87),
      );
    }
  }
}
