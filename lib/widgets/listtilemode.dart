import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/stngsVm.dart';

class ListTileMode extends StatelessWidget {
  final Widget? leading;
  final String? title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  const ListTileMode(
      {super.key,
      this.leading,
      this.title,
      this.subtitle,
      this.trailing,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: context.watch<StngsVmC>().isDarkMode
              ? Colors.blueGrey.shade700
              : Colors.blueGrey.shade50,
          boxShadow: [
            BoxShadow(
              color: context.watch<StngsVmC>().isDarkMode
                  ? Colors.black
                  : const Color.fromARGB(255, 114, 113, 113),
              offset: const Offset(0, 3),
              blurRadius: 5,
            ),
          ],
          borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        leading: leading,
        title: Text(
          title!,
          style: TextStyle(
              fontSize: context.watch<StngsVmC>().isLanIsEngMode ? 18 : 16,
              fontFamily: context.watch<StngsVmC>().isLanIsEngMode
                  ? 'CarosMedium'
                  : "NotoKufi",
              color: context.watch<StngsVmC>().isDarkMode
                  ? Colors.white
                  : Colors.black),
        ),
        subtitle: subtitle != null
            ? Text(subtitle!,
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: context.watch<StngsVmC>().isLanIsEngMode
                        ? 'CarosMedium'
                        : "NotoKufi",
                    color: context.watch<StngsVmC>().isDarkMode
                        ? Colors.blueGrey.shade200
                        : Colors.blueGrey.shade800))
            : null,
        trailing: trailing,
      ),
    );
  }
}

class ListTileModeBlue extends StatelessWidget {
  final Widget? leading;
  final String? title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  const ListTileModeBlue(
      {super.key,
      this.leading,
      this.title,
      this.subtitle,
      this.trailing,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: context.watch<StngsVmC>().isDarkMode
        //     ? Colors.blueGrey.shade700
        //     : Colors.blueGrey.shade50,
        boxShadow: [
          BoxShadow(
            color: context.watch<StngsVmC>().isDarkMode
                ? Colors.black
                : const Color.fromARGB(255, 114, 113, 113),
            offset: const Offset(0, 3),
            blurRadius: 5,
          ),
        ],
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(0, 104, 136, 1),
          Color.fromRGBO(14, 156, 199, 0.85),
          Color.fromRGBO(0, 102, 133, 1),
        ]),
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        leading: leading,
        title: Text(title!,
            style: TextStyle(
                fontSize: 18, fontFamily: 'CarosMedium', color: Colors.white)),
        subtitle: subtitle != null
            ? Text(subtitle!,
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: context.watch<StngsVmC>().isLanIsEngMode
                        ? 'CarosMedium'
                        : "NotoKufi",
                    color: Colors.blueGrey.shade100))
            : null,
        trailing: trailing,
      ),
    );
  }
}
