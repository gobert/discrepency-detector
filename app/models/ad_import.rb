class AdImport < Ad
  attr_reader :id, :status, :description, :id_from_import, :job_id

  def initialize(params)
    @id = params['external_reference']
    @status = map_status(params['status'])
    @description = params['description']

    @id_from_import = params['id']
    @job_id = params['job_id']
  end
end
