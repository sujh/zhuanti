class Api::V1::TopicsController < Api::V1::BaseController
  before_action :load_doc, only: [:update, :show, :destroy, :publish, :unpublish]

  def create
    topic = Topic.create!(params.slice(:data).permit!)
    render_ok(topic)
  end

  def index
    docs = Topic.all
    render_ok docs
  end

  def update
    @doc.update(params.slice(:data).permit!)
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
    @doc.update(published: true)
    render_ok @doc
  end

  private

    def load_doc
      @doc = Topic.find(params[:id])
    end

end
