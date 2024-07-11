import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

void main () async{
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid ? await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: " ",
        appId: "1:671918980573:android:03032676b14d3145f44a34",
        messagingSenderId: '"671918980573"',
        projectId: "home-7ded2",
        storageBucket: "home-7ded2.appspot.com")
  )
  : await Firebase.initializeApp();
  runApp( const MaterialApp(
    home:Home(),
  ));
}


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Finding Home",
          style:TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),
      body: const Center(
        child:Image(
          image:AssetImage('assets/find your home here....jpg'),
          width: 410,
          height:610,
            fit: BoxFit.cover
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LogIn()),
          );
        },
        backgroundColor: Colors.blue[600],
        child:
        const Icon(
          Icons.home_filled,
          color: Colors.white,
          size: 30,
        ),
      ),
    ) ;
  }
}
class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Log in As..',
          style:TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,),
          ),
      backgroundColor: Colors.blue[800],
      ),
      body: Center(
          child :Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
            onTap: () {
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Buyer()),
            );
            },
              child: Column(
               mainAxisSize: MainAxisSize.min,
               children:[
                Ink.image(
                image: const AssetImage('assets/BUYER.jpg'),
                height:200,
                width:200,
                fit: BoxFit.cover,
                ),
              ]
             ),
             ),
            const SizedBox(height:50),
            InkWell(
             onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  Seller()),
              );
              },
              child: Column(
               mainAxisSize: MainAxisSize.min,
               children:[
                Ink.image(
                  image: const AssetImage('assets/SELLER.jpg'),
                  height:200,
                  width:200,
                  fit: BoxFit.cover,
                ),
              ]
            ),
            ),
          ]
          ),
      ),
    );
  }
}

 class Seller extends StatefulWidget {
  Seller({super.key});
  @override
  _SellerState createState() => _SellerState();
 }

