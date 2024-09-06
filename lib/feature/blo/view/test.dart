import 'package:beta/feature/blo/bloc/test_bloc.dart';
import 'package:beta/theme/app_color.dart';
import 'package:beta/theme/text_styles.dart';
import 'package:beta/widget/custom_edittext_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Testing extends StatelessWidget {
  const Testing({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TestBloc(),
      child: BlocBuilder<TestBloc, TestState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(),
            body: Column(
              children: [
                CustomEditTextField(
                    style: AppTextStyle.regular400(),
                    onChanged: (value) {
                      context.read<TestBloc>().cal();
                    },
                    topPadding: 8,
                    leftPadding: 18,
                    rightPadding: 18,
                    isValueRestricted: true,
                    hintText: "Annual",
                    controller: context.read<TestBloc>().annualController,
                    textInputAction: TextInputAction.next),
                CustomEditTextField(
                    style: AppTextStyle.regular400(),
                    onChanged: (value) {
                      context.read<TestBloc>().cal();
                    },
                    topPadding: 8,
                    leftPadding: 18,
                    rightPadding: 18,
                    isValueRestricted: true,
                    hintText: "AC",
                    controller: context.read<TestBloc>().acController,
                    textInputAction: TextInputAction.next),
                CustomEditTextField(
                    style: AppTextStyle.regular400(),
                    onChanged: (value) {
                      context.read<TestBloc>().cal();
                    },
                    topPadding: 8,
                    leftPadding: 18,
                    rightPadding: 18,
                    isValueRestricted: true,
                    hintText: "room",
                    controller: context.read<TestBloc>().roomController,
                    textInputAction: TextInputAction.next),
                CustomEditTextField(
                    style: AppTextStyle.regular400(),
                    onChanged: (value) {
                      context.read<TestBloc>().cal();
                    },
                    topPadding: 8,
                    leftPadding: 18,
                    rightPadding: 18,
                    isValueRestricted: true,
                    hintText: "other",
                    controller: context.read<TestBloc>().otherController,
                    textInputAction: TextInputAction.next),
              ],
            ),
          );
        },
      ),
    );
  }
}
