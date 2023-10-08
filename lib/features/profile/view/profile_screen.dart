import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:users/features/favourites/view/screens/favourites_screen.dart';
import 'package:users/features/levels/view/screens/levels_screen.dart';
import 'package:users/features/users/view/screens/users_screen.dart';

import '../../../core/dependencies/dependency_init.dart';
import '../../../core/resources.dart';
import '../../../core/services/redirect_manager.dart';
import '../../../core/view/widgets/app_screen.dart';
import '../../../core/view/widgets/should_login.dart';
import '../../../core/view/widgets/text_fields/app_loading.dart';
import '../../authentication/login/logic/auth_handler.dart';
import '../../authentication/register/data/model/user.dart';
import '../../home/view/screens/home_screen.dart';
import '../logic/profile_cubit.dart';
import 'edit_profile_screen.dart';
import 'package:file_picker/file_picker.dart';

class ProfileScreen extends StatefulWidget {
  static const id = 'profile-screen';
  static const homeID = "${HomeScreen.id}/${LevelsScreen.id}/${UsersScreen.id}/$id";
  static const favouritesID = "${FavouritesScreen.id}/$id";

  const ProfileScreen({super.key, required this.user});
  final User user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileCubit = getIt<ProfileCubit>();
  final authHandler = getIt<AuthHandler>();
  late User user = widget.user;
  late final bool isMe = authHandler.loginModel?.user == user;
  dynamic? _avatarFile;
  PlatformFile? _imageFile;

  @override
  void initState() {
    super.initState();
    if (isMe) profileCubit.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: 'Profile',
      actions: [
        AdminWidget(
          adminWidget: editButton(),
          child: isMe ? editButton() : null,
        ),
      ],
      child: _body,
    );
  }

  Widget get _body {
    return BlocConsumer<ProfileCubit, ProfileState>(
      bloc: profileCubit,
      listener: (context, state) {
        // if (state.status == true) user = authHandler.loginModel!.user!;
      },
      builder: (context, state) {
        if (state.loading) {
          return const AppLoadingWidget();
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightBox(),
              avatar,
              20.heightBox(),
              AppText(user.fullname ?? '-', style: AppStyles.medium14),
              20.heightBox(),
              AppText('Contact information', style: AppStyles.bold18),
              AppText(user.email ?? '-', style: AppStyles.medium14),
              AppText(user.phone ?? '-', style: AppStyles.medium14),
              20.heightBox(),
              AppText('Skills', style: AppStyles.bold18),
              Wrap(
                children: user.jobs
                        ?.map((e) => Card(child: Padding(padding: symmetricPadding(2, 10), child: AppText(e.name ?? '-'))))
                        .toList() ??
                    [],
              ),
              20.heightBox(),
              Row(
                children: [
                  AppText('Level : ', style: AppStyles.bold18),
                  AppText(user.level?.name ?? ''),
                ],
              ),
              20.heightBox(),
            ],
          ),
        );
      },
    );
  }

  IconButton editButton() {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () async {
        final value = await RedirectManager(context).redirect(EditProfileScreen.profileID, extra: user);
        if (value is User) {
          setState(() {
            user = value;
          });
        }
      },
    );
  }

  Widget get avatar {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          height: SizeConfig.getH(150),
          width: SizeConfig.getH(150),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white, border: Border.all(color: Colors.grey, width: 1)),
          child: _avatarFile != null
              ? kIsWeb
                  ? Image.network(_avatarFile.path, fit: BoxFit.cover)
                  : Image.file(_avatarFile!, fit: BoxFit.cover)
              : user.avatar == null
                  ? Icon(Icons.person, color: Colors.grey, size: SizeConfig.getFontSize(60))
                  : ImageLoader(path: user.avatar ?? '', fit: BoxFit.cover),
        ),
        if (isMe)
          GestureDetector(
            onTap: () {
              ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50).then((XFile? image) {
                if (image != null) {
                  setState(() {
                    _avatarFile = kIsWeb ? image : File(image.path);
                  });
                  profileCubit.updateProfile(User(avatar: _avatarFile));
                }
              });
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(.7),
              child: const Icon(Icons.camera_alt, color: Colors.black),
            ),
          ),
      ],
    );
  }

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result == null) return;

      setState(() {
        _imageFile = result.files.first;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
