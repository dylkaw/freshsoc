import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:freshsoc/services/database.dart";
import "package:freshsoc/shared/constants.dart";

class FlagButton extends StatefulWidget {
  final String postId;

  const FlagButton({
    super.key,
    required this.postId,
  });

  @override
  State<FlagButton> createState() => _FlagButtonState();
}

class _FlagButtonState extends State<FlagButton> {
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final db = DatabaseService(user: currentUser);

    void showFlagOptions() {
      String selectedOption = flagOptions[0];
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => AlertDialog(
                backgroundColor: Colors.white,
                elevation: 8,
                scrollable: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                title: const Text("Select reason for flagging"),
                content: StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                        children: flagOptions
                            .map((e) => Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Radio(
                                      groupValue: selectedOption,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedOption = value!;
                                        });
                                      },
                                      value: e,
                                    ),
                                    Text(e),
                                  ],
                                ))
                            .toList());
                  },
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () async {
                        await db.flagPost(widget.postId, selectedOption);
                        Navigator.pop(context);
                      },
                      child: const Text("Ok")),
                ],
              ));
    }

    return SizedBox(
        height: 13,
        child: TextButton(
            onPressed: showFlagOptions,
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
            ),
            child: Row(
              children: const [
                Text(
                  "Flag",
                  style: TextStyle(color: Color(0xFF8A8A8A)),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.flag_outlined,
                  size: 12.0,
                  color: Color(0xFF8A8A8A),
                )
              ],
            )));
  }
}
