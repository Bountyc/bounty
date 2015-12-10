module BountiesGenerator

	def self.generate_bounty_from_question(question, user)
		bounty = Bounty.new
		bounty.title = question.title

		#check if we have a bounty with the same title; if so, don't go on
		bounties = Bounty.where :title=>bounty.title
		return nil if bounties.count > 0

		bounty.description = question.body
		bounty.description = ReverseMarkdown.convert bounty.description

		bounty.price = question.score > 20 ? 20 : question.score #we don't want to go over 20 bucks for one question!
		if bounty.price <= 0
			bounty.price = 5
		end

		bounty.poster = user
		bounty.save
		bounty
	end

	def self.generate_bounties_for_users(user_ids)
		stackoverflow_questions = RubyStackoverflow.questions({:filter=>"withbody",:sort=>"activity",:order=>"desc"}).data
		stackoverflow_questions.each do |question|
			user = User.find user_ids.sample
			if user != nil
				self.generate_bounty_from_question(question, user)
			end
		end
	end

end

