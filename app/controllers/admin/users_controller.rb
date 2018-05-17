module Admin
  class UsersController < AdminBaseController
    before_action :load_user, only: %i(update edit destroy)

    def index
      @search = User.search params[:q]
      @users = @search.result.order_by_name.page(params[:page]).per_page Settings.show_limit.show_15
    end

    def update
      if params[:key]
        update_user_status
      else
        edit_user
      end
    end

    def edit; end

    def destroy
      if @user.destroy
        render_json_message t ".success"
      else
        render_json_message t ".failed"
      end
    end

    private

    def user_params
      params.require(:user).permit :name
    end

    def load_user
      @user = User.find_by id: params[:id]
      return if @user
      flash[:danger]
      redirect_to root_path
    end
  end
end
