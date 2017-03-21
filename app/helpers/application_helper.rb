module ApplicationHelper

  def slack_chat?
    Configurable[:use_helpdesk_chat] and (current_user or Configurable[:anonymous_helpdesk_chat])
  end


end
