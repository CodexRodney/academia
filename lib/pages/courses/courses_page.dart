import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'widgets/course_card.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final coursesController = Get.find<CoursesController>();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final result = await coursesController.fetchUserCourses();
        result.fold(
            (l) => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Oops!"),
                    content: Text(l),
                    actions: [
                      FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Ooh, ok"),
                      )
                    ],
                  ),
                ), (r) {
          setState(() {});
        });
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
            title: const Text("Courses"),
            actions: [
              IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Courses"),
                      content: const Text(
                        "Here you can view your courses and everything in between",
                      ),
                      actions: [
                        FilledButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cool"),
                        )
                      ],
                    ),
                  );
                },
                icon: const Icon(Ionicons.information_circle_outline),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                    future: magnet.fetchUserClassAttendance(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Center(
                            child: Text(
                          "Fetching your courses we are",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ));
                      }

                      if (snapshot.hasError) {
                        return Center(
                            child: Text(
                          "Failed to fetch course attendance. Check your connection",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ));
                      }

                      return snapshot.data!.fold((l) {
                        return const Center(
                          child: Text(
                            "Failed to fetch courses. Check your connection",
                          ),
                        );
                      }, (r) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final data = r[index];
                            return ListTile(
                              leading: CircleAvatar(
                                child: Text((index + 1).toString()),
                              ),
                              title: Text(data.keys.first),
                              subtitle: LinearProgressIndicator(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                color: Theme.of(context).colorScheme.primary,
                                value: data.values.first.toDouble(),
                              ),
                            );
                          },
                          itemCount: r.length,
                        );
                      });
                    }),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverFillRemaining(
              child: coursesController.courses.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Lottie.asset("assets/lotties/empty.json"),
                        Image.asset("assets/images/study.gif"),
                        Text(
                          "No courses available right now, pull to refresh",
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        )
                      ],
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        final course = coursesController.courses[index];
                        return CourseCard(course: course);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 12,
                        );
                      },
                      itemCount: coursesController.courses.length,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
