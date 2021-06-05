const server = require("./server");
const io = require("socket.io")(server);
const Message = require("../model/message");

console.log("Socket Connection Begin");

var connectedUsers = [];

io.on("connection", (socket) => {
  socket.on("chatID", (data) => {
    let chatID = data.id;

    socket.join(chatID);
    connectedUsers.push(chatID);

    socket.broadcast.emit("onlineUsers", {
      users: connectedUsers,
    });

    socket.on("disconnect", () => {
      //Remove ConnectedUsers
      let index = connectedUsers.indexOf(chatID);
      if (index > -1) {
        connectedUsers.splice(index, 1);
      }
      // Leave From Room
      socket.leave(chatID);
      socket.broadcast.emit("onlineUsers", {
        users: connectedUsers,
      });
    });

    socket.on("send_message", (message) => {
      receiverChatID = message.receiverChatID;
      senderChatID = message.senderChatID;
      content = message.content;

      saveMessage(content, senderChatID, receiverChatID, true);

      socket.in(receiverChatID).emit("receive_message", {
        content: content,
        senderChatID: senderChatID,
        receiverChatID: receiverChatID,
      });

      saveMessage(content, receiverChatID, senderChatID, false);
    });
  });
});

const saveMessage = (content, sender, receiver, isMy) => {
  var message = new Message({
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
    if (!doc) {
      message.save();
    } else {
      var receiverIndex = doc.users.findIndex(
        (element) => element._id === receiver
      );

      if (receiverIndex !== undefined && receiverIndex != -1) {
        doc.users[receiverIndex].messages.push({
          ismy: isMy,
          message: content,
        });
        doc.save();
      } else {
        doc.users.push({
          _id: receiver,
          messages: { ismy: isMy, message: content },
        });
        doc.save();
      }
    }
  }).catch((err) => {
    console.log(err.message);
  });
};
