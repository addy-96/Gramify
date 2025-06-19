import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gramify/features/add_post/presentation/bloc/add_post_bloc.dart';
import 'package:gramify/features/add_post/presentation/bloc/cubit/selectedPicture_cubit.dart';
import 'package:gramify/core/common/shared_attri/colors.dart';
import 'package:gramify/core/common/shared_fun/csnack.dart';
import 'package:gramify/core/common/shared_fun/txtstyl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostCreatorPage extends StatefulWidget {
  const PostCreatorPage({super.key});

  @override
  State<PostCreatorPage> createState() => _PostCreatorPageState();
}

class _PostCreatorPageState extends State<PostCreatorPage> {
  final TextEditingController captionController = TextEditingController();

  File? selectedImage;

  @override
  void initState() {
    super.initState();
    selectedImage = context.read<SelectedpictureCubit>().state;
  }

  onShare() {
    if (selectedImage == null) {
      csnack(context, 'Image Not Selected');
      return;
    }

    context.read<AddPostBloc>().add(
      UploadPostRequested(
        postCaption: captionController.text,
        postImage: selectedImage!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post', style: txtStyle(22, whiteForText)),
      ),
      body: BlocConsumer<AddPostBloc, AddPostState>(
        listener: (context, state) async {
          if (state is PostUploadSuccessState) {
            Navigator.of(context).pop();
          }
          if (state is PostUploadFailureState) {
            csnack(context, state.errorMessage);
            final userId = Supabase.instance.client.auth.currentUser!.id;
            context.go('/wrapper/$userId');
          }
        },
        builder: (context, state) {
          if (state is AddPostPageLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(
                    selectedImage!,
                    height: MediaQuery.of(context).size.height / 3,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                const Gap(4),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: TextField(
                      maxLines: 3,
                      maxLength: 300,
                      controller: captionController,
                      style: txtStyle(15, Colors.white70),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add a caption...',
                        hintStyle: txtStyle(15, Colors.grey.withOpacity(0.8)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Material(
                        elevation: 10,
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 6.0,
                            bottom: 6,
                            left: 8,
                            right: 8,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.poll_outlined,
                                color: whiteForText,
                              ),
                              const Gap(2),
                              Text(
                                'Poll',
                                style: txtStyle(
                                  15,
                                  whiteForText,
                                ).copyWith(fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Ionicons.location_outline, size: 18),
                  title: Text(
                    'Add location',
                    style: txtStyle(15, whiteForText),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 15,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Ionicons.person_outline, size: 18),
                  title: Text('Tag People', style: txtStyle(15, whiteForText)),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 15,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(CupertinoIcons.eyeglasses, size: 18),
                  title: Text('Audience', style: txtStyle(15, whiteForText)),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 15,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height / 8,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1, color: Colors.grey.shade900),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 40,
              right: 40,
              top: 15,
              bottom: 15,
            ),
            child: InkWell(
              onTap: () {
                onShare();
              },
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [thmegrad1, thmegrad2],
                    begin: AlignmentDirectional.topStart,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text('Share', style: txtStyle(22, Colors.black54)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}







// get current filename and current path

/*    final trace = StackTrace.current.toString();
                final fileLine = trace.split('\n')[0];
                print('Current file: $fileLine'); */