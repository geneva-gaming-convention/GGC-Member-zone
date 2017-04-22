module ApplicationHelper
  def get_revision(length=1000)
    if File.exist?(Rails.root.join('REVISION'))
      return File.read(Rails.root.join('REVISION'))[0...length]
    else
      return "unknown 😳"
    end
  end
end
