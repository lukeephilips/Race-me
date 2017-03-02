module HomeHelper
  def banner_pics
    pics = Dir.new(Rails.root.to_s + "/app/assets/images/running_pics").to_a
    pics.delete('.')
    pics.delete('..')
    pics
  end
end
