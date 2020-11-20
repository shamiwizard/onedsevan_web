class Panel::GamesController < MenuController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new(game_params)
    @game.user = current_user
  end

  def create
    @game.save
  end

  def edit
  end

  def update
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
  end

  private

  def game_params
    params.require(:game).permit(
      :title,
      :description,
      :image,
      :max_players,
      :min_level,
      :max_level,
      :start_date
    )
  end
end