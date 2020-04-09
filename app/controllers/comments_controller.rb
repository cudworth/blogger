class CommentsController < ApplicationController

    def create
        @comment = Comment.new(comment_params)
        @comment.article_id = params[:article_id]

        @comment.save

        flash.notice = "Comment added by #{@comment.author_name}."

        redirect_to article_path(@comment.article)
    end

    def comment_params
        params.require(:comment).permit(:author_name, :body)
    end

    before_action :require_login, except: [:create]

    def require_login
      unless current_user
        redirect_to root_path
        return false
      end
    end

end
