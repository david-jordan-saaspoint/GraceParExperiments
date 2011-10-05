class SayController < ApplicationController
  def hello
    @starttime = Time.now
  end

  def goodbye
    @endtime = Time.now
  end

end
