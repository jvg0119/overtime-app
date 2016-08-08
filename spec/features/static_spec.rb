require 'rails_helper'

describe 'navigate' do 
	describe 'homepage' do 
		it 'can be reached successfully' do 
			visit(root_path)
			#expect(response).to eq(200)
			expect(page.status_code).to eq(200)
		end
	end
end


