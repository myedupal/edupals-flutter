import 'package:edupals/features/question-bank/domain/model/answer.dart';
import 'package:edupals/features/question-bank/domain/model/exam.dart';
import 'package:edupals/features/question-bank/domain/model/subject.dart';
import 'package:edupals/features/question-bank/domain/model/topic.dart';

class QuestionWrapper {
  Question? question;
  List<Question>? questions;
  String? pages;

  QuestionWrapper({
    this.question,
    this.questions,
    this.pages,
  });

  factory QuestionWrapper.fromJson(Map<String, dynamic> json) =>
      QuestionWrapper(
        question: json["question"] == null
            ? null
            : Question.fromJson(json["question"]),
        questions: json["questions"] == null
            ? null
            : List<Question>.from(
                json["questions"].map((x) => Question.fromJson(x))),
        pages: json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "question": question?.toJson(),
      };
}

class Question {
  String? id;
  int? number;
  String? questionType;
  String? text;
  String? examId;
  String? subjectId;
  Exam? exam;
  Subject? subject;
  List<Answer>? answers;
  List<Answer>? questionImages;
  // List<QuestionTopic>? questionTopics;
  List<Topic>? topics;

  Question({
    this.id,
    this.number,
    this.questionType,
    this.text,
    this.examId,
    this.subjectId,
    this.exam,
    this.subject,
    this.answers,
    this.questionImages,
    // this.questionTopics,
    this.topics,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        number: json["number"],
        questionType: json["question_type"],
        text: json["text"],
        examId: json["exam_id"],
        subjectId: json["subject_id"],
        exam: json["exam"] == null ? null : Exam.fromJson(json["exam"]),
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        answers: json["answers"] == null
            ? []
            : List<Answer>.from(
                json["answers"]!.map((x) => Answer.fromJson(x))),
        questionImages: json["question_images"] == null
            ? []
            : List<Answer>.from(
                json["question_images"]!.map((x) => Answer.fromJson(x))),
        // questionTopics: json["question_topics"] == null
        //     ? []
        //     : List<QuestionTopic>.from(
        //         json["question_topics"]!.map((x) => QuestionTopic.fromJson(x))),
        topics: json["topics"] == null
            ? []
            : List<Topic>.from(json["topics"]!.map((x) => Topic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "question_type": questionType,
        "text": text,
        "exam_id": examId,
        "subject_id": subjectId,
        "exam": exam?.toJson(),
        "subject": subject?.toJson(),
        "answers": answers == null
            ? []
            : List<dynamic>.from(answers!.map((x) => x.toJson())),
        "question_images": questionImages == null
            ? []
            : List<dynamic>.from(questionImages!.map((x) => x.toJson())),
        // "question_topics": questionTopics == null
        //     ? []
        //     : List<dynamic>.from(questionTopics!.map((x) => x.toJson())),
        "topics": topics == null
            ? []
            : List<dynamic>.from(topics!.map((x) => x.toJson())),
      };
}
