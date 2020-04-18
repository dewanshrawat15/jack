import 'package:flutter/material.dart';
import 'package:ssh/ssh.dart';
import 'manageVolumeLevels.dart';
import 'terminalCard.dart';

class HomeScreen extends StatefulWidget {

  final SSHClient client;
  HomeScreen({this.client});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController volumeLevelController = TextEditingController();
  var volLevel;


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
                    await widget.client.execute(
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
                    await widget.client.execute(
                      "pmset displaysleepnow"
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
                child: VolumeMangementCard(
                  client: widget.client
                )
              ),
              SizedBox(
                height: 32,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: TerminalCommandsCard(
                  client: widget.client
                )
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