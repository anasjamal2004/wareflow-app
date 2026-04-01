import 'package:flutter/material.dart';
import 'package:warehouse_management_system/core/constants/app_colors.dart';
import 'package:warehouse_management_system/core/widgets/custom_text.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.transparentColor,
        title: CustomText(
          text: 'Dashboard',
          color: AppColors.blackColor,
          fontSize: 27,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customContainer(
                    headingText: 'Total Revenue',
                    icon: Icons.attach_money,
                  ),
                  customContainer(
                    headingText: 'Inventory Value',
                    icon: Icons.inventory,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customContainer(
                    headingText: 'Completed Orders',
                    icon: Icons.done,
                  ),
                  customContainer(
                    headingText: 'Active Suppliers',
                    icon: Icons.person,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // Line Chart Container
              Container(
                clipBehavior: Clip.antiAlias,
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor, // Color hamesha andar rahega
                  borderRadius: BorderRadius.circular(
                    20,
                  ), // Edges round karne ke liye
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        0.08,
                      ), // Halka shadow (Soft look)
                      blurRadius: 10, // Shadow kitna phelega
                      spreadRadius: 2, // Shadow ki motai
                      offset: const Offset(
                        0,
                        5,
                      ), // Shadow niche ki taraf (X=0, Y=5)
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              // Pie Chart Container
              Container(
                clipBehavior: Clip.antiAlias,
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor, // Color hamesha andar rahega
                  borderRadius: BorderRadius.circular(
                    20,
                  ), // Edges round karne ke liye
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        0.08,
                      ), // Halka shadow (Soft look)
                      blurRadius: 10, // Shadow kitna phelega
                      spreadRadius: 2, // Shadow ki motai
                      offset: const Offset(
                        0,
                        5,
                      ), // Shadow niche ki taraf (X=0, Y=5)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customContainer({
    required String headingText,
    required IconData icon,
  }) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 140,
      width: 160,
      decoration: BoxDecoration(
        color: AppColors.whiteColor, // Color hamesha andar rahega
        borderRadius: BorderRadius.circular(20), // Edges round karne ke liye
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08), // Halka shadow (Soft look)
            blurRadius: 10, // Shadow kitna phelega
            spreadRadius: 2, // Shadow ki motai
            offset: const Offset(0, 5), // Shadow niche ki taraf (X=0, Y=5)
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: headingText,
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
                Container(
                  height: 31,
                  width: 31,
                  decoration: BoxDecoration(
                    color: AppColors.blackColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: AppColors.whiteColor),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: CustomText(
              text: 'Data',
              color: AppColors.blackColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
