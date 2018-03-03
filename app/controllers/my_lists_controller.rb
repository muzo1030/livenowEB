class MyListsController < ApplicationController

	def create
		my_list = current_user.my_lists.new(video_id: params[:format])
		@v_id = params[:format]
		my_list.save
		redirect_to root_path
	end

	def destroy
		my_list = current_user.my_lists.find_by(video_id: params[:id])
		@v_id = params[:id]
		my_list.destroy
		redirect_to root_path
	end

	def index
		@my_lists = MyList.all.page(params[:page]).per(8)
	end

	private
	def my_list_params
		parmas.require(:my_list).permit(
			:video_id, :user_id)
	end
end
