class AdFromServer < Ad
  attr_reader :id, :status, :description

  def initialize(params)
    @id = params['reference']
    @status = map_status(params['status'])
    @description = params['description']
  end
end
