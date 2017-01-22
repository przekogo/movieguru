class SendFileJob
  include SuckerPunch::Job

  def perform(user, file_path)
    MovieExporter.new.call(user, file_path)
  end
end