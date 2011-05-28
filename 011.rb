



  alias_method :run_without_em, :run
  
  def run(result, &block)
    em(DefaultTimeout) { run_without_em(result, &block) }
  rescue Exception => e
    # ...
  end







