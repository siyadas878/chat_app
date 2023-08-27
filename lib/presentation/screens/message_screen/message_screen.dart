import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../application/message_provider/message_provider.dart';
import '../../../domain/message_model/message_model.dart';

class ChatScreen extends StatelessWidget {
  final String fromId;

  const ChatScreen({Key? key, required this.fromId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.02),
            Expanded(
              child: Consumer<MessageCreationProvider>(
                builder: (context, messageProvider, _) {
                  return FutureBuilder<List<MessageModel>>(
                    future: messageProvider.getAllMessages(fromId),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return const Center(child: Text('No data available'));
                      }

                      final messages = snapshot.data!;

                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: size.height * 0.02),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return Align(
                            alignment: messages[index].fromId == userId
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: messages[index].fromId == userId
                                    ? Colors.teal
                                    : Colors.teal[300],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                messages[index].message!,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: size.height * 0.06,
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: context
                            .read<MessageCreationProvider>()
                            .messageController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Write your message...',
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        context
                            .read<MessageCreationProvider>()
                            .addMessage(fromId);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Colors.teal,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
