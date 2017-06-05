module Api
  module V1
    class StaticController < ApplicationController
      include StaticHelper

      # GET /api/v1/server_setup
      def server_setup
        render json: application_server_setup, status: :ok
      end

      # GET /api/v1/stats
      def stats
        render json: application_stats, status: :ok
      end

      # GET /api/v1/help
      def help
        render json: application_help, status: :ok
      end
    end
  end
end
