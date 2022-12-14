import 'package:flutter/material.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({super.key});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage('https://images.unsplash.com/photo-1670874677691-d639ad7be1c9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNXx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=60'),
          ),

          Expanded(
            child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                              text: 'username',
                              style: TextStyle(fontWeight: FontWeight.bold,
                              color: Colors.white),

                            ),
                          TextSpan(
                              text: '  some description to insert',
                              style: TextStyle(fontWeight: FontWeight.bold,
                              color: Colors.white),
                              ),
                        ]
                       ),
                      ),
          
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text('13/12/2022', 
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12
                        )), )
                    ],
                  ),
                ),
          ),

              Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.favorite,
                  size: 16),
              )
       
        ],
      ),
    );
  }
}