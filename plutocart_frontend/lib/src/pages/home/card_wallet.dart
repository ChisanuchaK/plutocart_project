import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/popups/edit_wallet_popup.dart';

class CardWallet extends StatefulWidget {
  const CardWallet({Key? key}) : super(key: key);

  @override
  _CardWalletState createState() => _CardWalletState();
}

class _CardWalletState extends State<CardWallet> {
  bool isClicked = false; // Track button click

  @override
  void initState() {
    context.read<WalletBloc>().add(GetWalletById(1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 1,
        decoration: ShapeDecoration(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              strokeAlign: BorderSide.strokeAlignInside,
              color: Color(0xFF1A9CB0),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Container(
          child: Column(children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: BlocBuilder<WalletBloc, WalletState>(
                        builder: (context, state) {
                          return Text(
                            state.walletName.length > 10
                                ? "${state.walletName.substring(0, 11)}..."
                                : state.walletName,
                            style: TextStyle(
                                color: Color(0xFF15616D),
                                fontSize: 14,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500),
                          );
                        },
                      )),
                  Material(
                    shape: CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    child: Ink(
                      child: IconButton(
                        onPressed: EditWallet,
                        icon: SizedBox(
                          width: 20,
                          height: 20,
                          child: ImageIcon(
                            AssetImage('assets/icon/edit_icon.png'),
                          ),
                        ),
                        color: Color(0XFF15616D), // ตั้งค่าสีไอคอน
                        iconSize: 20, // ตั้งค่าขนาดไอคอน
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<WalletBloc, WalletState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 32),
                          state.walletName.isEmpty
                              ? CircularProgressIndicator(
                                  color: Color(0xFF15616D),
                                )
                              : Text(
                                  "${state.walletBalance}",
                                  style: TextStyle(
                                      color: Color(0xFF15616D),
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Roboto"),
                                ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Text(
                                "฿",
                                style: TextStyle(
                                    color: Color(0xFF15616D),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Roboto"),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Daily expense",
                            style: TextStyle(
                                color: Color(0xFF15616D),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto'),
                          ),
                          Text("-0 ฿",
                              style: TextStyle(
                                  color: Color(0xFFDD0000),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto')),
                        ],
                      ),
                      Container(
                        height: 0,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: Color(0xFF15616D),
                              width: 3.0,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "Daily income",
                            style: TextStyle(
                                color: Color(0xFF15616D),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto'),
                          ),
                          Text("0 ฿",
                              style: TextStyle(
                                  color: Color(0xFF2DC653),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Roboto')),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    ));
  }

  EditWallet() {
    showSlideDialog(
      context: context,
      child: EditWalletPopup(),
      barrierColor: Colors.white.withOpacity(0.7),
      pillColor: Colors.grey,
      backgroundColor: Colors.white,
    );
  }
}