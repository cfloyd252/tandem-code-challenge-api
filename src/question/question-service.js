'use strict';

const Knex = require("knex");

const QuestionService = {
  getQuestions(db) {
    return db
      .select('*')
      .from('question')
      .orderBy(Knex.raw('RANDOM()'))
      .limit(10);
  }
};

module.exports = QuestionService;