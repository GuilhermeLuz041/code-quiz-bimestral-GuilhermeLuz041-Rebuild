class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_user, only: [:promote, :demote]

  def index
    @users = User.includes(:roles).all
  end

  def promote
    if @user.promote_to_moderator
      redirect_to users_path, notice: 'Usuário promovido a moderador com sucesso.'
    else
      redirect_to users_path, alert: 'Não foi possível promover o usuário.'
    end
  end

  def demote
    if @user.demote_from_moderator
      redirect_to users_path, notice: 'Moderador rebaixado com sucesso.'
    else
      redirect_to users_path, alert: 'Não foi possível rebaixar o moderador.'
    end
  end

  private

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: 'Acesso negado.'
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end