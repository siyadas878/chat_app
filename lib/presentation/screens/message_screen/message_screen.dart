import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../application/message_provider/message_provider.dart';

class ChatScreen extends StatelessWidget {
  final String fromId;
  const ChatScreen({Key? key,required this.fromId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.02),
            Expanded(
              child: ListView.separated(
                padding:const EdgeInsets.symmetric(horizontal: 10),
                separatorBuilder: (context, index) =>
                    SizedBox(height: size.height * 0.02),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: index % 2 == 0
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      padding:const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: index % 2 == 0 ? Colors.teal : Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'This is a sample message $index',
                        style:const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: size.height*0.06,
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: context.read<MessageCreationProvider>().messageController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          prefixIcon: const Icon(FontAwesomeIcons.penToSquare),
                          hintText: 'Write your message...',
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                          ),
                          border:const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Provider.of<MessageCreationProvider>(context,listen: false).addMessage(fromId);
                      },
                      child: Container(
                        padding:const EdgeInsets.all(12),
                        decoration:const BoxDecoration(
                          color: Colors.teal,
                          shape: BoxShape.circle,
                        ),
                        child:const Icon(
                          FontAwesomeIcons.paperPlane,
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

