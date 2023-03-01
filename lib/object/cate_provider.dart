import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp_todo/object/category.dart';

class CateProvider {
  CollectionReference catetodo =
      FirebaseFirestore.instance.collection('category');

  Future createcategory(String name, String uid_user) async {
    return await catetodo.add({
      "name": name,
      "uid_user": uid_user,
    });
  }

  List<Cate> CateFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Cate(
          id: e.id,
          uid_user: (e.data() as dynamic)['uid_user'],
          name: (e.data() as dynamic)['name'],
        );
      }).toList();
    } else {
      return null!;
    }
  }

  Stream<List<Cate>> Catetodo() {
    return catetodo.snapshots().map(CateFromFirestore);
  }
}
