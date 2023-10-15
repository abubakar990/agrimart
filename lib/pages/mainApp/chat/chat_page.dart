import 'package:agrimart/const/colors.dart';
import 'package:agrimart/models/crop_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
final Crop crop;
  ChatScreen({required this.crop});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      isBuyer:false, // Change to false for farmer's messages
      status: MessageStatus.read, timestamp: DateTime.now(), // Initially set as sent
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.crop.farmerId}'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: appMainColor), // Change the icon color
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.photo),
                    onPressed: () {
                      // Implement image sending logic
                      // You can use packages like image_picker for this
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.insert_drive_file),
                    onPressed: () {
                      // Implement document sending logic
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.keyboard_voice),
                    onPressed: () {
                      // Implement voice message sending logic
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () => _handleSubmitted(_textController.text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum MessageStatus {
  sent,
  delivered,
  read,
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isBuyer;
  final MessageStatus? status;
  final DateTime timestamp; // Add timestamp property

  ChatMessage({
    required this.text,
    required this.isBuyer,
    this.status,
    required this.timestamp, // Pass the timestamp when creating a message
  });

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat.Hm().format(timestamp); // Format time as "HH:mm"

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment:
              isBuyer ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: isBuyer
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: <Widget>[
                if (!isBuyer)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      // Replace with farmer's profile image
                      // backgroundImage: AssetImage('assets/farmer_profile.jpg'),
                    ),
                  ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color:
                        isBuyer ? Color.fromARGB(255, 178, 232, 180) : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        text,
                        style: TextStyle(
                          color: isBuyer ? Colors.black : Colors.black,
                          fontSize: 16,fontWeight: FontWeight.w600
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            formattedTime, // Display timestamp here
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                          SizedBox(width: 4.0),
                          if (status == MessageStatus.sent && isBuyer == true)
                            Icon(
                              Icons.done,
                              size: 16.0,
                              color: Colors.blue,
                            ),
                          if (status == MessageStatus.delivered && isBuyer == true)
                            Icon(
                              Icons.done_all,
                              size: 16.0,
                              color: Colors.grey,
                            ),
                          if (status == MessageStatus.read && isBuyer == true)
                            Icon(
                              Icons.done_all,
                              size: 16.0,
                              color: Colors.blue,
                            ),
                        ],
                      ),
                    ],
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
