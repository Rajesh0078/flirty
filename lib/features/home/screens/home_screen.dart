import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flirty/commons/widgets/custom_bottom_bar.dart';
import 'package:flirty/constants/colors.dart';
import 'package:flirty/features/home/services/all_user_provider.dart';
import 'package:flirty/models/user.dart';
import 'package:flirty/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final AppinioSwiperController controller = AppinioSwiperController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<User> users = ref.watch(allUsersProvider);

    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 6,
          toolbarHeight: 56,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/svg/logo.svg",
                  height: 24,
                ),
                const SizedBox(width: 4),
                const Text(
                  "roaster",
                  style: TextStyle(
                    color: CColors.primary,
                    fontSize: 28,
                    fontFamily: "Gazpacho",
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            SvgPicture.asset(
              "assets/svg/bell.svg",
              height: 25,
              colorFilter: const ColorFilter.mode(
                Color.fromARGB(255, 127, 123, 123),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 24),
            SvgPicture.asset(
              "assets/svg/filter.svg",
              height: 22,
              width: 20,
              colorFilter: const ColorFilter.mode(
                Color.fromARGB(255, 127, 123, 123),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 24)
          ],
        ),
        body: Stack(
          children: [
            AppinioSwiper(
              cardCount: users.length,
              controller: controller,
              backgroundCardCount: 0,
              backgroundCardScale: 1,
              backgroundCardOffset: const Offset(0, 10),
              invertAngleOnBottomDrag: true,
              onCardPositionChanged: (pos) {
                print(pos.offset.toAxisDirection());
              },
              maxAngle: 30,
              loop: true,
              cardBuilder: (BuildContext context, int index) {
                final user = users[index];
                return Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            "https://cdn.pixabay.com/photo/2023/03/31/14/22/leo-7890130_960_720.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 15,
                        right: 15,
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.7),
                                offset: const Offset(0, -2),
                                blurRadius: 20,
                                spreadRadius: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 100,
                        left: 14,
                        right: 14,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  user.username!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontFamily: "Gazpacho",
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.7,
                                  ),
                                ),
                                const Text(
                                  ", ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontFamily: "Gazpacho",
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.7,
                                  ),
                                ),
                                const Text(
                                  "20",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontFamily: "Gazpacho",
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.7,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Gazpacho",
                                fontSize: 13,
                                height: 1.4,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            Positioned(
              bottom: 16,
              left: 10,
              right: 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromARGB(255, 47, 44, 44),
                        border: Border.all(
                          color: const Color.fromARGB(255, 234, 219, 9),
                          width: 2,
                        )),
                    child: SvgPicture.asset(
                      "assets/svg/reset.svg",
                      colorFilter: const ColorFilter.mode(
                        Color.fromARGB(255, 234, 219, 9),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.swipeLeft,
                    child: Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color.fromARGB(255, 47, 44, 44),
                          border: Border.all(
                            color: const Color.fromARGB(255, 234, 9, 9),
                            width: 2,
                          )),
                      child: SvgPicture.asset(
                        "assets/svg/cancel.svg",
                        colorFilter: const ColorFilter.mode(
                          Color.fromARGB(255, 234, 9, 9),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.swipeUp,
                    child: Container(
                      height: 45,
                      width: 45,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color.fromARGB(255, 47, 44, 44),
                          border: Border.all(
                            color: const Color.fromARGB(255, 64, 186, 252),
                            width: 2,
                          )),
                      child: SvgPicture.asset(
                        "assets/svg/star.svg",
                        colorFilter: const ColorFilter.mode(
                          Color.fromARGB(255, 64, 186, 252),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.swipeRight,
                    child: Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color.fromARGB(255, 47, 44, 44),
                          border: Border.all(
                            color: const Color.fromARGB(255, 69, 216, 10),
                            width: 2,
                          )),
                      child: SvgPicture.asset(
                        "assets/svg/matches.svg",
                        colorFilter: const ColorFilter.mode(
                          Color.fromARGB(255, 69, 216, 10),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromARGB(255, 47, 44, 44),
                        border: Border.all(
                          color: const Color.fromARGB(255, 150, 12, 193),
                          width: 2,
                        )),
                    child: SvgPicture.asset(
                      "assets/svg/hifi.svg",
                      colorFilter: const ColorFilter.mode(
                        Color.fromARGB(255, 150, 12, 193),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: const CustomBottomBar(
          currentRoute: AppRoutes.home,
        ),
      ),
    );
  }
}
