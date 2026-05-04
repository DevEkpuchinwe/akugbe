import 'package:flutter/material.dart';

class KlikChatScreen extends StatefulWidget {
  final String groupName;
  final String groupImageUrl;
  final String description;
  final double minContribution;
  final String startDate;
  final String endDate;
  final List<Map<String, String>> members; // List of members

  const KlikChatScreen({super.key, 
    required this.groupName,
    required this.groupImageUrl,
    required this.description,
    required this.minContribution,
    required this.startDate,
    required this.endDate,
    required this.members,
  });

  @override
  _KlikChatScreenState createState() => _KlikChatScreenState();
}

class _KlikChatScreenState extends State<KlikChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {"sender": "Naayhomie", "message": "Hey everyone!", "isMe": false},
    {"sender": "You", "message": "Hello!", "isMe": true},
    {"sender": "John", "message": "What’s up?", "isMe": false},
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        "sender": "You",
        "message": _messageController.text.trim(),
        "isMe": true,
      });
    });
    _messageController.clear();
  }

  void _showGroupDetails() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 15),
              ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(widget.groupImageUrl)),
                title: Text(widget.groupName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text(widget.description),
              ),
              Divider(),
              Text("Minimum Contribution: ₦${widget.minContribution}", style: TextStyle(fontSize: 16)),
              SizedBox(height: 5),
              Text("Start Date: ${widget.startDate}", style: TextStyle(fontSize: 16)),
              Text("End Date: ${widget.endDate}", style: TextStyle(fontSize: 16)),
              Divider(),
              Text("Members", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.members.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final member = widget.members[index];
                    return ListTile(
                      leading: CircleAvatar(backgroundImage: NetworkImage(member["image"]!)),
                      title: Text(member["name"]!),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.groupImageUrl),
        ),
        title: Text(widget.groupName, style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: Icon(Icons.more_vert), onPressed: _showGroupDetails),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // Show latest messages at the bottom
              padding: EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - index - 1];
                final isMe = message["isMe"];

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: isMe ? Radius.circular(15) : Radius.zero,
                        bottomRight: isMe ? Radius.zero : Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isMe)
                          Text(message["sender"],
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        Text(message["message"], style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          IconButton(icon: Icon(Icons.emoji_emotions_outlined, color: Colors.grey), onPressed: () {}),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(icon: Icon(Icons.send, color: Colors.blue), onPressed: _sendMessage),
        ],
      ),
    );
  }
}
