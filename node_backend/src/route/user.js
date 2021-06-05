const router = require("express").Router();
const User = require("../model/user");

//save user info in mongodb at login
router.post("/login", async (req, res) => {
  try {
    const newDocument = new User({
      email: req.body.email,
      name: req.body.name,
      age: req.body.age,
      gender: req.body.gender,
    });
    const saveDocument = await newDocument.save();
    res.status(201).json(saveDocument);
    console.log("/login post router success");
  } catch (error) {
    res.status(500).json({ message: error });
  }
});



module.exports = router;
