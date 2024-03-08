class AppAssets {
  static const _pngImagePath = 'assets/images/png/';
  static const _svgImagePath = 'assets/images/svg/';
  static const _lottiePath = 'assets/images/lottie/';

  static const authBg = "${_pngImagePath}auth_bg.png";
  static const dashboardChallengeBg = "${_pngImagePath}dashboard_challenge.png";
  static const layoutBg = "${_pngImagePath}layout_background.png";
  static const mockQuestion = "${_pngImagePath}mock_question.png";

  static const appIcon = "${_svgImagePath}app_logo.svg";
  static const downChevron = "${_svgImagePath}down_chevron.svg";
  static const downChevronFill = "${_svgImagePath}down_chevron_fill.svg";
  static const backIcon = "${_svgImagePath}ic_back.svg";
  static const cross = "${_svgImagePath}cross.svg";
  static const addIcon = "${_svgImagePath}ic_add.svg";
  static const flag = "${_svgImagePath}flag.svg";
  static const flashCard = "${_svgImagePath}flash_cards.svg";
  static const leftChevron = "${_svgImagePath}left_chevron.svg";
  static const rightChevron = "${_svgImagePath}right_chevron.svg";

  //Lottie
  static const errorLottie = "${_lottiePath}error.json";
  static const questionLoadingLottie = "${_lottiePath}question_loading.json";

  String getPath({required String name}) {
    return "$_svgImagePath$name.svg";
  }
}
