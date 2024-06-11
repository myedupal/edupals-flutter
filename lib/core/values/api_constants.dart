abstract class ApiConstants {
  static const connectTimeoutInMs = 20;
  static const receiveTimeoutInMs = 15;
  static const contentTypeJson = 'application/json';
  static const httpUnauthorizedIgnoreUrl = ['/auth/logout'];

  // API lists
  static const version = '/api/v1';
  static const getSubjects = '$version/web/subjects/';
  static const getTopics = '$version/web/topics/';
  static const getCurriculums = '$version/web/curriculums/';
  static const getExams = '$version/web/exams/';

  static const getUser = '$version/user';
  static const getUserAccount = '$version/user/account';
  static const getLogin = '$version/user/sign_in';
  static const getGoogleLogin = '$version/user/oauth/google';
  static const getLogout = '$version/user/sign_out';
  static const getQuestions = '$version/user/questions/';
  static const getChallenges = '$version/user/daily_challenges/';
  static const getActivities = '$version/user/activities/';
  static const getActivityQuestions = '$version/user/activity_questions/';
  static const getChallengeSubmissions = '$version/user/submissions/';
  static const getSubmissionAnswers = '$version/user/submission_answers/';
  static const getUserExams = '$version/user/user_exams/';
  static const getDailyChallengeReport =
      '$version/user/reports/daily_challenge';
  static const getMcqReport = '$version/user/reports/mcq';
  static const getPointsReport = '$version/user/reports/points';
  static const getZkProof = 'https://prover-dev.mystenlabs.com/v1';
}
