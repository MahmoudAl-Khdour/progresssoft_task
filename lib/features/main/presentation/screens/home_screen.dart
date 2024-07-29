import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:progresssoft_task/core/utils/constant/app_defaults.dart';
import 'package:progresssoft_task/features/app/presentation/shared/components/custom_form_filed.dart';
import 'package:progresssoft_task/features/app/presentation/shared/components/custom_loading.dart';
import 'package:progresssoft_task/features/main/presentation/bloc/main_bloc/main_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<MainBloc>().add(GetPostsEvent());
    super.initState();
  }

  void _onSearchChanged(String query) {
    context.read<MainBloc>().add(FilterPostsEvent(query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'.tr)),
      body: Padding(
        padding: const EdgeInsets.only(
          top: AppDefaults.defaultTopPadding,
          left: AppDefaults.defaultLeftPadding,
          right: AppDefaults.defaultRightPadding,
        ),
        child: Column(
          children: [
            CustomFormFiled(
              onChange: (value) {
                _onSearchChanged(value);
              },
              fillColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              controller: searchController,
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: TextInputType.text,
              isPassword: false,
              enabled: true,
              readOnly: false,
              autofocus: false,
              borderColors: Theme.of(context).primaryColor,
              focusBorderColor: Theme.of(context).primaryColor,
              borderWidth: 1,
              textColor: Theme.of(context).primaryColor,
              filled: true,
              hint: 'Search'.tr,
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
              hintStyle: Theme.of(context).textTheme.labelMedium!,
              labelStyle: Theme.of(context).textTheme.labelMedium!,
              borderRadius: BorderRadius.circular(
                AppDefaults.defaultRightRadius,
              ),
              pressablePrefix: false,
            ),
            BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                if (state is PostsLoadingState) {
                  return const Center(child: CustomLoading());
                } else if (state is PostsLoadedState) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            '${'Title :'.tr} ${state.posts[index].title}',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          subtitle: Text(
                            '${'body :'.tr} ${state.posts[index].body}',
                            style: Theme.of(context).textTheme.labelSmall!,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        height: 0.4,
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                      ),
                    ),
                  );
                } else if (state is PostsErrorState) {
                  return Center(
                    child: Text(
                      '${'Failed to load posts:'.tr} ${state.message}'.tr,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
