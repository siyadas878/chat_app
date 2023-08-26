import 'dart:developer';
import 'package:chat_app/application/profile_data_provider/update_provider.dart';
import 'package:flutter/material.dart';
import '../../domain/user_model/user_model.dart';
import '../../presentation/widgets/warnig_snackbar.dart';

class UpdateProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  UpdateUser update = UpdateUser();

  Future<void> updatedetails(BuildContext context, String imagePath,
      String nameController, String usernameController) async {
    try {
      _isLoading = true;
      notifyListeners();
      // ImageProviderClass imageclear = ImageProviderClass();
      final String name = nameController;
      final String username = usernameController;

      if (name.isEmpty || username.isEmpty) {
        warning(context, 'Please fill in all the fields.');
        return;
      }

      update.updateUserDetails(UserModel(name: name, imgpath: imagePath));

      // ignore: use_build_context_synchronously
      warning(context, 'Successfully updated');
      // imageclear.clearImage();
      notifyListeners();

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      warning(context, 'Error creating user: $error');
      log('Error creating user: $error');
    }
  }
}
