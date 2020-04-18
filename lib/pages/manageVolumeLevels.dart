import 'package:flutter/material.dart';
import 'package:ssh/ssh.dart';

class VolLevelPickerBox extends StatefulWidget {

  final String initialVolLevel;
  final SSHClient client;
  VolLevelPickerBox({this.initialVolLevel, this.client});

  @override
  _VolLevelPickerBoxState createState() => _VolLevelPickerBoxState();
}

class _VolLevelPickerBoxState extends State<VolLevelPickerBox> {

  double _volLevel;

  @override
  void initState() {
    _volLevel = double.parse(widget.initialVolLevel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Volume Level",
        style: TextStyle(
          fontFamily: "Product Sans"
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Slider(
              activeColor: Color(0xFF7E57C2),
              min: 0,
              max: 100,
              onChanged: (double value) {
                setState(() {
                  _volLevel = value;
                });
              },
              value: _volLevel
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          highlightColor: Color(0x117E57C2),
          splashColor: Color(0x117E57C2),
          onPressed: () async{
            await widget.client.execute(
              'osascript -e "set volume output volume $_volLevel"'
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
    );
  }
}

class VolumeMangementCard extends StatefulWidget {
  final SSHClient client;
  VolumeMangementCard({
    @required this.client
  });
  @override
  _VolumeMangementCardState createState() => _VolumeMangementCardState();
}

class _VolumeMangementCardState extends State<VolumeMangementCard> {
  var volLevel;

  void _showVolLevelAlertBox() async {
    final selectedFontSize = await showDialog<double>(
      context: context,
      builder: (context) => VolLevelPickerBox(initialVolLevel: volLevel, client: widget.client),
    );
    if (selectedFontSize != null) {
      setState(() {
        volLevel = selectedFontSize;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        var currLevel = await widget.client.execute("osascript -e 'output volume of (get volume settings)'");
        setState(() {
          volLevel = currLevel;
        });
        _showVolLevelAlertBox();
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
    );
  }
}