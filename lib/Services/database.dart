import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/models/brew.dart';
import 'package:fire/models/user.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference brewCollection=Firestore.instance.collection("brews");

  Future updateUserData(String sugars,String name,int strength) async{
    return await brewCollection.document(uid).setData({
      "sugars":sugars,
      "name":name,
      "strength":strength,
    });
  }
//list from snapshot
  List<Brew> _brewlistfromsnapshot(QuerySnapshot querySnapshot){
    return querySnapshot.documents.map((doc){
      return Brew(
          name:doc.data['name'] ?? '',
          sugars:doc.data['sugars'] ?? '0',
          strength:doc.data['strength'] ?? 0);

    }).toList();
  }
//user data from snapshot
UserData _userdatafromsnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars:snapshot.data['sugars'],
      strength:snapshot.data['strength'] );


}

  //get streams if something is edited
Stream<List<Brew>> get brews{
    return brewCollection.snapshots()
        .map(_brewlistfromsnapshot);
}
//get user doc stream
Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots()
    .map(_userdatafromsnapshot);
}
}