import 'package:charum/utils/colors.dart';
import 'package:charum/utils/container.dart';
import 'package:charum/utils/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullContains extends StatefulWidget {
  const FullContains({super.key});

  @override
  State<FullContains> createState() => _FullContainsState();
}

class _FullContainsState extends State<FullContains> {
  bool follow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: white,
        actions: _trailingButton(context),
      ),
      body: Stack(
        children: [_contain(), _bottomOption()],
      ),
    );
  }

  _bottomOption() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: containerUtils(
        color: white,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            containerUtils(height: 1, color: black26),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _action(),
                  GestureDetector(
                      onTap: () {},
                      child: GestureDetector(
                        onTap: () {},
                        child: textUtils(
                          text: 'Follow thread',
                          color: greenCharum,
                          weight: FontWeight.bold,
                          size: 12,
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _contain() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            containerUtils(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              color: lightGrey,
              borderRadius: 15,
              child: textUtils(
                text: 'Politic',
                color: grey,
                size: 12,
                weight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            textUtils(
              text:
                  'Why is Indonesia the only member of G20 from Southeast Asia if some country is better (Malaysia or Singapore)?',
              weight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
            const SizedBox(
              height: 12,
            ),
            _heading(),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 200,
              child: Center(
                child: Image.asset(
                  'assets/logo/12313.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            textUtils(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Urna duis convallis convallis tellus id. Sed viverra ipsum nunc aliquet bibendum enim. Ornare arcu odio ut sem nulla pharetra diam sit. Semper viverra nam libero justo laoreet sit amet cursus sit. Malesuada fames ac turpis egestas sed tempus urna. At imperdiet dui accumsan sit amet nulla facilisi morbi. Orci a scelerisque purus semper eget duis at tellus. Ullamcorper sit amet risus nullam eget felis eget nunc. Aliquam nulla facilisi cras fermentum odio eu. Nisi scelerisque eu ultrices vitae auctor eu augue ut.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Urna duis convallis convallis tellus id. Sed viverra ipsum nunc aliquet bibendum enim. Ornare arcu odio ut sem nulla pharetra diam sit. Semper viverra nam libero justo laoreet sit amet cursus sit. Malesuada fames ac turpis egestas sed tempus urna. At imperdiet dui accumsan sit amet nulla facilisi morbi. Orci a scelerisque purus semper eget duis at tellus. Ullamcorper sit amet risus nullam eget felis eget nunc. Aliquam nulla facilisi cras fermentum odio eu. Nisi scelerisque eu ultrices vitae auctor eu augue ut.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Urna duis convallis convallis tellus id. Sed viverra ipsum nunc aliquet bibendum enim. Ornare arcu odio ut sem nulla pharetra diam sit. Semper viverra nam libero justo laoreet sit amet cursus sit. Malesuada fames ac turpis egestas sed tempus urna. At imperdiet dui accumsan sit amet nulla facilisi morbi. Orci a scelerisque purus semper eget duis at tellus. Ullamcorper sit amet risus nullam eget felis eget nunc. Aliquam nulla facilisi cras fermentum odio eu. Nisi scelerisque eu ultrices vitae auctor eu augue ut.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Urna duis convallis convallis tellus id. Sed viverra ipsum nunc aliquet bibendum enim. Ornare arcu odio ut sem nulla pharetra diam sit. Semper viverra nam libero justo laoreet sit amet cursus sit. Malesuada fames ac turpis egestas sed tempus urna. At imperdiet dui accumsan sit amet nulla facilisi morbi. Orci a scelerisque purus semper eget duis at tellus. Ullamcorper sit amet risus nullam eget felis eget nunc. Aliquam nulla facilisi cras fermentum odio eu. Nisi scelerisque eu ultrices vitae auctor eu augue ut.",
              letterSpacing: -0.5,
              weight: FontWeight.bold,
              size: 12,
              color: Colors.black45,
              align: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _trailingButton(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/notification',
          );
        },
        icon: const Icon(
          CupertinoIcons.bookmark,
        ),
      ),
      IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/searching',
          );
        },
        icon: const Icon(
          Icons.more_vert_rounded,
        ),
      ),
    ];
  }

  _heading() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          children: [
            CircleAvatar(
              child: Image.asset(
                'assets/logo/avatar.png',
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  children: [
                    textUtils(
                      text: 'Ade Winda',
                      weight: FontWeight.bold,
                      size: 12,
                    ),
                    CircleAvatar(
                      backgroundColor: grey,
                      radius: 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          follow = !follow;
                        });
                      },
                      child: textUtils(
                        text: follow ? 'Followed' : 'Follow',
                        color: follow ? grey : blue,
                        weight: FontWeight.bold,
                        size: 12,
                      ),
                    )
                  ],
                ),
                textUtils(text: '1h ago', size: 10, color: grey)
              ],
            )
          ],
        ),
      ],
    );
  }

  _action() {
    return SizedBox(
      width: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.hand_thumbsup,
                size: 20,
                color: grey,
              ),
              textUtils(
                text: ' 10,919',
                size: 13,
                color: grey,
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.comment_outlined,
                size: 20,
                color: grey,
              ),
              textUtils(
                text: ' 1,919',
                size: 13,
                color: grey,
              ),
            ],
          )
        ],
      ),
    );
  }
}
