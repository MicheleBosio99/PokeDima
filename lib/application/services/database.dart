import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final CollectionReference pokemonCollection = FirebaseFirestore.instance.collection('userCollection');
}