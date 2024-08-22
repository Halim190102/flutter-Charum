import 'package:charum/utils/colors.dart';
import 'package:charum/utils/container.dart';
import 'package:charum/utils/snackbar.dart';
import 'package:charum/utils/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  bool follow = false;

  @override
  Widget build(BuildContext context) {
    return containerUtils(
      padding: const EdgeInsets.all(15),
      borderRadius: 8,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _heading(),
          const SizedBox(
            height: 12,
          ),
          _contain(),
          const SizedBox(
            height: 12,
          ),
          _action()
        ],
      ),
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

  _contain() {
    return Column(
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
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/full');
          },
          child: _onContainTap(),
        ),
      ],
    );
  }

  _onContainTap() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textUtils(
          text:
              'Why is Indonesia the only member of G20 from Southeast Asia if some country is better (Malaysia or Singapore)?',
          weight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        const SizedBox(
          height: 8,
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
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Urna duis convallis convallis tellus id. Sed viverra ipsum nunc aliquet bibendum enim. Ornare arcu odio ut sem nulla pharetra diam sit. Semper viverra nam libero justo laoreet sit amet cursus sit. Malesuada fames ac turpis egestas sed tempus urna. At imperdiet dui accumsan sit amet nulla facilisi morbi. Orci a scelerisque purus semper eget duis at tellus. Ullamcorper sit amet risus nullam eget felis eget nunc. Aliquam nulla facilisi cras fermentum odio eu. Nisi scelerisque eu ultrices vitae auctor eu augue ut.",
          letterSpacing: -0.5,
          weight: FontWeight.bold,
          size: 12,
          color: Colors.black45,
          textOverflow: TextOverflow.ellipsis,
          line: 3,
          align: TextAlign.justify,
        ),
      ],
    );
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
        GestureDetector(
          onTap: () {
            _more();
          },
          child: const Icon(
            Icons.more_vert,
          ),
        )
      ],
    );
  }

  _more() {
    return showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: white,
      context: context,
      builder: (BuildContext context) {
        return containerUtils(
          padding: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
          width: double.infinity,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.vertical,
            spacing: 15,
            children: [
              GestureDetector(
                child: Wrap(
                  spacing: 15,
                  alignment: WrapAlignment.start,
                  children: [
                    const Icon(
                      Icons.add_chart,
                    ),
                    textUtils(
                      text: 'Follow thread',
                    ),
                  ],
                ),
                onTap: () {},
              ),
              GestureDetector(
                child: Wrap(
                  spacing: 15,
                  alignment: WrapAlignment.start,
                  children: [
                    const Icon(
                      Icons.bookmark_remove_outlined,
                    ),
                    textUtils(
                      text: 'Remove bookmark',
                    ),
                  ],
                ),
                onTap: () {
                  showSnackBarFun(
                    context,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: white,
                          child: Icon(
                            Icons.done_rounded,
                            color: greenCharum,
                            size: 16,
                          ),
                        ),
                        textUtils(
                          text: '  Thread added to your Bookmarks',
                          size: 12,
                        )
                      ],
                    ),
                  );
                },
              ),
              GestureDetector(
                child: Wrap(
                  spacing: 15,
                  alignment: WrapAlignment.start,
                  children: [
                    const Icon(
                      Icons.near_me_outlined,
                    ),
                    textUtils(
                      text: 'Share',
                    ),
                  ],
                ),
                onTap: () {},
              ),
              GestureDetector(
                child: Wrap(
                  spacing: 15,
                  alignment: WrapAlignment.start,
                  children: [
                    const Icon(
                      CupertinoIcons.exclamationmark_triangle,
                    ),
                    textUtils(
                      text: 'Report thread',
                    ),
                  ],
                ),
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
