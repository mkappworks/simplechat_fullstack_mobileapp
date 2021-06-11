const server = require("./server");
const cors = require("cors");
const io = require("socket.io")(server);

const Message = require("../model/message");
const User = require("../model/user");

console.log("Socket Connection Begin 1");

io.on('connect', (socket) => {

  console.log("Socket Connection Begin 2");

  socket.on('userData', async (data) =>  {
    //data is the 
    let userID = data.id;

    // Join the Room
    socket.join(userID);

    const document = await User.find();


  socket.broadcast.emit('loggedInUser', JSON.stringify([...document]));

    socket.on('disconnect', async () => {
      
    const document = await User.find();
          

    // Leave From Room
    socket.leave(userID);

    socket.broadcast.emit('loggedInUser', JSON.stringify([...document]));
   
    });

    socket.on('send_message', (message) => {
      receiverChatID = message.receiverChatID;
      senderChatID = message.senderChatID;
      content = message.content;

      saveMessage(content, senderChatID, receiverChatID, true);

      socket.in(receiverChatID).emit('receive_message', {
        content: content,
        senderChatID: senderChatID,
        receiverChatID: receiverChatID,
      });

      saveMessage(content, receiverChatID, senderChatID, false);
    }
    );
  });
});

const saveMessage = (content, sender, receiver, isMy) => {
  //intialising a Message Model with receiver and sender id and the message content
  const message = new Message({
    _id: sender,
    users: [
      {
        _id: receiver,
        messages: {
          isMy: isMy,
          message: content,
        },
      },
    ],
  });

  Message.findOne({ _id: sender }, (err, doc) => {
    //if no matching doc to sender id in the messages collection then the message is saved!
    if (!doc) {
      message.save();
    } else {
      //else if there is a sender id in the messages collection
      //the receiver id is checked and if available the index is assigned to receiverIndex
      const receiverIndex = doc.users.findIndex(
        (element) => element._id === receiver
      );

      //if receiver id is found then the message is pushed to the messages list in the particular receiver id and the doc is saved
      if (receiverIndex !== undefined && receiverIndex != -1) {
        doc.users[receiverIndex].messages.push({
          isMy: isMy,
          message: content,
        });
        doc.save();
      } else {
        //else the message doc is pushed as a new item
        doc.users.push({
          _id: receiver,
          messages: { isMy: isMy, message: content },
        });
        doc.save();
      }
    }
  }).catch((err) => {
    console.log(err.message);
  });
};
