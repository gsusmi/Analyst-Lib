class AnalystLib::MetadataNotFound < StandardError
  def initialize(item)
    super("Metadata not found for: #{item}")
  end
end
