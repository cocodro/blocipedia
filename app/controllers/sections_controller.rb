class SectionsController < ApplicationController

  def new
    @wiki = Wiki.find(params[:wiki_id])
    @section = Section.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @section = Section.new(section_params)
    @section.wiki = @wiki

    if @section.save
      redirect_to @wiki
    else
      flash[:error] = "The section was not properly saved!"
      redirect_to :back
    end
  end

  def update
    @wiki = Wiki.find(params[:wiki_id])
    @section = Section.find(params[:id])
    @section.wiki = @wiki

    if @section.update_attributes(section_params)
      flash[:notice] = "\"#{@section.title}\" was successfully saved!"
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "\"#{@section.title}\" was not properly saved!"
      redirect_to :back
    end
  end

  def edit
    @section = Section.find(params[:id])
    @wiki = @section.wiki
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @section = Section.find(params[:id])
    @section.wiki = @wiki
    title = @section.title

    if @section.destroy
      flash[:notice] = "The section entitled \"#{title}\" was deleted!"
      redirect_to request.referer
    else
      flash[:error] = "The section entitled \"#{title}\" was not deleted!"
      redirect_to :back
    end
  end

  private

  def section_params
    params.require(:section).permit(:title, :body)
  end
end
