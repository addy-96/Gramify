import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gramify/core/theme/spacing.dart';
import 'package:gramify/core/theme/text_styles.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.bodyLarge, horizontal: AppSpacing.bodymedium),
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
                trailing: IconButton(onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.barsStaggered)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: SizedBox(
                  child: GridView.count(
                    crossAxisCount: 2,
                    physics: const NeverScrollableScrollPhysics(),
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
