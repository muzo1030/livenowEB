class MyListsController < ApplicationController

	def create
		v_id = params[:format]
		@my_list = current_user.my_lists.new(video_id: v_id)
		@my_list.save
	end

	def destroy
		v_id = params[:id]
		@my_list = current_user.my_lists.find_by(video_id: v_id)
		@my_list.destroy

		# redirect_to root_path
	end

	def index
		@my_lists = MyList.all.page(params[:page]).per(8).reverse_order
	end

	private
	def my_list_params
		parmas.require(:my_list).permit(
			:video_id, :user_id)
	end
end
