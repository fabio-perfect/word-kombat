const passwordHash = require('password-hash');
const express = require('express');
const router = express.Router();
const cloudinary = require('cloudinary');

const log = require('../logger');
const config = require('../config');
const userRepository = new (require("../repositories/user.repository"))();
const UserDetailsValidator = require('../util/user-details.validator');

const passport = require('../passport/jwt');

cloudinary.config(config.get('cloudinary'));

/**
 * @api {get} api/users/ Request information about all users
 * @apiName getUsers
 * @apiGroup Users
 *
 * @apiSuccess {Integer} id User Id.
 * @apiSuccess {String} username name of the User.
 * @apiSuccess {String} email Email of the User.
 * @apiSuccess {String} icon User's icon.
 * @apiSuccess {Number} score User's score.
 * @apiSuccess {Rank} rank User's rank.
*/
router.get('/', (req, res) => {
  userRepository.findAll()
    .then(users => {
      !!users && users.forEach(user => user.password = undefined);
      res.json(users);
    })
    .catch(error => {
      log.error(error);
      res.json(error);
    });
});

/**
 * @api {get} api/users/:id Request information about user by id
 * @apiName getUser
 * @apiGroup Users
 *
 * @apiSuccess {Integer} id User Id.
 * @apiSuccess {String} username name of the User.
 * @apiSuccess {String} email Email of the User.
 * @apiSuccess {String} icon User's icon.
 * @apiSuccess {Number} score User's score.
 * @apiSuccess {Rank} rank User's rank.
 *
 * @apiError UserNotFound   The <code>id</code> of the User was not found.
 *
*/
router.get('/:id(\\d+)', (req, res) => {
  userRepository.findById(req.params.id)
   .then(user => {
      if(user) {
        user.password = undefined;
      }
      res.json(user);
    })
    .catch(error => {
      log.error(error);
      res.json(error);
    });
});

/**
 * @api {get} api/users/:name Request information about user by first name
 *
 * @apiName getUserByName
 * @apiGroup Users
 *
 * @apiSuccess {Integer} id User Id.
 * @apiSuccess {String} username name of the User.
 * @apiSuccess {String} email Email of the User.
 * @apiSuccess {String} icon User's icon.
 * @apiSuccess {Number} score User's score.
 * @apiSuccess {Rank} rank User's rank.
 *
 * @apiError UserNotFound The <code>first_name</code> of the User was not found.
 *
*/
router.get('/:name(\\w+)', (req, res) => {
  userRepository.findByName(req.params.name)
   .then(user => {
      if(Boolean(user)) {
        user.password = undefined;
      }
      res.json(user);
    })
    .catch(error => {
      log.error(error);
      res.json(error);
    });
});

/**
 * @api {get} api/users/:email Request information about user by email
 *
 * @apiName getUserByEmail
 * @apiGroup Users
 *
 * @apiSuccess {Integer} id User Id.
 * @apiSuccess {String} username name of the User.
 * @apiSuccess {String} email Email of the User.
 * @apiSuccess {String} icon User's icon.
 * @apiSuccess {Number} score User's score.
 * @apiSuccess {Rank} rank User's rank.
 *
 * @apiError UserNotFound The <code>email</code> of the User was not found.
 *
*/
router.get('/:email(.+\@.+\..+)', (req, res) => {
  userRepository.findByEmail(req.params.email)
   .then(user => {
      if(Boolean(user)) {
        user.password = undefined;
      }
      res.json(user);
    })
    .catch(error => {
      log.error(error);
      res.json(error);
    });
});

/**
 * @api {put} api/users/:id Update User by id
 * @apiName updateUser 
 * @apiGroup Users
 *
 * @apiSuccess {Integer} id User Id.
 * @apiSuccess {String} username name of the User.
 * @apiSuccess {String} email Email of the User.
 * @apiSuccess {String} icon User's icon.
 * @apiSuccess {Number} score User's score.
 * @apiSuccess {Rank} rank User's rank.
 *
 * @apiSuccess {String} message Success message.
 * @apiError NoTokenProvided Only authenticated users can access the data.
 * @apiError UserNotFound The <code>id</code> of the User was not found.
 * @apiError Invalid data.
*/
router.put('/:id(\\d+)',
    passport.authenticate('jwt', passport.jwtSettings),
    (req, res) => {

  if(req.params.id != req.user.id) {
    return res.status(403).json({
      status: 403,
      message: "You haven't got owner privileges"
    });
  }

  let user = req.body;

  let validationStatus = UserDetailsValidator.validateUserDetails(user);
  if(validationStatus) {
    return res.status(400).json({error: validationStatus});
  }

  user.password = passwordHash.generate(user.password);

  userRepository.update(req.params.id, user)
    .then(user => {
      if(user) {
        user.password = undefined;
      }
      res.json(user);
    })
    .catch(error => {
      log.error(error);
      res.json(error);
    });
});

/**
 * @api {patch} api/users/:id/image Upload user image by id
 * @apiName uploadImage 
 * @apiGroup Users
 *
 * @apiSuccess {Integer} id User Id.
 * @apiSuccess {String} username name of the User.
 * @apiSuccess {String} email Email of the User.
 * @apiSuccess {String} icon User's icon.
 * @apiSuccess {Number} score User's score.
 * @apiSuccess {Rank} rank User's rank.
 *
 * @apiSuccess {String} message Success message.
 * @apiError NoTokenProvided Only authenticated users can access the data.
 * @apiError UserNotFound The <code>id</code> of the User was not found.
 * @apiError Invalid data.
*/
router.patch('/:id(\\d+)/image',
    passport.authenticate('jwt', passport.jwtSettings),
    (req, res) => {


    if(req.params.id != req.user.id) {
      return res.status(403).json({
        status: 403,
        message: "You haven't got owner privileges"
      });
    }

    cloudinary.uploader.upload(req.body.image, result => {
      if(result.url) {
        userRepository.findById(req.params.id)
          .then(user => {
            user.icon = result.url;
            user.save();
            user.password = undefined;
            res.json(user);
          }).catch(error => {
            log.error(error);
            res.status(500).json(error);
          });
      } else {
        res.status(500).json(result);
      }
    }, {public_id: config.get('cloudinary:user_icons_folder') + req.params.id});

});

/**
 * @api {delete} api/users/:id Delete user by id
 * @apiName deleteUser 
 * @apiGroup Users
 *
 * @apiParam {Integer} id User id.
 *
 * @apiSuccess {String} message Success message.
 * @apiError UserNotFound The <code>id</code> of the User was not found.
 * @apiError NoTokenProvided Only authenticated users can access the data.
*/
router.delete('/:id(\\d+)',
    passport.authenticate('jwt', passport.jwtSettings),
    (req, res) => {

  if(req.params.id != req.user.id) {
    return res.status(403).json({
      status: 403,
      message: "You haven't got owner privileges"
    });
  }

  userRepository.delete(req.params.id)
    .then(user => {
      res.json(user);
    })
    .catch(error => {
      log.error(error);
      res.json(error);
    });
});

module.exports = router;
