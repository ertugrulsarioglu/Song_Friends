import 'package:Mevo/constants/string_constants.dart';
import 'package:Mevo/home/profile/profilePage/viewmodel/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants/padding_constants.dart';
import '../viewmodel/profile_view_model.dart';
import '../../../../core/auth_manager.dart';
import '../../../../splash/view/splash_view.dart';
import 'package:flutter/material.dart';

class ProfileView extends ProfileViewModel
    with StringConstants, PaddingConstants {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Padding(
          padding: buildDefaultSymetricPadding(context),
          child: SingleChildScrollView(
            child: Wrap(
              runSpacing: spacingHigh(context),
              children: [
                buildListTile,
                buildContainer,
                buildRatingListTile,
                buildLogoutListTile
              ],
            ),
          ),
        ));
  }

  AppBar buildAppBar(BuildContext context) => AppBar(
        centerTitle: true,
        title: Text(profileViewAppBarTitleText),
      );

  ListTile get buildListTile => ListTile(
        trailing: const Icon(Icons.monetization_on_outlined),
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        title: BlocBuilder<ProfileCubit, ProfileState>(
          //TODO: haburaya bak
          builder: (context, state) {
            return Text(
              context.read<ProfileCubit>().state.userName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            );
          },
        ),
        subtitle: Text('${userModel?.email.toString()}'),
        leading: CircleAvatar(
          radius: profileViewAvatarSize,
          backgroundImage: NetworkImage(userModel?.profilePhotoUrl ?? ''),
        ),
      );

  Container get buildContainer => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Wrap(
          children: [
            // TODO: profile information ListTile
            ListTile(
              onTap: () async {
                navigateToProfileUpdate;
              },
              leading: const Icon(Icons.person_search_outlined),
              title: Text(profileViewAppBarTitleText),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03),
            ),
            // TODO: MySong ListTile
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.my_library_music_outlined),
              title: Text(mySongListTileTitleText),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03),
            ),
            // TODO: Song request ListTile
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.queue_music_outlined),
              title: Text(songReqListTileTitleText),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03),
            ),
            // TODO: post ListTile
            ListTile(
              onTap: () {
                navigateToMyPosts;
              },
              leading: const Icon(Icons.bookmark_border_outlined),
              title: Text(myPostsListTileTitleText),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03),
            ),
            // TODO: Notification ListTile
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.notifications_active_outlined),
              title: Text(notificationsListTileTitleText),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03),
            ),
          ],
        ),
      );

  ListTile get buildRatingListTile => ListTile(
        onTap: () {},
        leading: const Icon(Icons.star_outlined),
        title: Text(ratingListTileTitleText),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03),
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(10)),
      );

  ListTile get buildLogoutListTile => ListTile(
        onTap: () {
          context
              .read<AuthenticationManager>()
              .removeAllData()
              .then((value) => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const SplashView(),
                  ),
                  (route) => false));

          navigateToLogin();
        },
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout,
                color: Colors.red,
              ),
              SizedBox(width: 8), // İkisi arasına biraz boşluk ekleyelim
              Text(
                'Çıkış Yap',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );
}
