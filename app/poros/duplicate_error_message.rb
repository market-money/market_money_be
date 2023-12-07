class DuplicateErrorMessage < ErrorMessage
  attr_reader :message, :status_code

  def initialize(message, status_code)
    super(message, status_code)
    @message = "Validation failed: " + @message 
  end
end