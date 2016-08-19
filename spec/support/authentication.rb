
def sign_in(user) # manual sign in method
	visit(root_path)
	fill_in("Email", with: user.email)
	fill_in("Password", with: user.password)
	click_on("Log in")
end

def sign_in2(user_var) # this is using devise login_as method
#	user_var = create(:user)
	login_as(user_var, user: :user)
end


