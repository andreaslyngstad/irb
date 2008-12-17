# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  layout "test"
  skip_before_filter :login_required
  # render new.rhtml
  def new
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default('/home/index')
      
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      redirect_back_or_default('/public')
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "Du har logget ut."
      redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Sorry, feil brukernavn eller passord.
                      <br/> Du skrev brukernavenet (#{params[:login]}) og passordet (#{params[:password]}).
                      <br/> Ønsker du å bidra til siden, men har ikke brukernavn og passord? 
                      <br/> Ta kontakt så setter vi det opp for deg."
    logger.warn "Klarte ikke å logge inn '#{params[:login]}' fra #{request.remote_ip}, #{Time.now.utc}"
  end
end
