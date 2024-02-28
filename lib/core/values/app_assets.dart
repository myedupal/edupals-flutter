class AppAssets {
  static const _pngImagePath = 'assets/images/png/';
  static const _svgImagePath = 'assets/images/svg/';

  static const authBg = "${_pngImagePath}auth_bg.png";
  static const dashboardChallengeBg = "${_pngImagePath}dashboard_challenge.png";
  static const layoutBg = "${_pngImagePath}layout_background.png";
  static const mockQuestion = "${_pngImagePath}mock_question.png";

  static const appIcon = "${_svgImagePath}app_logo.svg";
  static const downChevron = "${_svgImagePath}down_chevron.svg";
  static const backIcon = "${_svgImagePath}ic_back.svg";

  String getPath({required String name}) {
    return "$_svgImagePath$name.svg";
  }
}
