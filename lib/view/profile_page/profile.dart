import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/providers/user_name_state_provider.dart';
import 'package:task/services/firebase_authentication.dart';
import 'package:task/utils/colors.dart';
import 'package:task/utils/screen_size_utils.dart';
import 'package:task/view/components/expanded_elevated_btn.dart';
import 'package:task/view/profile_page/heading_with_disabled_textformfield.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final currentUserDetails = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.primary,
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade400,
                ),
                height: screenSizeUtils.screenHeight(context) * 0.3,
                width: screenSizeUtils.screenWidth(context) * 0.3,
              ),
            ),
            HeadingAndDisableTextFormField(
              heading: 'Name',
              hintText: ref.read(userNameStateProvider) ?? '',
            ),
            const SizedBox(
              height: 20,
            ),
            HeadingAndDisableTextFormField(
              heading: 'Email',
              hintText: currentUserDetails?.email ?? '',
            ),
            const SizedBox(
              height: 20,
            ),
            const Expanded(
              child: Text(''),
            ),
            ExpandedElevatedBtn(
              btnName: 'Logout',
              onTap: () async {
                await logoutUser(context, ref);
              },
            )
          ],
        ),
      ),
    );
  }
}
