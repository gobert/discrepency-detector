class Ad
  def map_status(status)
    {
      'active' => :enabled,
      'paused' => :disabled,
      'deleted' => :deleted,
      'enabled' => :enabled,
      'disabled' => :disabled
    }[status] || raise('Unknown status')
  end
end
