import 'package:flutter/material.dart';
import 'package:ssh/ssh.dart';

class HomeScreen extends StatefulWidget {

  final SSHClient client;
  HomeScreen({this.client});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int volLevel = 0;
  TextEditingController volumeLevelController = TextEditingController();

  void showAlertBox(BuildContext context){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Volume Level",
          style: TextStyle(
            fontFamily: "Product Sans"
          ),
        ),
        content: TextField(
          autofocus: true,
          textCapitalization: TextCapitalization.none,
          controller: volumeLevelController,
          onChanged: (val){
            volLevel = int.parse(val);
          },
          textInputAction: TextInputAction.done,
          cursorColor: Color(0xFF7E57C2),
          style: TextStyle(
            color: Color(0xFF7E57C2)
          ),
          decoration: InputDecoration(
            enabledBorder: new UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF7E57C2),
                width: 1.0
              ),
            ),
            focusedBorder: new UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF7E57C2),
                width: 1.0),
            ),
            icon: Icon(
              Icons.volume_up,
              color: Color(0xFF7E57C2)
            ),
            labelText: "Please enter a value from 0 - 10",
            labelStyle: TextStyle(
              color: Color(0xFF7E57C2),
              fontFamily: "Product Sans"
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            highlightColor: Color(0x117E57C2),
            splashColor: Color(0x117E57C2),
            onPressed: (){
              widget.client.execute(
                'osascript -e "set Volume $volLevel"'
              );
              Navigator.pop(context);
            },
            child: Text(
              "Set Volume",
              style: TextStyle(
                fontFamily: "Product Sans",
                color: Color(0xFF7E57C2)
              ),
            )
          ),
          FlatButton(
            highlightColor: Color(0x117E57C2),
            splashColor: Color(0x117E57C2),
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                fontFamily: "Product Sans",
                color: Color(0xFF7E57C2)
              ),
            )
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 48,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: GestureDetector(
                  onTap: (){
                    widget.client.execute(
                      "caffeinate -u"
                    );
                  },
                  child: Card(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width - 48,
                          color: Colors.red,
                        ),
                        Positioned(
                          left: 8,
                          bottom: 10,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 20
                            ),
                            child: Text(
                              "Wake up screen",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 20,
                                color: Colors.white
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: GestureDetector(
                  onTap: () async{
                    widget.client.execute(
                      "./unlockscreen.sh"
                    );
                  },
                  child: Card(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width - 48,
                          color: Colors.pink,
                        ),
                        Positioned(
                          left: 8,
                          bottom: 10,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 20
                            ),
                            child: Text(
                              "Unlock screen",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 20,
                                color: Colors.white
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: GestureDetector(
                  onTap: () async{
                    widget.client.execute(
                      "./lockscreen.sh"
                    );
                  },
                  child: Card(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width - 48,
                          color: Colors.amber[900],
                        ),
                        Positioned(
                          left: 8,
                          bottom: 10,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 20
                            ),
                            child: Text(
                              "Lock screen",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 20,
                                color: Colors.white
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 32,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: GestureDetector(
                  onTap: () async{
                    showAlertBox(context);
                  },
                  child: Card(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width - 48,
                          color: Colors.indigoAccent,
                        ),
                        Positioned(
                          left: 8,
                          bottom: 10,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 20
                            ),
                            child: Text(
                              "Set volume percentage",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 20,
                                color: Colors.white
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 48,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await widget.client.disconnect();
          Navigator.pop(context);
        },
        child: Icon(Icons.power_settings_new),
      ),
    );
  }
}