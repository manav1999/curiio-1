import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

//all firebase auth stuff
/*
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String name;
  String email;

//String imageurl;

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    assert(user.email != null);
    assert(user.displayName != null);
    //assert(user.photoUrl!=null);

    name = user.displayName;
    email = user.email;
    //imageurl=user.photoUrl;

    return 'signInWithGoogle succeeded: $user';
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user;
  }

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
    print("user sign out");
  }
}
*/

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //Stream to check authState
  Stream<User> userdata =
      FirebaseAuth.instance.authStateChanges().asBroadcastStream();

  //used to register with email and pass

  Future registerWithEmail(String email, String pass) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: pass);
      verifyEmail(userCredential.user);
      print("Email sent for verification ");
      return userCredential;
    } catch (e) {
      print(e.toString());
      return e;
      //TODO: handle exception on sign up page
    }
  }

// used to sign in user
  Future signIn(String email, String pass) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return userCredential;
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  Future verifyEmail(User _user)async{
   try{
     await _user.sendEmailVerification();
     return null;
   }catch(e){
     print("Email Verification Error");
     rethrow ;
   }

  }
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future googleSignOut() async {
    await _googleSignIn.signOut();
    signOut();
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      return e ;
    }
  }
}
