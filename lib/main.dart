import 'package:flutter/material.dart';
import 'package:commission_mobile_poo/main_title_text.dart';
import 'package:commission_mobile_poo/section_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Commission POO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BasicPage(),
    );
  }
}

class BasicPage extends StatelessWidget {

  List<Post> posts = [
    Post(name: "Baye", time: "5 minutes", imagePath: "images/carnaval.jpg", desc: "Petit tour au Magic World, on s'est bien amusés et en plus il n'y avait pas grand monde. Bref, le kiff"),
    Post(name: "Cheikh", time: "2 jours", imagePath: "images/mountain.jpg", desc: "La montagne ca vous gagne"),
    Post(name: "Fall ", time: "1 semaine", imagePath: "images/work.jpg", desc: "Retour au boulot après plusieurs mois de confinement"),
    Post(name: "Kheuch", time: "5 ans", imagePath: "images/playa.jpg", desc: "Le boulot en remote c'est le pied: la preuve ceci sera mon bureau pour les prochaines semaines")
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("BSN : Baye Social Network"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset("images/cover.jpg", height: 200, fit: BoxFit.cover,),
                Padding(
                  padding: EdgeInsets.only(top: 125),
                  child: CircleAvatar(radius: 75, backgroundColor: Colors.white,
                    child: myProfilePic(72),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Spacer(),
                MainTitleText(data: "Cheikh Saam"),
                Spacer()
              ],
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text("Baay missi diale bi, boko dialé mou diale diali, boko dialoul mou dialeli kone nak dialale",
                  style: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic
                  ),
                  textAlign: TextAlign.center,
                )
            ),
            Row(
              children: [
                Expanded(child: buttonContainer(text: "Modifier le profil")),
                buttonContainer(icon: Icons.border_color)
              ],
            ),
            Divider(thickness: 2,),
            SectionTitle("A propos de moi"),
            aboutRow(icon: Icons.house, text: "Koki, Louga, Sénégal"),
            aboutRow(icon: Icons.work, text: "Designer and Developpeur Fullstack"),
            aboutRow(icon: Icons.favorite, text: "Celibataire sans enfant"),
            Divider(thickness: 2,),
            SectionTitle("Amis"),
            allFriends(width / 3.5),
            Divider(thickness: 2,),
            SectionTitle("Mes Posts"),
            allPosts()


          ],
        ),
      ),
    );
  }

  CircleAvatar myProfilePic(double radius) {
    return CircleAvatar(radius: radius, backgroundImage: AssetImage("images/profile.jpg"));
  }

  Container buttonContainer({IconData? icon, String? text}) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue
      ),
      child: (icon == null)
          ? Center(child: Text(text ?? "", style: TextStyle(color: Colors.white)))
          : Icon(icon, color: Colors.white,),
      height: 50,
    );
  }

  Widget aboutRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon),
        Padding(
          padding: EdgeInsets.all(5),
          child: Text(text),
        )
      ],
    );
  }

  Column friendsImage(String name, String imagePath, double width) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          width: width,
          height: width,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.grey)],
              color: Colors.blue

          ),

        ),
        Text(name),
        Padding(padding: EdgeInsets.only(bottom: 5))
      ],
    );
  }

  Row allFriends(double width) {
    Map<String, String> friends = {
      "Assane": "images/cat.jpg",
      "Cheikh": "images/sunflower.jpg",
      "Moussa": "images/duck.jpg"
    };
    List<Widget> children = [];
    friends.forEach((name, imagePath) {
      children.add(friendsImage(name, imagePath, width));
    });
    return Row(
      children: children,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }


  Column allPosts() {
    List<Widget> postToAdd = [];
    posts.forEach((element) {
      postToAdd.add(post(post: element));
    });
    return Column(children: postToAdd,);
  }

  Container post({required Post post}) {
    return Container(
      margin: EdgeInsets.only(top: 8, left: 3, right: 3),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              myProfilePic(20),
              Padding(padding: EdgeInsets.only(left: 8)),
              Text(post.name),
              Spacer(),
              timeText(post.setTime())
            ],
          ),
          Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Image.asset(post.imagePath, fit: BoxFit.cover,)
          ),
          Text(post.desc,
            style: TextStyle(
                color: Colors.blueAccent),
            textAlign: TextAlign.center,

          ),
          Divider(),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.favorite),
              Text(post.setLikes()),
              Icon(Icons.message),
              Text(post.setComments())
            ],
          )

        ],
      ),
    );
  }

  Text timeText(String time) {
    return Text("Il y a $time", style: TextStyle(color: Colors.blue),);
  }
}
