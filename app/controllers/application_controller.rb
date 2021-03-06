# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include DeviseWhitelist
  include CableReady::Broadcaster
  #  protect_from_forgery

  # include CurrentUserConcern
  require 'faker'
  helper_method :current_or_guest_user

  # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        logging_in
        puts "test"
        puts "11111111"
        # reload guest_user to prevent caching problems before destruction
        guest_user(with_retry = false).try(:reload).try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
      puts "222222222222"
    else
      guest_user
      puts "3333333333"
    end
  end

  def guest_login
    current_or_guest_user
    redirect_back(fallback_location: root_path)
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)
  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
    session[:guest_user_id] = nil
    guest_user if with_retry
  end

  private

  # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to current_user.
  def logging_in
    # For example:
    # guest_comments = guest_user.comments.all
    # guest_comments.each do |comment|
    # comment.user_id = current_user.id
    # comment.save!
    # end
    puts "this is a test"
  end

  def create_guest_user
    u = Guest.new(user_name: Faker::Superhero.unique.name, email: "guest_#{Time.now.to_i}#{rand(100)}@example.com")
    u.save!(validate: false)
    session[:guest_user_id] = u.id
    u
  end
end
