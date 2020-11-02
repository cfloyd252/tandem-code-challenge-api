'use strict';

const express = require('express')
const UserService = require('./user-service')
const { requireAuth } = require('../middleware/jwt-auth');
const path = require('path')
const xss = require('xss')

const userRouter = express.Router()
const jsonBodyParser = express.json()

const serializeUser = user => ({
  id: user.id,
  first_name: xss(user.first_name),
  username: xss(user.username),
})

  userRouter
  .get('/', requireAuth, async (req, res, next) => {
    try {
      const user = await UserService.getById(
        req.app.get('db'),
        req.user.id
      )
      return res
          .status(200)
          .json(serializeUser(user))
    } catch(error){
      next(error)
    }
  })
  .post('/', jsonBodyParser, async (req, res, next) => {
    const { password, username, first_name } = req.body
    let users = await UserService.getAllUsersUsernames(req.app.get('db'))
    console.log(users)
    users.forEach(user => {
      if (user.username === username) {
        return res.status(400).send({error: {message: 'Username already taken'}})
      }
    })
    if(first_name.length > 15) {
      return res.status(400).json({
        error: 'First name cannot exceed 15 characters'
      })
    }
    if(username.length > 15) {
      return res.status(400).json({
        error: 'User Name cannot exceed 15 characters'
      })
    }
    for (const field of ['first_name', 'username', 'password'])
      if (!req.body[field])
        return res.status(400).json({
          error: `Missing '${field}' in request body`
        })

    try {
      const passwordError = UserService.validatePassword(password)

      if (passwordError)
        return res.status(400).json({ error: passwordError })

      const hasUserWithUserName = await UserService.hasUserWithUserName(
        req.app.get('db'),
        username
      )

      if (hasUserWithUserName)
        return res.status(400).json({ error: `Username already taken` })

      const hashedPassword = await  UserService.hashPassword(password)

      const newUser = {
        username,
        password: hashedPassword,
        first_name,
      }

      const user = await UserService.insertUser(
        req.app.get('db'),
        newUser
      )

      res
        .status(201)
        .location(path.posix.join(req.originalUrl, `/${user.id}`))
        .json(serializeUser(user))
    } catch(error) {
      next(error)
    }
  })

module.exports = userRouter;