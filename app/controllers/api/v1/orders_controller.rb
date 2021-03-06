module Api
  module V1
    class OrdersController < Api::V1::BaseController
      before_action :authenticate_user
      before_action :set_order, only: [:checkout]

      def create
        status, @order = Orders::Services::Create.run(order_params)

        if status == :cannot_book
          render json: {message: "You can't book this schedule. Please looking for another schedule."}, status: :unprocessable_entity
        elsif status == :unavailable
          render json: {message: "You can't book this schedule. Booking is full. Please looking for another doctor."}, status: :unprocessable_entity
        elsif status != :created
          render json: {message: "Something wrong! Can't create order."}, status: :unprocessable_entity
        end
      end

      def checkout
        @order.update(status: Order::PAID)
        @order.reload
      end

      private

      def order_params
        params[:user_id] = @current_user.id
        params.permit(:doctor_id, :user_id, :schedule_id, :payment_type, :notes)
      end

      def set_order
        @order = Order.find_by(id: params[:id])
      end
    end
  end
end
