MongoidForums::ForumsController.class_eval do
    # Redefinition
    def index
      # start changes
      @recent = Kaminari.paginate_array(MongoidForums::Topic.by_most_recent_post.select {|t| can? :read, t}).page(params[:page]).per(MongoidForums.per_page)
      # end
    end
end