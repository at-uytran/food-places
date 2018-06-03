module Admin
  class UserRatingsController < AdminBaseController
    before_action :load_user_rating, only: :destroy

    def index
      @user_ratings = UserRating.all.page(params[:page]).per_page 9
    end

    def destroy
      @user_rating.destroy
    end

    private

    def load_user_rating
      @user_rating = UserRating.find_by id: params[:id]
    end
  end
end
