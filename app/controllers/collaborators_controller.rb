class CollaboratorsController < ApplicationController
  def new
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find_by(email: params[:email] )
    @collaborator = Collaborator.new
    authorize @collaborator
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find_by(email: params[:email])
    @collaborator = Collaborator.new(wiki: @wiki, user: @user)
    name = @user.name
    authorize @collaborator

    if @collaborator.save
      flash[:notice] = "Congrats, you've added #{name} as a collaborator!"
      redirect_to edit_wiki_path(@wiki)
    #Add an elsif to invite users who aren't registered
    else
      flash[:error] = "Uh oh! There was an error adding #{name} as a collaborator!.  Please try again."
      redirect_to edit_wiki_path(@wiki)
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])
    name = @collaborator.user.name
    authorize @collaborator

    if @collaborator.destroy
      flash[:notice] = "You've removed #{name} as a collaborator!"
      redirect_to edit_wiki_path(@wiki)
    #Add an elsif to invite users who aren't registered
    else
      flash[:error] = "Uh oh! There was an error deleting #{name} as a collaborator!.  Please try again."
      redirect_to edit_wiki_path(@wiki)
    end
  end
end
