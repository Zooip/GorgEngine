module ApplicationHelper

  def slack_chat?
    Configurable[:use_helpdesk_chat] and (current_user or Configurable[:anonymous_helpdesk_chat])
  end

  def google_analytics_id
    Rails.application.secrets.google_analytics_id
  end

end
