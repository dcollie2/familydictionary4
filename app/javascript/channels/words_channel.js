import consumer from "./consumer"

consumer.subscriptions.create("WordsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to the words!");

  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
  }
});
