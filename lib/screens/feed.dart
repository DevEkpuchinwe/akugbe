import 'dart:convert';

import 'package:akugbe/api_response_models/klik_model.dart';
import 'package:akugbe/api_response_models/postModel.dart';
import 'package:akugbe/network_config/network_base.dart';
import 'package:akugbe/screens/boost_post.dart';
import 'package:akugbe/screens/other_profile.dart';
import 'package:akugbe/screens/search.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';
import '../config/text_styles.dart';
import '../custom_widgets/mediaView.dart';
import '../utils/app_utils.dart';
import 'klik_details.dart';

/*class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<dynamic> posts = [];
  bool isLoading = true;
  bool hasError = false;*/

class Feed extends ConsumerStatefulWidget {
  const Feed({super.key});

  @override
  ConsumerState createState() => _FeedState();
}

class _FeedState extends ConsumerState<Feed>
    with AppNavigator, TickerProviderStateMixin {
  late TabController tabController;
  final GlobalKey _buttonKey = GlobalKey();
//Map<String<dynamic> posts = [
//  List<Map<String, dynamic>> posts = [];
List<Post> posts = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
   // fetchAllPosts();
     loadPosts();
     tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  void loadPosts() async {
  try {
    final fetchedPosts = await fetchAllPosts();
    setState(() {
      //posts = fetchedPosts.cast<Map<String, dynamic>>();
      posts = fetchedPosts;
      isLoading = false;
    });
  } catch (e) {
    setState(() {
      isLoading = false;
      hasError = true;
    });
  }
}


Future<List<Post>> fetchAllPosts() async {
  try {
    final response = await NetworkConfig().getRequest(
      'posts',
      null,
      needAuth: true,
    );

    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {

      //final jsonBody = json.decode(response.data);
     // final List posts = jsonBody['data'];//['data'];
 final jsonBody = response.data; // ✅ No decoding needed
      final List posts = jsonBody['data']['data'];
      return posts.map((e) => Post.fromJson(e)).toList();

    } else {
      print('Unexpected status code: ${response.statusCode}');
      throw Exception('Failed to load posts');
    }
  } catch (e) {
    print('Error fetching posts: $e');
    throw Exception('Error fetching posts');
  }
}

void showPopupMenu(BuildContext context){
    final RenderBox renderBox = _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx, // X position
        offset.dy + size.height * 4, // Y position (above the widget)
        offset.dx + size.width,
        offset.dy,
      ),
      items: [
        PopupMenuItem(
            child: GestureDetector(
              onTap:(){},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/download_n.png"),
                  10.horizontalSpace,
                  Text(
                    "Download",
                    style: smallNormalText,
                  )
                ],
              ),
            )),
        PopupMenuItem(
            child: GestureDetector(
              onTap:(){},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/favourite.png", width: 20,),
                  10.horizontalSpace,
                  Text(
                    "Save to my favourite",
                    style: smallNormalText,
                  )
                ],
              ),
            )),
        PopupMenuItem(
            child: GestureDetector(
              onTap:(){},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/comment_n.png", width: 20,),
                  10.horizontalSpace,
                  Text(
                    "Comment",
                    style: smallNormalText,
                  )
                ],
              ),
            )),
        PopupMenuItem(
            child: GestureDetector(
              onTap:(){},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/share.png", width: 20,),
                  10.horizontalSpace,
                  Text(
                    "Share",
                    style: smallNormalText,
                  )
                ],
              ),
            )),
        PopupMenuItem(
            child: GestureDetector(
              onTap:(){},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/report.png", width: 20,),
                  10.horizontalSpace,
                  Text(
                    "Report this",
                    style: smallNormalText,
                  )
                ],
              ),
            )),
        PopupMenuItem(
            child: GestureDetector(
              onTap:(){
                pushTo(context, const BoostPost());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                 Icon(Icons.auto_graph_rounded, size: 20, color: GlobalColors.blackColor,),
                  10.horizontalSpace,
                  Text(
                    "Boost Post",
                    style: smallNormalText,
                  )
                ],
              ),
            ))
      ],
    );
  }
final List<Klik> kliks = [
    Klik(
      name: "Tech Innovators",
      location: "San Francisco",
      maxPeople: 20,
      privacy: "Public",
      description: "A group for tech enthusiasts.",
      totalAmount: 5000.0,
      minAmount: 100.0,
      gender: "Any",
      startDate: "2025-04-01",
      endDate: "2025-12-01",
      imageUrl: "https://via.placeholder.com/150",
    ),
    Klik(
      name: "Fitness Club",
      location: "New York",
      maxPeople: 15,
      privacy: "Private",
      description: "A group for fitness lovers.",
      totalAmount: 3000.0,
      minAmount: 50.0,
      gender: "Male",
      startDate: "2025-05-01",
      endDate: "2025-11-30",
      imageUrl: "https://via.placeholder.com/150",
    ),
  ];
