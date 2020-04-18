import 'package:flutter/material.dart';
import 'package:ssh/ssh.dart';
import '../utils/details.dart';

class ResultMessage extends StatelessWidget {
  ResultMessage({this.text, this.name, this.animationController, this.icon});
  final String text, name;
  final Widget icon;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOutCubic
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                child: icon,
                backgroundColor: Theme.of(context).accentColor
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(text),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TerminalScreen extends StatefulWidget {
  final SSHClient client;
  TerminalScreen({this.client});
  @override
  _TerminalScreenState createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> with TickerProviderStateMixin{

  final List<ResultMessage> _messages = <ResultMessage>[];
  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) async{
    _textController.clear();
    ResultMessage message = new ResultMessage(
      text: text,
      icon: Icon(
        Icons.person,
        color: Colors.white
      ),
      name: username + "@" + host,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 500),
        vsync: this
      )
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
    var result = await widget.client.execute(text);
    ResultMessage resultFromMac = new ResultMessage(
      text: result,
      icon: Icon(
        Icons.laptop_mac,
        color: Colors.white,
      ),
      name: "Dewansh's Macbook Air",
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 500),
        vsync: this
      )
    );
    setState(() {
      _messages.insert(0, resultFromMac);
    });
    resultFromMac.animationController.forward();
  }

  @override
  void dispose(){
    for(ResultMessage message in _messages){
      message.animationController.dispose();
    }
    super.dispose();
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintText: "Send a message"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Terminal"
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}

class TerminalCommandsCard extends StatefulWidget {

  final SSHClient client;
  TerminalCommandsCard({this.client});

  @override
  _TerminalCommandsCardState createState() => _TerminalCommandsCardState();
}

class _TerminalCommandsCardState extends State<TerminalCommandsCard> {

  String shellCommand;
  TextEditingController commandController = TextEditingController();
  FocusNode commandFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => TerminalScreen(
              client: widget.client,
            )
          )
        );
      },
      child: Card(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width - 48,
              color: Colors.black,
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
                  "Run Shell",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 20,
                    color: Colors.greenAccent
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