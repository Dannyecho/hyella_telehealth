part of '../welcome_page.dart';

final class WelcomeSlideItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imgPath;
  final String buttonTitle;
  final void Function() onPressed;

  const WelcomeSlideItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.imgPath,
    required this.onPressed,
    this.buttonTitle = "Next",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        const SizedBox(height: 42),
        SizedBox(
          width: 345,
          child: Image.asset(
            imgPath,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                color: AppColors.primaryText,
              ),
            ),
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 48,
        ),
        InkWell(
            onTap: onPressed,
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              child: Text(
                buttonTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        const Spacer(),
      ],
    );
  }
}
