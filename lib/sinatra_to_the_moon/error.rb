# frozen_string_literal: true

module SinatraToTheMoon
  class Error < StandardError
  end

  class InvalidProjectNameError < Error
  end

  class DestinationExistsError < Error
  end

  class UnknownProfileError < Error
  end
end
