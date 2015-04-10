class WikisController < ApplicationController
  def index
    if !current_user
      @wikis = Wiki.where(private: false)
    else
      @wikis = policy_scope(Wiki)
      authorize @wikis
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
    @section = Section.new
    @sections = @wiki.sections
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize @wiki
    if @wiki.save
      flash[:notice] = "Congrats, you've created a new wiki!"
      redirect_to @wiki
    else
      flash[:error] = "Uh oh! There was an error creating your wiki.  Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @sections = @wiki.sections
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was updated!"
      redirect_to @wiki
    else
      flash[:error] = "Uh oh! There was an error updating your wiki.  Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    title = @wiki.title

    if @wiki.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting this wiki."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