class _SellerState extends State<Seller> {
  File? _selectedImage;
  String imagesUrl = '';


TextEditingController nameController =TextEditingController();
TextEditingController genderController =TextEditingController();
TextEditingController addressController =TextEditingController();
TextEditingController stateController =TextEditingController();
TextEditingController pinController =TextEditingController();
TextEditingController phoneController =TextEditingController();
TextEditingController emailController =TextEditingController();
TextEditingController otherController =TextEditingController();


Future<void> saveUser() async {
  String name = nameController.text.trim();
  String gender = genderController.text.trim();
  String address = addressController.text.trim();
  String state = stateController.text.trim();
  String pin = pinController.text.trim();
  String phone = phoneController.text.trim();
  String email = emailController.text.trim();
  String other = otherController.text.trim();

  if (name != "" && gender != "" && address != "" && state != "" && pin != "" &&
      phone != "" && other != "" && email != "") {
    Map<String, dynamic> userData = {
      "name": name,
      "gender": gender,
      "address": address,
      "state": state,
      "email": email,
      "other": other,
      "pin": pin,
      "phone": phone,
      "image" :imagesUrl,
    };

    if (_selectedImage != null) {
      Reference storageRef =
      FirebaseStorage.instance.ref().child('images').child(path.basename(_selectedImage!.path));
      UploadTask uploadTask = storageRef.putFile(_selectedImage!);
        await uploadTask;
      // Get download URL for the uploaded image
       imagesUrl = await storageRef.getDownloadURL();

      // Add download URL to userData
      userData['image'] = imagesUrl;
    }

    FirebaseFirestore.instance.collection("User").add(userData);
    log("User Created");
  }

  else {
    log("please fill the fields");

  }

}



   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: const Text(
           'Enter your Details..',
           style: TextStyle(
               color: Colors.white,
               fontSize: 25.0,
               fontWeight: FontWeight.bold),
         ),
         backgroundColor: Colors.blue[800],
       ),
       body:
        Padding(
         padding: const EdgeInsets.all(8.0),
         child: ListView(
           shrinkWrap: true,
           children: <Widget>[
                 Center(
                   child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                          TextField(
                           controller: nameController,
                           decoration: const InputDecoration(
                             labelText: 'Name',
                             hintText: 'Enter your name',
                             border: OutlineInputBorder(),
                           ),
                         ),
                         const SizedBox(height: 20),
                          TextField(
                           controller: genderController,
                           decoration: const InputDecoration(
                             labelText: 'Gender',
                             hintText: 'Enter your Gender',
                             border: OutlineInputBorder(),
                           ),
                         ),
                         const SizedBox(height: 20),
                          TextField(
                           controller: addressController,
                           decoration: const InputDecoration(
                             labelText: 'Address',
                             hintText: 'Enter the address of property',
                             border: OutlineInputBorder(),
                           ),
                         ),
                         const SizedBox(height: 20),
                         TextField(
                           controller: stateController,
                           decoration: const InputDecoration(
                             labelText: 'State ',
                             hintText: 'Enter your state',
                             border: OutlineInputBorder(),
                           ),
                         ),
                         const SizedBox(height: 20),
                          TextField(
                            controller: pinController,
                           decoration: const InputDecoration(
                             labelText: 'Pin Code',
                             hintText: 'Enter Pin code',
                             border: OutlineInputBorder(),
                           ),
                         ),
                         const SizedBox(height: 20),
                          TextField(
                           controller: phoneController,
                           decoration: const InputDecoration(
                             labelText: 'Phone no',
                             hintText: 'enter your contact no',
                             border: OutlineInputBorder(),
                           ),
                         ),
                         const SizedBox(height: 20),
                          TextField(
                            controller: emailController,
                           decoration: const InputDecoration(
                             labelText: 'Email Id',
                             hintText: 'enter your Email.id',
                             border: OutlineInputBorder(),
                           ),
                         ),
                         const SizedBox(height: 20),
                          TextField(
                           controller: otherController,
                           decoration: const InputDecoration(
                             labelText: 'Other Details',
                             hintText: 'Enter the details of property',
                             border: OutlineInputBorder(),
                           ),
                         ),
                         const SizedBox(height: 20),
                         const Text(
                             "Upload photo",
                             style: TextStyle(
                               color: Colors.blue ,
                               fontWeight: FontWeight.bold,
                               fontSize: 16,
                             )
                         ),
                         MaterialButton(
                           color: Colors.blue[800],
                           child: const Text(
                               "Pick image from gallery",
                               style: TextStyle(
                                 color: Colors.white,
                                 fontWeight: FontWeight.bold,
                                 fontSize: 16,
                               )
                           ),
                           onPressed: () {
                           _pickImageFromGallery();
                           }
                         ),
                         MaterialButton(
                             color: Colors.blue[800],
                             child: const Text(
                                 "Pick image from camera",
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 16,
                                 )
                             ),
                             onPressed: () {
                               _pickImageFromCamera();
                             }
                         ),

                         const SizedBox(height: 10),

                         _selectedImage != null? Image.file(_selectedImage!) : const Text("Please select an image"),
                         CupertinoButton(
                           onPressed:() {
                             saveUser();
                           }, child: const Text("Save"),
                         ),
                       ]
                   ),
                 ),
               ],
             ),
           ),
         );
   }

  Future<void> _pickImageFromGallery() async {
    XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      File imageFile = File(selectedImage.path);
      Reference ref = FirebaseStorage.instance.ref().child('images/${DateTime.now().toString()}');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      imagesUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        _selectedImage = imageFile;
      });

      // Call _uploadImage method here
      await _uploadImage(imageFile);
    } else {
      print('No image selected.');
    }
  }
        // Set the image URL



  Future<void> _pickImageFromCamera() async {
    XFile? selectedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (selectedImage != null) {
      File imageFile = File(selectedImage.path);
      Reference ref = FirebaseStorage.instance.ref().child('images/${DateTime.now().toString()}');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      imagesUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        _selectedImage = imageFile;
      });

      // Call _uploadImage method here
      await _uploadImage(imageFile);
    } else {
      print('No image selected.');
    }
  }



  Future<void> _uploadImage(File selectedImage) async {
    File imageFile = File(selectedImage.path);
    Reference ref = FirebaseStorage.instance.ref().child('images/${DateTime.now().toString()}');
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
    // Get the download URL for the uploaded image
    imagesUrl = await snapshot.ref.getDownloadURL();

    // Set the imageUrl variable in the Seller widget
    setState(() {
    imagesUrl = imagesUrl;
  });
}

 }

class Buyer extends StatefulWidget {


  const Buyer({super.key});

  @override
  State<Buyer> createState() => BuyerState();
}

class BuyerState extends State<Buyer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Properties',
          style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[800],
      ),
      body:
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('User').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.hasData) {
            final users = snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final userData = users[index].data() as Map<String, dynamic>?;

                final imagesUrl = userData?['image']?? 'Image not available';

                final name = userData?['name'] ?? 'Name not available';
                final gender = userData?['gender'] ?? 'Gender not available';
                final address = userData?['address'] ?? 'Address not available';
                final state = userData?['state'] ?? 'State not available';
                final pin = userData?['pin'] ?? 'Pin code not available';
                final phone = userData?['phone'] ?? 'Phone No not available';
                final email = userData?['email'] ?? 'Email not available';
                final other = userData?['other'] ?? 'Details not available';
                return ListTile(
                  leading:
                  Container(
                  width: 100, // Adjust width as needed
                  height: 100,
                  child: imagesUrl.isNotEmpty
                      ? Image.network(imagesUrl) : const Placeholder(),),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20), // Adjust the height as needed
                      Text(name),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Gender: $gender'),
                      Text('Address: $address'),
                      Text('State: $state'),
                      Text('Pin Code: $pin'),
                      Text('Phone no: $phone'),
                      Text('Email: $email'),
                      Text('Details: $other'),
                    ],
                  ),
                );
              },
            );
          }
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
