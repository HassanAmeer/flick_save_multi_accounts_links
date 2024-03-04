// To parse this JSON data, do
//
//     final getUserData = getUserDataFromJson(jsonString);

import 'dart:convert';

GetUserData getUserDataFromJson(String str) =>
    GetUserData.fromJson(json.decode(str));

String getUserDataToJson(GetUserData data) => json.encode(data.toJson());

class GetUserData {
  String? name;
  String? email;
  String? phone;
  String? profession;
  String? organization;
  String? userImage;
  bool? isActive;
  bool? isDirect;
  List? deviceTokens;
  List<SocialMedia>? socialMedia;
  bool? isChoosedCatgBtnOptions;
  bool? isEnabledLostMode;

  GetUserData({
    this.name,
    this.email,
    this.phone,
    this.profession,
    this.organization,
    this.userImage,
    this.isActive,
    this.deviceTokens,
    this.socialMedia,
    this.isDirect,
    this.isChoosedCatgBtnOptions,
    this.isEnabledLostMode,
  });

  factory GetUserData.fromJson(Map<String, dynamic> json) => GetUserData(
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      profession: json["profession"],
      organization: json["organization"],
      userImage: json["userImage"] ?? " ",
      isActive: json["isActive"],
      isDirect: json["directMode"],
      deviceTokens: json["deviceToken"] ?? [],
      isChoosedCatgBtnOptions: json["isChoosedCatgBtnOptions"] ?? false,
      isEnabledLostMode: json["isEnabledLostMode"] ?? false,
      socialMedia: json["socialMedia"] == null
          ? []
          : List<SocialMedia>.from(
              json["socialMedia"]!.map((x) => SocialMedia.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "profession": profession,
        "organization": organization,
        "userImage": userImage,
        "isActive": isActive,
        "directMode": isActive,
        // "isChoosedCatgBtnOptions": isChoosedCatgBtnOptions ?? false,
        "socialMedia": socialMedia == null
            ? []
            : List<dynamic>.from(socialMedia!.map((x) => x.toJson())),
      };
}

class SocialMedia {
  String? socialMediaName;
  String? socialMediaType;
  String? socialMediaLink;
  String? category;
  bool? isActive;
  String? id;
  bool? socialMediaDirectMode;

  SocialMedia({
    this.socialMediaName,
    this.socialMediaType,
    this.socialMediaLink,
    this.category,
    this.isActive,
    this.id,
    this.socialMediaDirectMode,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
        socialMediaName: json["socialMediaName"],
        socialMediaType: json["socialMediaType"],
        socialMediaLink: json["socialMediaLink"],
        category: json["category"],
        isActive: json["isActive"],
        id: json["_id"],
        socialMediaDirectMode: json["socialMediaDirectMode"],
      );

  Map<String, dynamic> toJson() => {
        "socialMediaName": socialMediaName,
        "socialMediaType": socialMediaType,
        "socialMediaLink": socialMediaLink,
        "category": category,
        "isActive": isActive,
        "_id": id,
        "socialMediaDirectMode": socialMediaDirectMode,
      };
}
