const db = require('./index.js');

class WordRepository {

  add(word) {
    return db.transaction(t => {
      return db.models.Word.create({
        value: word.value,
        image: word.image,
        hint: word.hint
      }, {transaction: t});
    });
  }

  addAll(words) {
   let wordsToSave = words.map(word => {
     return {
      value: word.value,
      image: word.image,
      hint: word.hint
     }
   });

   return db.transaction(t => {
       return db.models.Word.bulkCreate(wordsToSave, {transaction: t});
   });
  }

  findById(id) {
    return db.models.Word.findById(id);
  }

  getRandomWords(amount) {
    return db.models.Word.findAll({
      order: "RANDOM()",
      limit: amount
    });
  }

  delete(id) {
    return db.transaction(t => {
      return db.models.Word.findById(id).then(word => {
        return word.destroy({transaction: t});
      });
    });
  }

}

module.exports = WordRepository;
