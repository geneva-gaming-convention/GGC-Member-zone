class Admin::BaseController < ApplicationController
	include SessionHelper
	
	before_action :must_be_admin
end
