class WordsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "words_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
