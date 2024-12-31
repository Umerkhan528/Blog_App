import 'package:blog_clean_architecture/core/theme/app_pallete.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {

  List<String> selectedItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [Icon(Icons.done_rounded)],
      ),
      body: Column(
        children: [
          DottedBorder(
            color: AppPallete.borderColor,
            borderType: BorderType.RRect,
            radius: const Radius.circular(10),
            dashPattern: const [10, 4],
            strokeCap: StrokeCap.round,
            child: Container(
              height: 150,
              width: double.infinity,
              child: const Column(
                children: [
                  Icon(
                    Icons.folder_open,
                    size: 40,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Select your Image",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
           SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                'Technology',
                'Business',
                'Entertainment',
                'Programming',
              ].map((e)=>Chip(label:Text(e))).toList(),
            ),
          )
        ],
      ),
    );
  }
}
