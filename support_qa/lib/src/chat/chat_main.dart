import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Q&A',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  String threadId = ''; // Store the thread_id here
  String apiURL = 'http://127.0.0.1:8080/';

  void _startConversation() async {
    final String startUrl =
        apiURL + 'start'; // Replace with your server's actual address
    final http.Response response = await http.get(Uri.parse(startUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        threadId = data['thread_id'];
      });
    } else {
      // Handle error, maybe set a flag to indicate the conversation couldn't be started
      print('Failed to start conversation: ${response.statusCode}');
    }
  }

  void _sendMessage(String text) {
    if (threadId.isEmpty) {
      // Ensure threadId is obtained before sending a message
      print('Thread ID is not set, cannot send message.');
      return;
    }
    setState(() {
      messages.insert(0, {"text": text, "isUser": true});
    });
    _controller.clear();
    _callAssistant(text, threadId); // Pass the thread_id
  }

  void _callAssistant(String text, String threadId) async {
    final String url = apiURL + 'chat';
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'thread_id': threadId, // Include the thread_id in the request
        'message': text,
      }),
    );

    if (response.statusCode == 200) {
      final String responseBody = json.decode(response.body)['response'];
      setState(() {
        messages.insert(0, {"text": responseBody, "isUser": false});
      });
    } else {
      // Handle errors here
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    _startConversation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Q&A'),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Align(
                    alignment: message["isUser"]
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color:
                            message["isUser"] ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        message["text"],
                        style: TextStyle(
                          color:
                              message["isUser"] ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Send a message'),
                    onSubmitted: _sendMessage,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
