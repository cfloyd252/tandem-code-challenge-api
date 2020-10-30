'use strict';

const QuestionService = {
  getQuestions(db) {
    return db
      .select('*')
      .from('question')
      .orderBy(db.raw('RANDOM()'))
      .limit(10);
  },

  getResponses(db, id) {
    return db
      .select('*')
      .from('response')
      .where({id});
  }
};

module.exports = QuestionService;