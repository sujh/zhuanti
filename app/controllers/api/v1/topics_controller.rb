class Api::V1::TopicsController < Api::V1::BaseController
  before_action :load_doc, only: [:update, :show, :destroy, :publish, :unpublish]
  skip_before_action :authenticate, only: [:show]

  def create
    topic = Topic.create!(params.slice(:data_draft).permit!)
    render_ok(topic)
  end

  def index
    docs = Topic.asc("created_at")
    render_ok docs
  end

  def update
    @doc.update(params.slice(:data_draft).permit!)
    render_ok @doc
  end

  def show
    render_ok @doc
  end

  def destroy
    @doc.destroy
    render_ok
  end

  def unpublish
    @doc.update(published: false)
    render_ok @doc
  end

  def publish
    if @doc.data_draft.present?
      @doc.update(published: true, data: @doc.data_draft)
    else
      @doc.update(published: true)
    end
    render_ok @doc
  end

  private

    def load_doc
      @doc = Topic.find(params[:id])
    end

end
