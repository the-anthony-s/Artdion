class SearchController < ApplicationController
  def show
    search = params[:q].present? ? params[:q] : nil
    # location = Geocoder.search(params[:q]).first # searches location
    # puts "\n\n\n\n\n\n\n #{location.longitude} + #{location.latitude} \n\n\n\n\n\n"

    @pagy, @photos = pagy_searchkick(
      Photo.pagy_search(
        search,
        # fields: ['username^10', 'default^10', 'location^9'],
        fields: ['name^10', 'tag^9', 'username^8', 'location^8'],
        suggest: true,
        track: { user_id: user_signed_in? ? current_user.id : nil },
        includes: %i[user],
        match: :word_middle,
        misspellings: { below: 5 }
        # where: {
        #   location: {
        #     near: {
        #       lat: location.latitude,
        #       lon: location.longitude
        #     },
        #     within: '100mi'
        #   }
        # }
      )
    )

    respond_to do |format|
      format.html
      format.json {
        render json: {
          entries: render_to_string(
            partial: 'photos/photo',
            collection: @photos,
            formats: [:html]
          ),
          pagination: view_context.pagy_nav(@pagy)
        }
      }
    end

    if @photos.total_count != 0
      @tags = ActsAsTaggableOn::Tag.joins([:taggings]).where(
        taggings: {
          taggable_type: 'Photo', taggable_id: @photos.pluck(:id)
        }
      ).take(20).uniq
    else
      @tags = Tag.default_order.take(20)
    end
  end

  def autocomplete
    render json: Tag.search(
      params[:q],
      fields: ['name'],
      match: :word_start,
      suggest: true,
      limit: 10,
      misspellings: { below: 5 },
      load: false
    ).map do |tag|
      {
        name: tag.name
      }
    end
  end
end
