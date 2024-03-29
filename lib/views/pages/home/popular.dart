import 'package:charum/utils/colors.dart';
import 'package:charum/utils/container.dart';
import 'package:charum/utils/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final popularBucket = StateProvider((ref) => PageStorageBucket());

class Popular extends ConsumerStatefulWidget {
  const Popular({super.key});

  @override
  ConsumerState<Popular> createState() => _PopularState();
}

class _PopularState extends ConsumerState<Popular> {
  bool follow = false;

  @override
  Widget build(BuildContext context) {
    final PageStorageBucket bucket = ref.watch(popularBucket);

    return PageStorage(
      bucket: bucket,
      child: ListView.builder(
        key: const PageStorageKey<String>('popular'),
        itemBuilder: (context, index) {
          return containerUtils(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            borderRadius: 8,
            color: white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                      onTap: () {},
                      child: const Icon(
                        Icons.more_vert,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                containerUtils(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                  height: 8,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/logo/12313.png',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                textUtils(
                  text:
                      "Because Indonesia’s membership within the G20 isn’t just because of economic reasons. The G20 is practically speaking a regional power forum where regional powers",
                  letterSpacing: -0.5,
                  weight: FontWeight.bold,
                  size: 12,
                  color: Colors.black45,
                  textOverflow: TextOverflow.ellipsis,
                  line: 3,
                  align: TextAlign.justify,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
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
                    const SizedBox(
                      width: 12,
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
                )
              ],
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }
}
