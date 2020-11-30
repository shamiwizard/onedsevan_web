class Panel::GamesController < Panel::MenuController
  before_action :find_game, only: %i[show edit update destroy]

  def index
    @games = Game.all
  end

  def show; end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new game_params
    @game.user = current_user

    if @game.valid?
      @game.save
      redirect_to panel_game_path(@game)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @game.update game_params
      redirect_to panel_game_path(@game)
    else
      render :edit
    end
  end

  def destroy
    redirect_to panel_games_path if @game.destroy
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
      :start_date,
      image: []
    )
  end

  def find_game
    @game = Game.find(params[:id])
  end
end