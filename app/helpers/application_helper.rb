module ApplicationHelper
  def pull_from_global(tag)
    result = GlobalSetting.find_by(tag: tag)
    
    if result.nil?
      return "ERROR: tag #{tag} not found in GlobalSetting"
    else
      return result.content
    end
  end
end
