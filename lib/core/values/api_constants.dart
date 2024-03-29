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

  static const getLogin = '$version/user/sign_in';
  static const getLogout = '$version/user/sign_out';
  static const getQuestions = '$version/user/questions/';
  static const getChallenges = '$version/user/daily_challenges/';
  static const getActivities = '$version/user/activities/';
  static const getActivityQuestions = '$version/user/activity_questions/';
  static const getChallengeSubmissions = '$version/user/challenge_submissions/';
}
