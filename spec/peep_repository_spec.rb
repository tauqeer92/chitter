require_relative '../lib/user_repository'
require_relative '../lib/peep_repository'
require_relative '../lib/peep'
require_relative '../lib/database_connection'

DatabaseConnection.connect('chitter')

RSpec.describe PeepRepository do
    def reset_peeps_table
        seed_sql = File.read('spec/seeds_peeps.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter', user: 'postgres', password: '12345'}) 
        connection.exec(seed_sql)
    end

    before(:each) do
      reset_peeps_table
    end

    context 'testing all method' do
        it 'testing the length of the array' do
          repo = PeepRepository.new
          all = repo.all
          expect(all.length).to eq 2
        end
        it 'testing the first record in array' do
            repo = PeepRepository.new
            all = repo.all
            expect(all.first.id).to eq '1'
            expect(all.first.subject).to eq 'Exercise'
        end
        it 'testing the second record array' do
            repo = PeepRepository.new
            all = repo.all
            expect(all.last.id).to eq '2'
            expect(all.last.subject).to eq 'Eating Junk'
        end
    end

    context 'testing find method' do
      it 'testing first record' do
        repo = PeepRepository.new
        first = repo.find(1)
        expect(first.id).to eq '1'
        expect(first.subject).to eq 'Exercise'
      end

      it 'testing second record' do
        repo = PeepRepository.new
        first = repo.find(2)
        expect(first.id).to eq '2'
        expect(first.content).to eq 'Do less'
      end
    end

    context 'testing create method' do

      it 'creating new record' do
        repo = PeepRepository.new
        peep = Peep.new
        peep.subject = 'Driving'
        peep.content = 'Driving is fun'
        peep.time = '12:04'
        peep.user_id = '1'
        repo.create(peep)
        third = repo.find(3)
        expect(third.subject).to eq 'Driving'
      end

    end

    # context 'testing delete method' do
    #   it 'deleted first record' do
    #     repo = PeepRepository.new
    #     repo.delete(1)
    #     all = repo.all
    #     expect(all.length).to eq 1
    #   end
    # end
    
end
