module Users
  class PhotosController < PhotosController
    before_action :authenticate_user!

    def new
      @photo = Photo.new
    end

    def create
      @photo = current_user.photos.build(photo_params)

      if @photo.save
        redirect_to @photo, notice: 'Photo was successfully created.'
      else
        render :new, notice: 'Something went wrong'
      end
    end

    def edit
      # redirect to 404 if the user is not the owner
      # return redirect_to @photo if user_signed_in? && current_user.id != @photo.user_id
    end

    def update
      @photo.assign_attributes(photo_params)

      if @photo.valid?
        @photo.save
        redirect_to @photo, notice: "#{@photo.name} successfully updated."
      else
        render :edit, notice: 'Something went wrong. Please, try again.'
      end
    end

    private

    def photo_params
      params.require(:photo).permit(:name, :image, :description, :location, :download, :private, :tag_list, :type_id)
    end
  end
end
