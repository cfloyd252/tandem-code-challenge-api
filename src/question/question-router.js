'use strict';

const express = require('express')
const QuestionService = require('./question-service')

const questionRouter = express.Router()

questionRouter
  .route('/')
  .get(async(req, res, next) => {
    try {
      const questions = await QuestionService.getQuestions(req.app.get('db'))

      res.json(questions)
    } catch(error) {
      next(error)
    }
  })

module.exports = questionRouter;