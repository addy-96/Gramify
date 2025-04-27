import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:ionicons/ionicons.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: ShaderIcon(
          iconWidget: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: ShaderText(textWidget: Text('Select a picture')),
        actionsPadding: EdgeInsets.all(8),
        actions: [
          ShaderIcon(iconWidget: Icon(Icons.arrow_forward_ios_outlined)),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.7,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(
                'assets/images/test_picture.jpg',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 18,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton(
                    //render flow error here
                    items: [DropdownMenuItem(child: Text('Item 1'))],
                    onChanged: (value) {},
                  ),
                  Row(children: [Icon(Ionicons.crop)]),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.amber,
              child: GridView.builder(
                itemCount: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) {
                  if (index % 2 == 0) {
                    return Container(color: Colors.red);
                  }
                  if (index % 3 == 0) {
                    return Container(color: Colors.green);
                  }
                  return Container(color: Colors.blue);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
