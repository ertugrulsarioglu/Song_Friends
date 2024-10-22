import 'package:Mevo/home/profile/profilePage/viewmodel/profile_cubit.dart';
import 'package:Mevo/home/profile/profileUpdatePage/model/profile_update_req_model.dart';
import 'package:Mevo/home/profile/profileUpdatePage/service/profile_update_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../constants/padding_constants.dart';
import '../../profilePage/model/user_model.dart';
import '../viewmodel/profil_update_view_model.dart';

class ProfileUpdateView extends ProfileUpdateViewModel with PaddingConstants {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bilgilerimi Düzenle'),
      ),
      body: Padding(
        padding: buildDefaultSymetricPadding(context),
        child: SingleChildScrollView(
          child: Wrap(
            runSpacing: spacingMid(context),
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              buildCircleAvatarAndTextButton(context),
              buildUsernameTextField,
              buildEmailTextField,
              buildAgeTextField,
              buildCustomUpdateButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Column buildCircleAvatarAndTextButton(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: circleAvatarRadiusHigh(context),
            backgroundImage: NetworkImage(
                context.read<UserModel>().profilePhotoUrl.toString()),
          ),
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              'Profil Fotoğrafını Değiştir',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: spacingMid(context)),
            )),
      ],
    );
  }

  Wrap get buildUsernameTextField => Wrap(
        children: [
          const Text('Ad Soyad'),
          TextField(
            controller: userNameController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), suffixIcon: Icon(Icons.edit)),
          ),
        ],
      );

  Wrap get buildEmailTextField => Wrap(
        children: [
          const Text('E-Mail'),
          TextField(
            readOnly: true,
            controller: emailController,

            //duzenle
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: () {
                      print('object');
                    },
                    icon: const Icon(Icons.verified))),
          ),
        ],
      );

  Wrap get buildAgeTextField => Wrap(
        children: [
          const Text('Yaş'),
          TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            controller: ageController,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ], //duzenle
            decoration: const InputDecoration(
                border: OutlineInputBorder(), suffixIcon: Icon(Icons.edit)),
          ),
        ],
      );

  Padding buildCustomUpdateButton(BuildContext context) {
    return Padding(
      padding: buildDefaultSymetricVerticalPadding(context),
      child: ListTile(
        onTap: () async {
          bool result = await ProfileUpdateService().patchUser(
              ProfileUpdateReqModel(
                  username: userNameController.text,
                  age: int.tryParse(ageController.text)),
              userId);

          if (result) {
            context.read<ProfileCubit>().updateUser(userNameController.text);
            updateUserNameAndAgeTextField(context);

            Navigator.of(context).pop();
          }
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
                Icons.cloud_sync_outlined,
                color: Colors.red,
              ),
              SizedBox(width: 8), // İkisi arasına biraz boşluk ekleyelim
              Text(
                'Bilgilerimi Güncelle',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateUserNameAndAgeTextField(BuildContext context) {
    context.read<UserModel>().username = userNameController.text;
    context.read<UserModel>().age = int.tryParse(ageController.text);
  }
}
