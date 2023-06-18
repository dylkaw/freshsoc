import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:freshsoc/models/post_model.dart";
import "package:freshsoc/screens/home/components/profile_card.dart";
import "package:freshsoc/screens/socialize/components/post_card.dart";
import "package:freshsoc/screens/socialize/create_post.dart";
import "package:freshsoc/services/database.dart";
import "package:freshsoc/shared/constants.dart";
import "package:freshsoc/shared/widgets/loading.dart";

class Socialize extends StatefulWidget {
  const Socialize({super.key});

  @override
  State<Socialize> createState() => _SocializeState();
}

class _SocializeState extends State<Socialize> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String categoryFilter = 'All categories';

  @override
  Widget build(BuildContext context) {
    final _db = DatabaseService(user: _auth.currentUser);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 230, 229),
      appBar: AppBar(
        title: const Text('SoCialize'),
        backgroundColor: nusOrange,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Row(children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: DropdownButtonFormField(
                    value: "All categories",
                    decoration: textInputDecoration,
                    isExpanded: true,
                    items: categoryFilters
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) {
                      setState(() => categoryFilter = val as String);
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: nusBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
                onPressed: () async {
                  await Navigator.pushNamed(context, CreatePost.routeName);
                  setState(() {});
                },
                child: const Text(
                  'CREATE POST',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ]),
          Expanded(
            child: FutureBuilder(
              future: _db.getPosts(category: categoryFilter),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListTileTheme.merge(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: ((context, index) {
                            PostModel postData = snapshot.data![index];
                            DateTime formattedDate = DateTime.parse(
                                postData.dateTime.toDate().toString());
                            return PostCard(
                                name: postData.name,
                                course: postData.course,
                                dateTime: formattedDate,
                                title: postData.title,
                                category: postData.category,
                                bodyText: postData.bodyText,
                                likes: postData.likes);
                          })),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return Text("Something went wrong");
                  }
                } else {
                  return Loading();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
