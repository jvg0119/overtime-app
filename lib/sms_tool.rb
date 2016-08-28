module SmsTool

	def self.send_sms(number:, message:)
		puts "Sending SMS ..."
		puts "#{message} to #{number}"
	end

	def self.joes_message(num:, msg:)
		puts "Here is your message ..."
		puts "#{msg} to #{num}"
	end

end

