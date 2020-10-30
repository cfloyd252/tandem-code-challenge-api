'use strict';

const express = require('express')
const QuestionService = require('./question-service')

const questionRouter = express.Router()
const jsonBodyParser = express.json()

questionRouter
  .route('/')
  .get(async(req, res, next) => {
    try {
      let questions = await QuestionService.getQuestions(req.app.get('db'))

      questions = questions.map(async(question) => {
        const responses = await QuestionService.getResponses(req.app.get('db'), question.id)

        return question
      })

      res.json(questions)
    } catch(error) {
      next(error)
    }
  })

module.exports = questionRouter;