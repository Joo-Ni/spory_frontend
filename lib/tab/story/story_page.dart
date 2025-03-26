import 'package:flutter/material.dart';

import '../../create/create_page.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePage()),
          );
        },
        backgroundColor: Color.fromARGB(255, 43, 180, 153),
        child: Icon(Icons.create),
      ),
      appBar: AppBar(
        title: const Text('Spory'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        // child: StreamBuilder<QuerySnapshot<Post>>(
        //   stream: model.postsStream,
        //   builder: (context, snapshot) {
        //     if(snapshot.hasError) {
        //       return const Text('알 수 없는 에러');
        //     }

        //     if(snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(child: CircularProgressIndicator());
        //     }

        //     List<Post> posts = snapshot.data!.docs.map((e) => e.data()).toList();

        //     return GridView.builder(
        //       itemCount: posts.length,
        //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 3,
        //         mainAxisSpacing: 2.0,
        //         crossAxisSpacing: 2.0,
        //       ),
        //       itemBuilder: (BuildContext context, int index) {
        //         final post = posts[index];
        //         return GestureDetector(
        //           onTap: () {
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(builder: (context) => DetailPostPage(post: post)),
        //             );
        //           },
        //           child: Hero(
        //             tag: post.id,
        //             child: Image.network(
        //               post.imageUrl,
        //               fit: BoxFit.cover,
        //             ),
        //           ),
        //         );
        //       },
        //     );
        //   }
        // ),
      ),
    );
  }
}
