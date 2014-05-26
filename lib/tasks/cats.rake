namespace :cats do
  desc "Remove old sessions"
  task session_cleanup: :environment do
    old_sessions = Session.where('created_at < ?', 5.days.ago)
    old_sessions.delete_all
  end

end
