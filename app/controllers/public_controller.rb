class PublicController < ApplicationController
  skip_before_action :not_logged_in
end
