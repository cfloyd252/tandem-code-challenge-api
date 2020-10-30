'use strict';

const QuestionService = {
  getQuestions(db) {
    return db
      .from(
        'question as q'
      )
      .innerJoin(
        'response as r', 
        'q.responses', 
        'r.id'
      )
      .select(
        'q.id',
        'q.question',
        'q.correct_count',
        'q.incorrect_count',
        db.raw('ROW_TO_JSON(r) as responses')
      )
      .orderBy(db.raw('RANDOM()'))
      .groupBy(
        'q.id',
        'q.question', 
        'q.correct_count',
        'q.incorrect_count',
        'r'
      )
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