class MephistoController < ActionController::Base
  
  def redirect
    redirect_to url_for("/articles/#{params[:year]}/#{sprintf("%02d",params[:month])}/#{sprintf("%02d",params[:day])}/#{params[:slug]}/"), :status=>:moved_permanently
  end
  
end  