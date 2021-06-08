const router = require("express").Router();
const User = require("../model/user");

//save user info to mongodb at login
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

//delete user from mongodb at logout
router.delete("/logout", async (req, res) => {
  try {
    const removeDocumnet = await Guest.findByIdAndRemove({
      email: req.body.email,
    });

    res.status(200).json(removeDocumnet);

    console.log("/logout delete router success");
  } catch (error) {
    res.json({ message: error });
  }
});

//get user information
router.get("/userlist", async (req, res) => {
    try {
      const document = await User.collection.find();
  
      res.status(200).json(document);
  
      console.log("/userlist get router success");
    } catch (error) {
      res.json({ message: error });
    }
  });

module.exports = router;
