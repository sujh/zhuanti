class Api::V1::ParsersController < Api::V1::BaseController

  def parse_guests
    p 'start'
    p params

    render_ok Parser.parse_guests(params[:file])
  end

  def parse_agendas
    render_ok Parser.parse_agendas(params[:file])
  end

end
