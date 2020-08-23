import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tayeh/model/post.dart';
import 'package:tayeh/provider/posts.dart';
import 'package:tayeh/provider/users.dart';
import 'package:tayeh/widget/image_to_full_screen.dart';

class HomeListViewDesign extends StatelessWidget {
  final String state;

  const HomeListViewDesign({this.state});

  List<String> getMaxMinAge(String ageRange) {
    return ageRange.split('-');
  }

 showAlertDialog(
      BuildContext context, String imageurl, String postid) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Warning!!'),
            content: new Text('You are about to delete this post, Proceed?'),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: new Text('Cancel')),
              new FlatButton(
                  onPressed: () async {
                    await Provider.of<Posts>(context, listen: false)
                        .deleteFileFromStorage(imageurl)
                        .catchError((onError) {
//                        print('Error ' + onError.toString());
                    });
                    await Provider.of<Posts>(context, listen: false)
                        .deletePosts(postid, state);
                    Navigator.pop(context);
                  },
                  child: new Text('Proceed'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Post>(context);

    if (this.state.contains('lost')) {
      return
//        ((lostChildGender.toString().toLowerCase()
//          == post.gender.toLowerCase() ) || lostChildGender == null) &&
//              (lostChildAge.toString().replaceAll('.0', '') ==
//                      post.age.trim() ||
//                  lostChildAge == null)
//          ?

          Padding(
        padding: const EdgeInsets.only(
          top: 15,
          // right: 20,
          // left: 20
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      radius: 25,
                      backgroundImage: AssetImage("assets/images/avatar.jpg"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          post.ownerName,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Text(
                          post.time,
                          style:
                              TextStyle(color: Colors.grey[400], fontSize: 11),
                        ),
                      ],
                    )
                  ],
                ),
                Users.currentUser.data['admin'] && !post.isReported
                    ? Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              showAlertDialog(
                                  context, post.imageUrl, post.idPost);
                            },
                            child: Icon(Icons.delete),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      )
                    : SizedBox(),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context,ImageToFullScreen.routeName,arguments: [post.ownerName , post.imageUrl]);

                },
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(post.imageUrl))),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Divider(
                color: Colors.grey[300],
                height: 1,
                thickness: 1,
              ),
            ),
          ],
        ),
      );
//          : SizedBox();
    } else {
      return
//        ( foundChildGender == null || foundChildGender.toString().toLowerCase() == post.gender.toLowerCase()  ) &&
//              (foundChildAge == null || (
//                  foundChildAge.toDouble() >=
//                          double.parse(getMaxMinAge(post.age)[0]) &&
//                      foundChildAge.toDouble() <=
//                          double.parse(getMaxMinAge(post.age)[1])))?
          Padding(
        padding: const EdgeInsets.only(
          top: 15,
          // right: 20,
          // left: 20
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      radius: 25,
                      backgroundImage: AssetImage("assets/images/avatar.jpg"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          post.ownerName,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Text(
                          post.time,
                          style:
                              TextStyle(color: Colors.grey[400], fontSize: 11),
                        ),
                      ],
                    )
                  ],
                ),
                Users.currentUser.data['admin'] && !post.isReported
                    ? Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: ()  {
                              showAlertDialog(
                                  context, post.imageUrl, post.idPost);
                            },
                            child: Icon(Icons.delete),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      )
                    : SizedBox(),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context,ImageToFullScreen.routeName,arguments: [post.ownerName , post.imageUrl]);
                },
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(post.imageUrl))),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Divider(
                color: Colors.grey[300],
                height: 1,
                thickness: 1,
              ),
            ),
          ],
        ),
      );
//    :
//    SizedBox
//    (
//    );
    }
  }
}
