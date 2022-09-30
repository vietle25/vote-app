import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_app/models/singer/singer_model.dart';
import 'package:flutter_app/styles/common_style.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/values/colors.dart';
import 'package:flutter_app/widgets/button_widget.dart';
import 'package:flutter_app/widgets/image_loader_widget.dart';

class ItemMember extends StatelessWidget {
  final SingerModel item;
  final int index;
  final Function? onPressItem;
  final int? dataLength;

  ItemMember({
    required this.item,
    this.index = 0,
    this.onPressItem,
    this.dataLength,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onPressItem!(item),
        child: Container(
          child: Stack(
            children: [
              ImageLoaderWidget(
                marginImage: EdgeInsets.zero,
                imageUrl: item.avatarPath ?? "",
                heightImage: (Utils.getWidth() / 2 - 18) * (16 / 9),
                widthImage: Utils.getWidth() / 2,
                shape: BoxShape.rectangle,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ButtonWidget(
                    onTap: () {},
                    color: Colors.transparent,
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Icon(Icons.heart_broken),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    width: Utils.getWidth() / 2,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xff6f6f6f),
                          const Color(0x1Af3f3f3),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ca sĩ",
                          style: CommonStyle.text(),
                        ),
                        Text(
                          item.name,
                          style: CommonStyle.textMediumBold(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
