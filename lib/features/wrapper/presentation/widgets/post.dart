import 'package:flutter/material.dart';
import 'package:gramify/core/theme/text_styles.dart';
import 'package:gramify/core/utils.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: SizedBox(
        width: double.infinity,
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(radius: 20, backgroundColor: Colors.grey.shade400),
                title: Text('Username', style: AppTextStyles.bodyMedium()),
                subtitle: Text(
                  'Posted on 7 Nov',
                  style: AppTextStyles.bodySmall().copyWith(color: Colors.grey.shade400, fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: SizedBox(
                  height: Utils.getScreenHeight(context) / 2.5,
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    children: [
                      ClipRRect(borderRadius: BorderRadiusGeometry.circular(20), child: Image.asset('assets/samples/sample1.jpg', fit: BoxFit.cover)),
                      ClipRRect(borderRadius: BorderRadiusGeometry.circular(20), child: Image.asset('assets/samples/sample2.jpg', fit: BoxFit.cover)),
                      ClipRRect(borderRadius: BorderRadiusGeometry.circular(20), child: Image.asset('assets/samples/sample3.jpg', fit: BoxFit.cover)),
                      ClipRRect(borderRadius: BorderRadiusGeometry.circular(20), child: Image.asset('assets/samples/sample4.jpg', fit: BoxFit.cover)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
