module TweetsHelper

	def anchor_hash(tweet)


	message_arr = Array.new
	message_arr = tweet.message.split
    message_arr.each_with_index do |word, index|
      if word[0] =="#"
        #create a new instance of a tag

        if Tag.pluck(:phrase).include?(word.downcase)
          #save that tag as a variable (to use in tweetag creation)
          tag = Tag.find_by(phrase: word.downcase)

        else
          # create a new instance of Tag
          tag = Tag.create(phrase: word.downcase)

        end

        tweet_tag = TweetTag.create(tweet_id: tweet.id, tag_id: tag.id)
        message_arr[index] = "<a href='/tag_tweets?id=#{tag.id}'>#{word}<a>"

      end
    end

    tweet.update(message: message_arr.join(" "))
    return tweet

	end

end
