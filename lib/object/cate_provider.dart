import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp_todo/object/category.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CateProvider {
  CollectionReference catetodo =
      FirebaseFirestore.instance.collection('category');

  Future createcategory(String name, String uid_user, String icon) async {
    return await catetodo.add({
      "name": name,
      "uid_user": uid_user,
      "icon": icon,
    });
  }

  final accid = FirebaseAuth.instance.currentUser?.uid;
  List<Cate> CateFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Cate(
          id: e.id,
          uid_user: (e.data() as dynamic)['uid_user'],
          name: (e.data() as dynamic)['name'],
          icon: (e.data() as dynamic)['icon'],
        );
      }).toList();
    } else {
      return null!;
    }
  }

  Stream<List<Cate>> Catetodo() {
    return catetodo
        .where('uid_user', isEqualTo: accid)
        .snapshots()
        .map(CateFromFirestore);
  }

  Future removecate(uid) async {
    await catetodo.doc(uid).delete();
  }

  Future delelecate(uid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentReference cateReference = firestore.collection("category").doc(uid);

    cateReference.delete();

    CollectionReference todoReference = firestore.collection("listtodo");

    todoReference.where("category", isEqualTo: uid).get().then((querySnapshot) {
      querySnapshot.docs.forEach((documentSnapshot) {
        documentSnapshot.reference.delete();
      });
    });
  }
}
