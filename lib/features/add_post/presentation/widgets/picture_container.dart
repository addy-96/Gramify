import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/features/add_post/presentation/bloc/cubit/selectedPicture_cubit.dart';
import 'package:gramify/core/common/shared_fun/shimmer_container.dart';

class PictureContainer extends StatelessWidget {
  const PictureContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 2.5;
    return BlocBuilder<SelectedpictureCubit, File?>(
      builder: (context, state) {
        if (state == null) {
          return ShimmerContainer(height: height, width: double.infinity);
        } else {
          return Image.file(
            state,
            height: MediaQuery.of(context).size.height / 2.7,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          );
        }
      },
    );
  }
}
