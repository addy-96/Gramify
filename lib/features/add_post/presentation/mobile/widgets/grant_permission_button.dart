import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/features/add_post/presentation/bloc/add_post_bloc.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';

Widget grantPermissionButton(BuildContext context) => Center(
  child: InkWell(
    enableFeedback: true,
    borderRadius: BorderRadius.circular(50),
    splashColor: thmegrad1,
    onTap: () {
      context.read<AddPostBloc>().add(CheckAssetPermisiion());
    },
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(colors: [thmegrad1, thmegrad2]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),

              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ShaderText(
                textWidget: Text(
                  'Grant Permission',
                  style: txtStyleNoColor(22),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  ),
);
