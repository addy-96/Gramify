import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:gramify/auth/presentation/bloc/auth_bloc.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_attri/constrants.dart';
import 'package:gramify/core/common/shared_fun/shaders.dart';
import 'package:gramify/core/common/shared_fun/shimmer_container.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:gramify/profile/presentation/bloc/profile_bloc.dart';
import 'package:gramify/profile/presentation/bloc/profile_event.dart';
import 'package:gramify/profile/presentation/bloc/profile_state.dart';
import 'package:ionicons/ionicons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.userId});
  final String? userId;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    if (widget.userId == null) {
      context.read<ProfileBloc>().add(ProfileDataRequested(userId: null));
    } else {
      context.read<ProfileBloc>().add(
        ProfileDataRequested(userId: widget.userId),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileDataFetchSuccessState) {
                        return ShaderText(
                          textWidget: Text(
                            state.userdata.username,
                            style: txtStyleNoColor(22),
                          ),
                        );
                      }
                      if (state is ProfileLoadingState) {
                        return ShimmerContainer(height: 60, width: 60);
                      }
                      return ShaderText(
                        textWidget: Text(
                          'Username',
                          style: txtStyleNoColor(22),
                        ),
                      );
                    },
                  ),

                  IconButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(LogOutRequested());
                    },
                    icon: Icon(Ionicons.log_out),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(colors: [thmegrad1, thmegrad2]),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            if (state is ProfileDataFetchSuccessState) {
                              if (state.userdata.profileImageUrl == null) {
                                return ShaderIcon(
                                  iconWidget: Icon(Ionicons.person),
                                );
                              } else {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    state.userdata.profileImageUrl!,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }
                            }
                            if (state is ProfileLoadingState) {
                              return ShaderIcon(
                                iconWidget: Icon(Ionicons.person),
                              );
                            }
                            return ShaderIcon(
                              iconWidget: Icon(Ionicons.person),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Gap(5),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileDataFetchSuccessState) {
                        return Text(
                          state.userdata.fullname,
                          style: txtStyle(
                            15,
                            whiteForText,
                          ).copyWith(fontWeight: FontWeight.w100),
                        );
                      }
                      return Text(
                        'Full Name',
                        style: txtStyle(
                          18,
                          whiteForText,
                        ).copyWith(fontWeight: FontWeight.w100),
                      );
                    },
                  ),
                  Gap(10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 70,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlocBuilder<ProfileBloc, ProfileState>(
                                builder: (context, state) {
                                  if (state is ProfileDataFetchSuccessState) {
                                    return ShaderText(
                                      textWidget: Text(
                                        state.userdata.followingCount
                                            .toString(),
                                        style: txtStyle(
                                          18,
                                          whiteForText,
                                        ).copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }
                                  return ShimmerContainer(
                                    height: double.minPositive,
                                    width: 60,
                                  );
                                },
                              ),
                              ShaderText(
                                textWidget: Text(
                                  'Following',
                                  style: txtStyle(15, whiteForText),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlocBuilder<ProfileBloc, ProfileState>(
                                builder: (context, state) {
                                  if (state is ProfileDataFetchSuccessState) {
                                    return ShaderText(
                                      textWidget: Text(
                                        state.userdata.followersCount
                                            .toString(),
                                        style: txtStyle(
                                          18,
                                          whiteForText,
                                        ).copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }
                                  return ShimmerContainer(
                                    height: double.minPositive,
                                    width: 60,
                                  );
                                },
                              ),
                              ShaderText(
                                textWidget: Text(
                                  'Followers',
                                  style: txtStyle(15, whiteForText),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(4),
                    height: 50,
                    width: 50,
                    color: Colors.purple,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
