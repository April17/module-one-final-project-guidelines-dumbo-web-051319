class AccountProfile
  def self.account_menu (user)
    choice = $prompt.select("", ["Change Username", "Change Password", "Change Profile Picture", "Change Address", "Edit Bio", "Back to Main Menu", "Logout"])
    Utility.clear_page
    if choice == "Change Username"
      change_user_name(user)
    elsif choice == "Change Password"
      change_password(user)
    elsif choice == "Change Profile Picture"
      change_profile_picture(user)
    elsif choice == "Change Address"
      change_address(user)
    elsif choice == "Edit Bio"
      edit_bio(user)
    elsif choice == "Back to Main Menu"
      UserUI.master(user)
    elsif choice == "Logout"
      Welcome.welcome_to_igl
    else
      puts "Error, what is going on?"
      exit
    end
  end
  def self.display_account(user)
    acc_menu = Artii::Base.new :font => "slant"
    puts acc_menu.asciify("Account Menu")
    Utility.view_profile_picture(user.profile_picture_path)
    puts "User ID:#{user.id} | #{user.name}"
    puts "Address: #{user.address}"
    puts user.bio
    account_menu (user)
  end

  def self.change_user_name(user)
    new_user_name = $prompt.ask("New Username: ")
    user.name = new_user_name
    user.save
    Utility.clear_page
    puts "Username Changed"
    sleep(1)
    display_account(user)
  end

  def self.change_password(user)
    current_password = $prompt.mask("Current Password: ")
    new_password = $prompt.mask("New Password: ")
    repeat_password = $prompt.mask("Repeat Password: ")
    if Authentication.check_current_password(user, current_password) && Authentication.double_chack_passowrd(new_password, repeat_password)
      user.password = new_password
      user.save
      puts "Password Changed"
      sleep(1)
      Utility.clear_page
      Welcome.welcome_to_igl
    else
      choice = $prompt.select("One or more information is wrong, please try again.", ["Try Again", "Back to Main Menu"])
      if choice == "Try Again"
        Utility.clear_page
        change_password(user)
      elsif choice == "Back to Main Menu"
        Utility.clear_page
        display_account(user)
      end
    end
  end

  def self.change_profile_picture(user)
    src_dir = Utility.pick_picture
    user.profile_picture_path = $dst_dir + "/#{File.basename(src_dir)}"
    user.save
    user.reload
    puts "Done"
    sleep(1)
    display_account(user)
  end

  def self.change_address(user)
    new_address = $prompt.ask("New Address: ")
    user.address = new_address
    user.save
    puts "Done"
    sleep(1)
    display_account(user)
  end

  def self.edit_bio(user)
    new_bio = $prompt.ask("Edit Bio: ")
    user.bio = new_bio
    user.save
    puts "Done"
    sleep(1)
    display_account(user)
  end
end
