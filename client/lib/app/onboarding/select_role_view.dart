import 'package:flutter/material.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';

class SelectRoleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'Select your role',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 20,
                            color: CustomColors.appColorOrange,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                RoleSelectChip(
                  roleText: 'Become a mentee',
                  onRoleSelect: (selectedRole) => print(selectedRole),
                ),
                SizedBox(
                  height: 20,
                ),
                RoleSelectChip(
                  roleText: 'Become a mentor',
                  onRoleSelect: (selectedRole) => print(selectedRole),
                ),
                SizedBox(
                  height: 20,
                ),
                RoleSelectChip(
                  roleText: 'Why not both?',
                  onRoleSelect: (selectedRole) => print(selectedRole),
                ),
                SizedBox(
                  height: 40,
                ),
                CustomElevatedButton(
                    child: Text(
                      'FINISH',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                    ),
                    onPressed: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoleSelectChip extends StatelessWidget {
  const RoleSelectChip({
    Key? key,
    required this.roleText,
    required this.onRoleSelect,
  }) : super(key: key);

  final String roleText;
  final Function(String) onRoleSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onRoleSelect(roleText),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            border: Border.all(
              color: CustomColors.appColorTeal,
            ),
            borderRadius: BorderRadius.circular(50.0)),
        child: Text(
          roleText,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16,
                color: CustomColors.appColorTeal,
              ),
        ),
      ),
    );
  }
}
