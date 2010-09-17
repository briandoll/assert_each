class Test::Unit::TestCase

  # provides feedback on each assertion, rather than stopping after the first failure
  def assert_each(assertions)
    error_messages = ""
    assertions.each do |assertion, message, *variables|
      template = message.nil? ? "<?> is not true." : message
      if variables.empty?
        msg = build_message(nil, template, assertion)
      else
        msg = build_message(nil, template, *variables)
      end
      if err = safe_assert_block(msg){ assertion }
        error_messages << err.to_s << "\n"
      end
    end
    raise Test::Unit::AssertionFailedError.new(error_messages) if !error_messages.blank?
  end
  
  def safe_assert_block(message = "assert_block failed.")
    _wrap_assertion do
      if (! yield)
        message
      end
    end
  end

end