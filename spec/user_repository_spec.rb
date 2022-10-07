require_relative '../lib/user_repository'
require_relative '../lib/peep_repository'
require_relative '../lib/database_connection'

DatabaseConnection.connect('chitter')

RSpec.describe UserRepository do
    def reset_users_table
        seed_sql = File.read('spec/seeds_users.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter', user: 'postgres', password: '12345'}) 
        connection.exec(seed_sql)
    end

    before(:each) do
      reset_users_table
    end

    context 'testing all method' do
        it 'testing the length of the array' do
          repo = UserRepository.new
          all = repo.all
          expect(all.length).to eq 2
        end
        it 'testing the first record in array' do
            repo = UserRepository.new
            all = repo.all
            expect(all.first.id).to eq '1'
            expect(all.first.name).to eq 'Tauqeer'
        end
        it 'testing the second record array' do
            repo = UserRepository.new
            all = repo.all
            expect(all.last.id).to eq '2'
            expect(all.last.name).to eq 'Adam'
        end
    end

    context 'testing find method' do
      it 'testing first record' do
        repo = UserRepository.new
        first = repo.find(1)
        expect(first.id).to eq '1'
        expect(first.name).to eq 'Tauqeer'
      end
      it 'testing second record' do
        repo = UserRepository.new
        first = repo.find(2)
        expect(first.id).to eq '2'
        expect(first.name).to eq 'Adam'
      end
    end

    context 'testing create method' do
      it 'creating new record' do
        repo = UserRepository.new
        user = User.new
        user.name = 'Bob'
        repo.create(user)
        third = repo.find(3)
        expect(third.name).to eq 'Bob'

    
      end
    end

    # context 'testing delete method' do
    #   it 'deleted first record' do
    #     repo = UserRepository.new
    #     repo.delete(1)
    #     all = repo.all
    #     expect(all.length).to eq 1
    #   end
    # end
end