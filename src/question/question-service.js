'use strict';

const QuestionService = {
  getQuestions(db) {
    return db
      .select('*')
      .from('question')
      .orderBy(db.raw('RANDOM()'))
      .limit(10);
  }
};

module.exports = QuestionService;