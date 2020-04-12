class SelectController < ApplicationController
  def top
    @teams = TeamMaster.all
  end
end
