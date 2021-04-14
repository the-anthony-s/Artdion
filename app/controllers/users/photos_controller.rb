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

      # if @photo.save
      #   render json: { message: 'success', uploadId: @photo.id }, status: 200
      # else
      #   render json: { error: @photo.errors.full_messages.join(', ') }, status: 400
      # end
    end

    def edit
      # redirect to 404 if the user is not the owner
      return redirect_to @photo if current_user.id != @photo.user_id
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
      params.require(:photo).permit(:name, :image, :description, :location, :download, :private, :tag_list)
    end
  end
end
