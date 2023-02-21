import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/layout/cubit/cubit.dart';
import 'package:movie_app/modules/filter/filter_screen.dart';
import 'package:movie_app/shared/components/components.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                defaultText(
                  text: 'Browse Categories',
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ConditionalBuilder(
                  condition: cubit.categoriesModel?.genres != null,
                  builder:(context)=> Expanded(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: cubit.categoriesModel?.genres?.length??0,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.0,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            print('movie index->${cubit.categoriesModel?.genres![index].id}');
                            navigateTo(context,  FiltterScreen(id: cubit.categoriesModel?.genres![index].id ??0,));
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: const Image(
                                  image: AssetImage(
                                      'assets/images/movies_category.png'),
                                  // width: 100.0,
                                  height: 130.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(5.0),),
                                height: 130.0,
                              ),
                              ConditionalBuilder(
                                fallback: (context) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                                condition: cubit.categoriesModel?.genres != null,
                                builder: (context) => defaultText(
                                  text:
                                      cubit.categoriesModel?.genres![index].name ??
                                          " ",
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  fallback: (context){
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
