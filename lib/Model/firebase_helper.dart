import 'package:chat_genie/Model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  static Future<UserModel?> getUserModelById(String uid) async{
    UserModel? usermodel;

     DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection("users").doc(uid).get();

     if(docSnap.data() != null){
       usermodel = UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
     }
     return usermodel;
  }
}