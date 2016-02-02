require 'spec_helper'

describe AgileCRMWrapper::Deal do
  let(:deal) { AgileCRMWrapper::Deal.find(123) }

  describe '.all' do
    subject { AgileCRMWrapper::Deal.all }

    it 'should return an array of Deals' do
      expect(subject.map(&:class).uniq).to eq([AgileCRMWrapper::Deal])
    end
  end

  describe '.find' do
    let(:id) { 123 }
    subject { AgileCRMWrapper::Deal.find(id) }

    context 'given an existing deal ID' do
      it { should be_kind_of(AgileCRMWrapper::Deal) }

      its(:id) { should eq id }
    end

    context 'given an unknown deal ID' do
      let(:id) { 0 }
      it { expect { is_expected.to raise_error(AgileCRMWrapper::NotFound) } }
    end
  end

  # describe '.delete' do
  #   context 'given a single ID' do
  #     subject { AgileCRMWrapper::Deal.delete(123) }

  #     its(:status) { should eq 204 }
  #   end
  # end

  # describe '#delete_tags' do
  #   it 'removes the tags' do
  #     expect(
  #       deal.delete_tags(deal.tags)
  #     ).to eq []
  #   end
  # end

  # describe '.search_by_email' do
  #   let(:email) { 'anitadrink@example.com' }
  #   subject { AgileCRMWrapper::Deal.search_by_email(email) }

  #   context 'given an existing email' do
  #     it 'should return a deal with the corresponding email' do
  #       expect(subject.get_property('email')).to eq email
  #     end
  #   end

  #   context 'given an non-existing email' do
  #     let(:email) { 'idontexist@example.com' }

  #     it 'should return an empty array' do
  #       expect(subject).to eq nil
  #     end
  #   end
  # end

  # describe '.search' do
  #   let(:name) { 'Anita' }
  #   subject { AgileCRMWrapper::Deal.search(name) }

  #   it 'should return a deal by matching any field' do
  #     expect(subject[0].get_property('user_name')).to eq name
  #   end
  # end

  describe '#create' do
    subject do
      AgileCRMWrapper::Deal.create(
        name: 'Test Deal',
        description: 'Test Deal description',
        expected_value: "50000",
        milestone: "Won",
        probability: "95",
        close_date: "1349980200",
        contact_ids: ['123'],
        owner_id: '123'
      )
    end

    its(:class) { should eq AgileCRMWrapper::Deal }
  end

  # describe '#create by email' do
  #   subject do
  #     AgileCRMWrapper::Deal.create_by_email(''
  #       name: 'Test Deal',
  #       description: 'Test Deal description',
  #       expected_value: "50000",
  #       milestone: "Won",
  #       probability: "95",
  #       close_date: "1349980200",
  #       contact_ids: ['123'],
  #       owner_id: '123'
  #     )
  #   end

  #   its(:class) { should eq AgileCRMWrapper::Deal }
  # end

  describe '#create by_email' do
    let(:email) { 'anitadrink@example.com' }
    let(:data_params) { {
        name: 'Test Deal',
        description: 'Test Deal description',
        expected_value: "50000",
        milestone: "Won",
        probability: "95",
        close_date: "1349980200",
        contact_ids: ['123'],
        owner_id: '123'}  
      }
    subject { AgileCRMWrapper::Deal.create_by_email(email, data_params) }

    context 'given an existing email' do
      it 'should return a deal with the corresponding email' do
        expect(subject.get_property('email')).to eq email
      end
    end

    context 'given an non-existing email' do
      let(:email) { 'idontexist@example.com' }

      it 'should return an empty array' do
        expect(subject).to eq nil
      end
    end
  end

  # describe '#update' do

  #   it 'updates the receiving deal with the supplied key-value pair(s)' do
  #     expect do
  #       deal.update(first_name: 'Foo!')
  #     end.to change{
  #       deal.get_property('first_name')
  #     }.from('Anita').to('Foo!')
  #   end
  # end

  # describe '#get_property' do
  #   let(:deal) { AgileCRMWrapper::Deal.find(123) }

  #   context 'supplied an existing property name' do
  #     it 'returns the value' do
  #       expect(deal.get_property('email')).to_not be_nil
  #     end
  #   end

  #   context 'supplied a non-existing property name' do
  #     it 'returns nil' do
  #       expect(deal.get_property('nil-propety')).to be_nil
  #     end
  #   end

  #   context 'two properties share the same name' do
  #     it 'returns an array' do
  #       expect(deal.get_property('phone_number').class).to eq(Array)
  #     end
  #   end
  # end

  # describe '#destroy' do
  #   let(:deal) { AgileCRMWrapper::Deal.find(123) }
  #   subject { deal.destroy }

  #   its(:status) { should eq 204 }
  # end
end
