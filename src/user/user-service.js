'use strict';

const bcrypt = require('bcryptjs');

const REGEX_UPPER_LOWER_NUMBER_SPECIAL = /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&])[\S]+/;

const UserService = {
  getAllUsersUsernames(db) {
    return db
      .from('user')
      .select('username');
  },

  getById(db, id) {
    return db
      .select(
        'id',
        'first_name',
        'username'
      )
      .from('user')
      .where('user.id', id)
      .first();
  },

  insertUser(db, newUser) {
    return db
      .insert(newUser)
      .into('user')
      .returning('*')
      .then(rows => {
        return rows[0];
      });
  },

  hasUserWithUserName(db, username) {
    return db('user')
      .where({ username })
      .first()
      .then(user => !!user);
  },

  validatePassword(password) {
    if (password.length < 8) {
      return 'Password must be longer than 8 characters';
    }
    if (password.length > 72) {
      return 'Password must be less than 72 characters';
    }
    if (password.startsWith(' ') || password.endsWith(' ')) {
      return 'Password must not start or end with empty spaces';
    }
    if (!REGEX_UPPER_LOWER_NUMBER_SPECIAL.test(password)) {
      return 'Password must contain one upper case, lower case, number and special character';
    }
    return null;
  },

  hashPassword(password) {
    return bcrypt.hash(password, 12);
  },
};

module.exports = UserService;