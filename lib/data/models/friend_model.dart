import 'package:cloud_firestore/cloud_firestore.dart';

class FriendModel {
  final String? id;
  final bool? isBlocked;

  FriendModel({
    this.id,
    this.isBlocked,
  });

  factory FriendModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return FriendModel(
      id: data?["addedFriend"],
      isBlocked: data?["blockedFriend"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "addedFriend": id,
      "blockedFriend": isBlocked,
    };
  }
}
