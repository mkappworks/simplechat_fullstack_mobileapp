const server = require("./server");
const io = require("socket.io")(server);
const Message = require("../model/message");
const User = require("../model/user");

io.on('connect', (socket) => {

  console.log("Connected to Socket");

  socket.on('userData', async (data) =>  {
    //data from the client side containing the id
    let userID = data.id;
    // Join the Room
    socket.join(userID);
    //get User collection from db
    const document = await User.find();

  //broadcast all Users from the db in a JSON format
  socket.broadcast.emit('loggedInUser', JSON.stringify([...document]));

    socket.on('disconnect', async () => {
      //get User collection from db
    const document = await User.find();     
    // Leave From Room
    socket.leave(userID);
    console.log("Disconnected from Socket");
    //broadcast all Users from the db in a JSON format
    socket.broadcast.emit('loggedInUser', JSON.stringify([...document]));
    });

    socket.on('send_message', (message) => {
      receiverChatID = message.receiverChatID;
      senderChatID = message.senderChatID;
      createdAt = message.createdAt;
      messageContent = message.content;

      //save content in the senders collection
      saveMessage(messageContent, senderChatID, receiverChatID,  createdAt , true);

      socket.in(receiverChatID).emit('receive_message', {
        content: messageContent,
        senderChatID: senderChatID,
        receiverChatID: receiverChatID,
        createdAt : createdAt
      });

      //save content in the receivers collection
      saveMessage(messageContent, receiverChatID, senderChatID,  createdAt ,false);
    }
    );
  });
});

const saveMessage = (messageContent, sender, receiver,  createdAt , isMy) => {
  //intialising a Message Model with receiver and sender id and the message content
  let messageDetails = {
    isMy: isMy,
    message: messageContent,
    createdAt: createdAt,
  };

  let message = new Message({
    _id: sender,
    users: [
      {
        _id: receiver,
        messages: messageDetails,
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
        doc.users[receiverIndex].messages.push(messageDetails);
        doc.save();
      } else {
        //else the message doc is pushed as a new item
        doc.users.push({
          _id: receiver,
          messages: messageDetails,
        });
        doc.save();
      }
    }
  }).catch((err) => {
    console.log(err.message);
  });
 };
