def remove_files_without_attachments_job
  remove_attachments_job = Sidekiq::Cron::Job.new(
    name: 'remove files not attached to anything, midnight every sunday',
    cron: '0 0 * * 0',
    class: "RemoveFilesWithoutAttachmentsJob"
  )
  unless remove_files_without_attachments_job.save
    Rails.logger.error "***** WARNING - Removing files without attachments was not saved! *****"
    Rails.logger.error remove_files_without_attachments_job.errors.join("; ")
  end
end

Sidekiq.configure_server do |config|
  config.redis = Rails.application.config_for(:redis)
  remove_files_without_attachments_job
end

Sidekiq.configure_client do |config|
  config.redis = Rails.application.config_for(:redis)
end
