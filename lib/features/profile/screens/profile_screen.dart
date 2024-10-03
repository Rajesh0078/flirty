import 'package:flirty/commons/widgets/custom_bottom_bar.dart';
import 'package:flirty/constants/colors.dart';
import 'package:flirty/features/onboarding_screen/screens/onboarding_screen.dart';
import 'package:flirty/provider/auth_provider.dart';
import 'package:flirty/provider/user_provider.dart';
import 'package:flirty/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    print(user);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(0, -2),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: AppBar(
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
                  "assets/svg/settings.svg",
                  height: 25,
                  width: 20,
                  colorFilter: const ColorFilter.mode(
                    Color.fromARGB(255, 127, 123, 123),
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 24)
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 240,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      child: Image.network(
                        user?['profile_picture'],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 172,
                      left: 0,
                      right: 0,
                      height: 120,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black.withOpacity(0.15),
                          //     offset: const Offset(0, -2),
                          //     blurRadius: 5,
                          //     spreadRadius: 0,
                          //   ),
                          // ],
                        ),
                        width: double.infinity,
                        child: const SizedBox.shrink(),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          height: 140,
                          width: 140,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: CColors.secondary,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              user?['profile_picture'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      '${user?['username']}, 24',
                      style: const TextStyle(
                        color: CColors.textColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Gazpacho",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(14),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  color: CColors.textColor.withOpacity(0.15))
                            ]),
                        padding: EdgeInsets.all(12),
                        child: Text(
                          "🎨 Artist at heart, I see beauty in everything! From painting to photography, my life is a canvas. Let's create our own masterpiece together. What inspires you?",
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    // Padding(
                    //     padding: const EdgeInsets.only(
                    //       bottom: 14,
                    //     ),
                    //     child: SizedBox(
                    //       height: 210,
                    //       width: double.infinity,
                    //       child: PageView(
                    //         children: [
                    //           // First Page
                    //           Container(
                    //             margin: const EdgeInsets.symmetric(
                    //               horizontal: 14,
                    //             ),
                    //             padding: const EdgeInsets.all(10),
                    //             width: double.infinity,
                    //             decoration: BoxDecoration(
                    //               border: Border.all(
                    //                 color: Colors.grey,
                    //                 width: 1.5,
                    //               ),
                    //               borderRadius: BorderRadius.circular(15),
                    //             ),
                    //             child: const Center(
                    //               child: Text(
                    //                 "Page 1",
                    //                 style: TextStyle(color: Colors.black),
                    //               ),
                    //             ),
                    //           ),
                    //           // Second Page
                    //           Container(
                    //             margin:
                    //                 const EdgeInsets.symmetric(horizontal: 14),
                    //             padding: const EdgeInsets.all(10),
                    //             width: double.infinity,
                    //             decoration: BoxDecoration(
                    //               border: Border.all(
                    //                 color: Colors.yellow, // Gold color
                    //                 width: 1.5,
                    //               ),
                    //               borderRadius: BorderRadius.circular(15),
                    //             ),
                    //             child: Center(
                    //                 child: Text("Page 2",
                    //                     style: TextStyle(color: Colors.black))),
                    //           ),
                    //           // Third Page
                    //           Container(
                    //             margin:
                    //                 const EdgeInsets.symmetric(horizontal: 14),
                    //             padding: const EdgeInsets.all(10),
                    //             width: double.infinity,
                    //             decoration: BoxDecoration(
                    //               border: Border.all(
                    //                 color: Colors.blue,
                    //                 width: 1.5,
                    //               ),
                    //               borderRadius: BorderRadius.circular(15),
                    //             ),
                    //             child: Center(
                    //                 child: Text("Page 3",
                    //                     style: TextStyle(color: Colors.black))),
                    //           ),
                    //         ],
                    //       ),
                    //     )),

                    Container(
                      padding: EdgeInsets.all(24),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          ref.read(authProvider.notifier).logout();
                          ref.read(userProvider.notifier).removeUser();
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageAnimationTransition(
                                page: const OnboardingScreen(),
                                pageAnimationType: FadeAnimationTransition()),
                            (route) => false,
                          );
                        },
                        child: Text("Logout"),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomBar(currentRoute: AppRoutes.profile),
      ),
    );
  }
}
