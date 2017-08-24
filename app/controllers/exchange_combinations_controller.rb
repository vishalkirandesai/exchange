# Controller for ExchangeCombinations
class ExchangeCombinationsController < ApplicationController
  before_action :set_exchange_combination,
                only: [:show, :edit, :update, :destroy]
  before_action :current_user?, only: [:update, :destroy]

  # GET /exchange_combinations
  # GET /exchange_combinations.json
  def index
    @exchange_combinations = ExchangeCombination.all
  end

  # GET /exchange_combinations/1
  # GET /exchange_combinations/1.json
  def show
    @history = ExchangeRecord.get_historical_data(@exchange_combination.base,
                                                  @exchange_combination.target)
  end

  # GET /exchange_combinations/new
  def new
    @exchange_combination = current_user.exchange_combinations.build
  end

  # GET /exchange_combinations/1/edit
  def edit; end

  def current_user?
    respond_to do |format|
      return unless @exchange_combination.user != current_user
      format.html do
        redirect_to root_path,
                    notice: 'You are not authorised to perform this action.'
      end
      format.json do
        render :show, status: :unauthorized, location: @exchange_combination
      end
    end
  end

  # POST /exchange_combinations
  # POST /exchange_combinations.json
  def create
    @exchange_combination = ExchangeCombination
                            .create_unique(exchange_combination_params,
                                           current_user)
    respond_to do |format|
      if @exchange_combination
        format.html do
          redirect_to @exchange_combination,
                      notice: 'Combination has been created or was available.'
        end
        format.json do
          render :show, status: :ok, location: @exchange_combination
        end
      else
        format.html { render :new }
        format.json { render json: errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exchange_combinations/1
  # PATCH/PUT /exchange_combinations/1.json
  def update
    if current_user.id != @exchange_combination.user.id
      render_unauthorised('Not yours to meddle with.')
    end
    respond_to do |format|
      if @exchange_combination.update(exchange_combination_params)
        format.html do
          redirect_to @exchange_combination,
                      notice: 'Exchange combination was successfully updated.'
        end
        format.json do
          render :show, status: :ok, location: @exchange_combination
        end
      else
        format.html { render :edit }
        format.json do
          render json: @exchange_combination.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def render_unauthorised(message)
    respond_to do |format|
      format.html { render :edit, status: :unauthorized, notice: message }
      format.json do
        render json: @exchange_combination.errors,
               status: :unauthorized
      end
    end
  end

  # DELETE /exchange_combinations/1
  # DELETE /exchange_combinations/1.json
  def destroy
    @exchange_combination.destroy
    respond_to do |format|
      format.html do
        redirect_to exchange_combinations_url,
                    notice: 'Exchange combination was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_exchange_combination
    @exchange_combination = ExchangeCombination.find(params[:id])
  end

  # Only allow the following params.
  def exchange_combination_params
    params.require(:exchange_combination).permit(:base, :target, :amount, :wait)
  end
end
