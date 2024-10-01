// ignore_for_file: unnecessary_question_mark

class User {
  Location? location;
  String? sId;
  String? firstname;
  String? lastname;
  String? password;
  String? email;
  String? phone;
  bool? isOnline;
  String? bio;
  String? dob;
  String? gender;
  String? profilePicture;
  List<String>? interests;
  List<String>? photos;
  bool? isRegistered;
  String? createdAt;
  String? updatedAt;
  String? username;

  User(
      {this.location,
      this.sId,
      this.firstname,
      this.lastname,
      this.password,
      this.email,
      this.phone,
      this.isOnline,
      this.bio,
      this.dob,
      this.gender,
      this.profilePicture,
      this.interests,
      this.photos,
      this.isRegistered,
      this.createdAt,
      this.updatedAt,
      this.username});

  User.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    password = json['password'];
    email = json['email'];
    phone = json['phone'];
    isOnline = json['isOnline'];
    bio = json['bio'];
    dob = json['dob'];
    gender = json['gender'];
    profilePicture = json['profile_picture'];
    interests = json['interests'].cast<String>();
    photos = json['photos'].cast<String>();
    isRegistered = json['isRegistered'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['password'] = password;
    data['email'] = email;
    data['phone'] = phone;
    data['isOnline'] = isOnline;
    data['bio'] = bio;
    data['dob'] = dob;
    data['gender'] = gender;
    data['profile_picture'] = profilePicture;
    data['interests'] = interests;
    data['photos'] = photos;
    data['isRegistered'] = isRegistered;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['username'] = username;
    return data;
  }
}

class Location {
  Null? latitude;
  Null? longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
