import 'package:flutter/material.dart';
import 'package:ulasbuku_mobile/screens/menu.dart';
import 'package:ulasbuku_mobile/send_messages/pages/user_messages_page.dart';
import 'package:ulasbuku_mobile/send_messages/util/fetch.dart';

import '../../screens/login.dart';
import '../../widgets/left_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool search = false;
  int userId = 0;
  List<UserInfo> userInfoList = [];

  Future<List<UserInfo>> fetchUserData() async {
    Map<String, dynamic> data = await fetchUserInfo(LoggedIn.user_data['username']!);
    userInfoList.clear();
    data.forEach((key, value) {
      UserInfo userInfo = UserInfo.fromJson(value);
      userInfoList.add(userInfo);
    });
    userId = userInfoList.first.userId;
    return userInfoList;
  }

  Widget ChatRoomList() {
    return FutureBuilder<List<UserInfo>>(
      future: fetchUserData(),
      builder: (context, AsyncSnapshot<List<UserInfo>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('Belum ada pengguna'),
          );
        } else {
          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 90.0, top: 130),
              itemCount: userInfoList.length,
              reverse: true,
              itemBuilder: (context, index) {
                String lastMessage = userInfoList[index]!.text;
                return ChatRoomListTile(
                  userId: userId,
                  lastMessage: lastMessage,
                  selectedUserId: userInfoList[index]!.selectedUserId,
                  selectedUsername: userInfoList[index]!.selectedUser,
                );
              },
            ),
          );
        }
      },
    );
  }

  List<UserInfo> queryResultSet = [];
  List<UserInfo> tempSearchStore = [];

  initiateSearch(value) {
    if (userInfoList.length == 0){
      setState(() {});
    }
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    setState(() {
      search = true;
    });
      tempSearchStore = [];
      userInfoList.forEach((element) {
        String val = element.selectedUser.substring(0, 1).toUpperCase() + element.selectedUser.substring(1);
        if (value.length > 1){
          if (val.startsWith(value.substring(0, 1).toUpperCase() + value.substring(1)) ||
              val == (value.substring(0, 1).toUpperCase() + value.substring(1))){
            setState(() {
              tempSearchStore.add(element);
            });
          }
        }else if (value.length == 1){
          if (val.startsWith(value.substring(0, 1).toUpperCase())){
            setState(() {
              tempSearchStore.add(element);
            });
          }
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF553370),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 50.0, bottom: 20.0),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                search
                    ?
                  Expanded(child:TextField(
                    onChanged: (value) {
                      initiateSearch(value);
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search User',
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500)),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                    )
                  )
                    : Row(children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MyHomePage()));
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Color(0Xffc199cd),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                      Text(
                  "Messages",
                  style: TextStyle(
                      color: Color(0Xffc199cd),
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                ),

                ]
                ),

                GestureDetector(
                  onTap: () {
                    search = true;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Color(0xFF3a2144),
                        borderRadius: BorderRadius.circular(20)),
                    child: search
                        ? GestureDetector(
                      onTap: () {
                        search = false;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.close,
                        color: Color(0Xffc199cd),
                      ),
                    )
                        : Icon(
                      Icons.search,
                      color: Color(0Xffc199cd),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(child:
          Container(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            width: MediaQuery.of(context).size.width,
            height: search
                ? MediaQuery.of(context).size.height / 1.19
                : MediaQuery.of(context).size.height / 1.15,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: [
                search
                    ? Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    primary: false,
                    shrinkWrap: true,
                    children: tempSearchStore.map((element) {
                      return buildResultCard(element);
                    }).toList(),
                  ),
                )
                    : ChatRoomList(),
              ],
            ),
          ),
          )
        ],
      ),
    );
  }


  Widget buildResultCard(UserInfo data) {
    return GestureDetector(
      onTap: () async {
        search = false;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                    usernameId: userId,
                    selectedUserId: data.selectedUserId,
                    selectedUsername: data.selectedUser)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Icon(
                    Icons.account_circle,
                    size: 60.0,
                    color: Colors.grey,
                  )
                ),
                SizedBox(
                  width: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.selectedUser,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      data.text,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class UserInfo {
  final int userId;
  final String selectedUser;
  final int selectedUserId;
  final String text;

  UserInfo({
    required this.userId,
    required this.selectedUser,
    required this.selectedUserId,
    required this.text,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userId: json['fields']['user id'],
      selectedUser: json['fields']['selected user'],
      selectedUserId: json['fields']['selected user id'],
      text: json['fields']['text'],
    );
  }
}
class ChatRoomListTile extends StatefulWidget {
  final String selectedUsername;
  final String lastMessage;
  final int selectedUserId;
  final int userId;

  ChatRoomListTile({
    required this.userId,
    required this.lastMessage,
    required this.selectedUserId,
    required this.selectedUsername,
  });

  @override
  State<ChatRoomListTile> createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              usernameId: widget.userId,
              selectedUserId: widget.selectedUserId,
              selectedUsername: widget.selectedUsername,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Icon(
                Icons.account_circle,
                size: 60.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  widget.selectedUsername,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    widget.lastMessage,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
