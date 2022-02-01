import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:uuid/uuid.dart';

class AppwriteService {
  late Client _client;
  late Account _account;
  late Database _database;

  AppwriteService() {
    _client = Client();
    _account = Account(_client);
    _database = Database(_client);
    _client
        .setEndpoint('https://10.0.2.2/v1') // Your Appwrite Endpoint
        .setProject('61f7b07cd28b50c3c539') // Your project ID
        .setSelfSigned(); // Use only on dev mode with a self-signed SSL cert
  }

  Future<bool> signUp({required String email, required String password, required String name}) async {
    try {
      await _account.create(userId: 'unique()', email: email, password: password, name: name);
      return true;
    } on AppwriteException catch (e) {
      log("AppwriteException: " + e.toString());
      return false;
    }
  }

  Future<Session?> login({required String email, required String password}) async {
    _account = Account(_client);
    try {
      return await _account.createSession(email: email, password: password);
    } on AppwriteException catch (e) {
      log("AppwriteException: " + e.toString());
      return null;
    }
  }

  anonymousLogin() async {
    return await _account.createAnonymousSession();
  }

  Future<bool> signOut() async {
    return await _account.deleteSession(sessionId: 'current').then(
      (value) {
        log("Session deleted");
        return true;
      },
    ).catchError((onError) {
      return false;
    });
  }

  Future<Session?> getSession() async {
    try {
      return await _account.getSession(sessionId: 'current');
    } catch (e) {
      log("message: " + e.toString());
      return null;
    }
  }

  Future<DocumentList> getJobList() async {
    return await _database.listDocuments(collectionId: 'jobs');
  }

  addSampleData() {
    _database.createDocument(
      collectionId: 'jobs',
      documentId: 'unique()',
      data: {
        "title": "Software Engineer",
        "company": "Google",
        "location": "Mountain View, CA",
        "description": "Developing software for Google's cloud infrastructure",
        "link": "https://www.google.com",
        "logo": "https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png"
      },
    );

    _database.createDocument(
      collectionId: 'jobs',
      documentId: 'unique()',
      data: {
        "title": "Fullstack Engineer",
        "company": "Appwrite",
        "location": "Tel Aviv",
        "description":
            "We're building a different kind of company that will create the next generation of developer tools, and we are looking for amazing people to jump on board.",
        "link": "https://appwrite.io",
        "logo": "https://demo.appwrite.io/v1/storage/files/61667e8e6cb16/preview?project=615d75f94461f"
      },
    );
  }
}
