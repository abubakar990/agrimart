import 'package:agrimart/pages/mainApp/chat/chat_page.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<Chat> chats = [
    Chat(contactName: 'Ali', lastMessage: 'Hi there!', timestamp: DateTime.now()),
    Chat(contactName: 'Hamza', lastMessage: 'Hello!', timestamp: DateTime.now()),
    Chat(contactName: 'Ali', lastMessage: 'Hi there!', timestamp: DateTime.now()),
    Chat(contactName: 'Hamza', lastMessage: 'Hello!', timestamp: DateTime.now()),
    Chat(contactName: 'Ali', lastMessage: 'Hi there!', timestamp: DateTime.now()),
    Chat(contactName: 'Hamza', lastMessage: 'Hello!', timestamp: DateTime.now()),
    Chat(contactName: 'Ali', lastMessage: 'Hi there!', timestamp: DateTime.now()),
    Chat(contactName: 'Hamza', lastMessage: 'Hello!', timestamp: DateTime.now()),
    Chat(contactName: 'Ali', lastMessage: 'Hi there!', timestamp: DateTime.now()),
    Chat(contactName: 'Hamza', lastMessage: 'Hello!', timestamp: DateTime.now()),
    Chat(contactName: 'Ali', lastMessage: 'Hi there!', timestamp: DateTime.now()),
    Chat(contactName: 'Hamza', lastMessage: 'Hello!', timestamp: DateTime.now()),
    Chat(contactName: 'Ali', lastMessage: 'Hi there!', timestamp: DateTime.now()),
    Chat(contactName: 'Hamza', lastMessage: 'Hello!', timestamp: DateTime.now()),
    // Add more chat data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat List'),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            leading: CircleAvatar(child: Icon(Icons.person,color: const Color.fromARGB(255, 3, 243, 127),),),
            title: Text(chat.contactName,style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text(chat.lastMessage),
            trailing: Text('${chat.timestamp.hour}:${chat.timestamp.minute}'),
            onTap: () {
              // Navigate to the chat screen for this conversation
             /* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(chat: chats),
                )
              );*/
            },
          );
        },
      ),
    );
  }
}

class Chat {
  final String contactName;
  final String lastMessage;
  final DateTime timestamp;

  Chat({required this.contactName, required this.lastMessage, required this.timestamp});
}
