require 'rails_helper'


RSpec.describe 'Users::Services::Create', type: :integration do
  describe '.run' do
    before do
      @params = {
        full_name: 'M. Arif Sefrianto',
        email: 'arifsefrianto@gmail.com',
        password: '12345678'
      }
    end

    context 'witth valid params' do
      it 'should create user' do
        status, user = Users::Services::Create.run(@params)

        expect(status).to eq(:created)
        expect(user.persisted?).to eq(true)
      end
    end

    context 'with empty password' do
      it 'should not create user and return error message' do
        @params[:password] = nil
        status, user = Users::Services::Create.run(@params)

        expect(status).to eq(:failed)
        expect(user.errors.messages.present?).to eq(true)
        expect(user.errors.full_messages.first).to eq("Password can't be blank")
      end
    end

    context 'with empty email' do
      it 'should not create user and return error message' do
        @params[:email] = nil
        status, user = Users::Services::Create.run(@params)

        expect(status).to eq(:failed)
        expect(user.errors.messages.present?).to eq(true)
        expect(user.errors.full_messages.first).to eq("Email can't be blank")
      end
    end

    context 'with invalid email format' do
      it 'should not create user and return error message' do
        @params[:email] = 'wrongemail'
        status, user = Users::Services::Create.run(@params)

        expect(status).to eq(:failed)
        expect(user.errors.messages.present?).to eq(true)
        expect(user.errors.full_messages.first).to eq("Email is invalid")
      end
    end

    context 'with empty full_name' do
      it 'should not create user and return error message' do
        @params[:full_name] = nil
        status, user = Users::Services::Create.run(@params)

        expect(status).to eq(:failed)
        expect(user.errors.messages.present?).to eq(true)
        expect(user.errors.full_messages).to eq(["Full name can't be blank", "Full name is too short (minimum is 3 characters)"])
      end
    end

    context 'name with 2 character' do
      it 'should not create user and return error message' do
        @params[:full_name] = 'Ni'
        status, user = Users::Services::Create.run(@params)

        expect(status).to eq(:failed)
        expect(user.errors.messages.present?).to eq(true)
        expect(user.errors.full_messages).to eq(["Full name is too short (minimum is 3 characters)"])
      end
    end

    context 'name with 52 character' do
      it 'should not create user and return error message' do
        @params[:full_name] = SecureRandom.alphanumeric(52)
        status, user = Users::Services::Create.run(@params)

        expect(status).to eq(:failed)
        expect(user.errors.messages.present?).to eq(true)
        expect(user.errors.full_messages).to eq(["Full name is too long (maximum is 51 characters)"])
      end
    end
  end
end
