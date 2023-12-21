class Api::CompaniesController < ApplicationController
	before_action :authenticate_user!, only: [:create]


	rescue_from ActiveRecord::RecordNotFound do |exception|
  		render json: { error: 'Company not found' }, status: :not_found
	end

	rescue_from ActionController::ParameterMissing do |exception|
  		render json: { error: "Missing parameter: #{exception.param}" }, status: :unprocessable_entity
	end

  def index
  	@companies = Company.all
  	render json: @companies, only: [:name, :location]
  end

  def create
  	authenticate_user!
  	authorize_admin!
  	@company = Company.new(company_params)

  	if @company.save
  		render json: @company, only: [:name, :location], status: :created
  	else
  		render json: { error: 'Failed to create company' }, status: :unprocessable_entity
  	end
  end

  private

  def company_params
  	params.require(:company).permit(:name, :location)
  end

  def authorize_admin!
    render json: { error: 'Unauthorized user' }, status: :unauthorized unless current_user&.admin?
  end
end
