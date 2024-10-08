import 'base_model.dart';

class User extends BaseModel<User> {
  NotificationToken notificationToken;
  String avatarURL;
  //Status status;
  String username;
  String name;
  String email;
  bool emailVerified;
  String password;
  String phoneNumber;
  //bool socialProvider;

  User({String id}) : super('_User') {
    this.id = id;
    objectId = id;
  }

  User.fromMap(Map<dynamic, dynamic> map) : super('_User') {
    baseFromMap(map);
    notificationToken = map["notificationToken"] == null
        ? null
        : NotificationToken.fromMap(map["notificationToken"]);
    avatarURL = map["avatarURL"];
    username = map["username"];
    name = map["name"];
    email = map["email"];
    emailVerified =
        map["emailVerified"] == null ? false : map["emailVerified"] as bool;
    password = map["password"];
    phoneNumber = map["phoneNumber"];
    // socialProvider =
    //     map["socialProvider"] == null ? false : map["socialProvider"] as bool;
  }

  toMap() {
    var map = super.toMap();
    map["notificationToken"] = notificationToken?.toMap();
    map["avatarURL"] = avatarURL;
    map["username"] = username;
    map["name"] = name;
    //map["email"] = email;
    //map["emailVerified"] = emailVerified;
    map["password"] = password;
    map["createdAt"] = createdAt?.toString();
    map["updatedAt"] = updatedAt?.toString();
    map["phoneNumber"] = phoneNumber;
    //map["socialProvider"] = socialProvider;
    return map;
  }

  updateData(User item) {
    id = item.id;
    objectId = item.objectId;
    createdAt = item.createdAt;
    updatedAt = item.updatedAt;

    notificationToken = item.notificationToken;
    avatarURL = item.avatarURL;
    //status = item.status;
    username = item.username;
    name = item.name;
    email = item.email;
    emailVerified = item.emailVerified;
    password = item.password;
    createdAt = item.createdAt;
    updatedAt = item.updatedAt;
    phoneNumber = item.phoneNumber;
    //socialProvider = item.socialProvider;
  }

  bool isAnonymous() {
    return name.isEmpty &&
        username.isEmpty &&
        email.isEmpty &&
        password.isEmpty;
  }
}

class NotificationToken extends BaseModel<NotificationToken> {
  String token;
  bool active;
  List<String> topics;

  NotificationToken(this.token) : super('NotificationToken') {
    active = true;
  }

  NotificationToken.fromMap(Map<dynamic, dynamic> map)
      : super('NotificationToken') {
    baseFromMap(map);
    token = map["token"];
    active = map["active"] as bool;
    topics = map["topics"] == null ? [] : List.from(map["topics"]);
  }

  toMap() {
    var map = super.toMap();
    map["token"] = token;
    map["active"] = active;
    map["topics"] = topics == null ? [] : topics;
    return map;
  }

  @override
  void updateData(NotificationToken item) {
    id = item.id;
    objectId = item.objectId;
    token = item.token;
    active = item.active;
    topics = item.topics;
  }
}