String buildSupabaseImageUrl(int postId) {
  return "https://raapnfbewyiflaoaxgmi.supabase.co/storage/v1/object/public/posts//$postId";
}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset("assets/logo.png", width: 100),
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: "All Feeds"),
              Tab(text: "All Kliks"),
            ],
          ),
          actions: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    pushTo(context, const Search());
                  },
                  child: Image.asset("assets/Search.png"),
                ),
                const SizedBox(width: 30),
                Image.asset("assets/Bell_light.png")
              ],
            )
          ],
        ),
        body: TabBarView(
          children: [

            /// === All Feeds Tab ===
            //isEmpty
 // ? Center(child: Text("No posts found"))
  isLoading
                ? const Center(child: CircularProgressIndicator())
                : hasError
                    ? Center(child: Text("Failed to load posts"))
             : ListView.builder(
                        itemCount: posts.length,
                      itemBuilder: (context, index) {
  final post = posts[index]; // post is a Post object now
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      pushTo(context, const OtherProfile());
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage("https://picsum.photos/id/237/200/300"),
                    ),
                  ),
                  const SizedBox(width: 10),
                 // Text(//User.username,
                //  "Ekpu Chinwe",
                  // style: boldText),
                  Text(post.user?.username ?? "Anonymous", style: boldText),


                ],
              ),
              Text(AppUtils.formatDate(post.createdAt), style: smallNormalText.copyWith(color: Colors.grey)),

            //  Text(post.createdAt as String,
             //     style: smallNormalText.copyWith(color: Colors.grey)),
            ],
          ),
        ),
        const SizedBox(height: 5),
       // Padding(
       //   padding: const EdgeInsets.symmetric(horizontal: 15),
       //   child: Text(
       //     post.tags ?? "#NoTags",
       //     style: normalText.copyWith(color: GlobalColors.lightBlue),
      //    ),
      //  ),
        Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        post.content,
                        style: normalText.copyWith(color: GlobalColors.blackColor),
                      ),
                    ),
                    SizedBox(height:5),
    /*   CachedNetworkImage(
  width: double.infinity,
  fit: BoxFit.fitWidth,
  imageUrl: buildSupabaseImageUrl(post.id),
  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
  errorWidget: (context, url, error) => Image.network(
    "https://picsum.photos/id/237/200/300",
    width: double.infinity,
    fit: BoxFit.fitWidth,
  ),
),*/
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1578206518.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:83625442.
PostMediaWidget(postId: post.id),
      //  const SizedBox(height: 10),

 
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: GlobalColors.primaryColor,
                ),
                child: Text(
                  AppUtils.formatAmount("500"),//post.amount.toString()),
                  style: normalTextBold.copyWith(
                      color: GlobalColors.blackColor, fontSize: 10.sp),
                ),
              ),
              Row(
                children: [
                  Image.asset("assets/love.png", width: 15, color: GlobalColors.blackColor),
                  const SizedBox(width: 5),
                  Text("5",//post.likes.toString(),
                      style: normalText.copyWith(fontSize: 11.sp)),
                  const SizedBox(width: 10),
                  Image.asset("assets/comment_n.png", width: 15, color: GlobalColors.blackColor),
                  const SizedBox(width: 5),
                  Text("300",//post.comments.toString(),
                      style: normalText.copyWith(fontSize: 11.sp)),
                  const SizedBox(width: 10),
                  const Icon(Icons.remove_red_eye_outlined, size: 15),
                  const SizedBox(width: 5),
                  Text("20",//post.views.toString(),
                      style: normalText.copyWith(fontSize: 11.sp)),
                  const SizedBox(width: 10),
                  GestureDetector(
                      onTap: () {
                        showPopupMenu(context);
                      },
                      child: const Icon(Icons.more_vert_rounded)),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

                      ),

            /// === All Kliks Tab ===
            ListView.builder(
              itemCount: kliks.length,
              itemBuilder: (context, index) {
                final klik = kliks[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(klik.imageUrl),
                    ),
                    title: Text(klik.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        "Min Contribution: \$${klik.minAmount.toStringAsFixed(2)}"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KlikDetailScreen(klik: klik),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
