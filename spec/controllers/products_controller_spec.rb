require 'rails_helper'

describe ProductsController do
  let(:product) { double(Product, id: 10, name: 'Product 1') }

  shared_examples_for 'product not found' do
    before { allow(Product).to receive(:where).and_return([]) }
    it { expect(response).to be_redirect }
    it { expect(flash[:alert]).to eq('Product not found.') }
  end

  describe '#index' do
    before { get :index }
    it { expect(response).to render_template(:index) }
    it { expect(response).to be_success }
  end

  describe '#new' do
    before { get :new }
    it { expect(response).to render_template(:new) }
    it { expect(response).to be_success }
  end

  describe '#create' do
    before { allow(Product).to receive(:new).and_return(product) }
    context 'saves successfully' do
      before do
        allow(product).to receive(:save).and_return(true)
        post :create, product: { name: product.name }
      end
      it { expect(response).to be_redirect }
      it { expect(flash[:notice]).to eq('Product was successfully created.') }
    end
    context 'saves unsuccesfully' do
      before do
        allow(product).to receive(:save).and_return(false)
        post :create, product: { name: product.name }
      end
      it { expect(response).to be_success }
      it { expect(response).to render_template(:new) }
    end
  end

  describe '#edit' do
    context 'not found' do
      before { get :edit, id: product.id }
      it_behaves_like 'product not found'
    end

    context 'found' do
      before do
        allow(Product).to receive(:where).and_return([product])
        get :edit, id: product.id
      end
      it { expect(response).to be_success }
      it { expect(response).to render_template(:edit) }
    end
  end

  describe '#update' do
    context 'not found' do
      before { patch :update, id: product.id }
      it_behaves_like 'product not found'
    end
    context 'found' do
      before { allow(Product).to receive(:where).and_return([product]) }
      context 'updates successfully' do
        before do
          allow(product).to receive(:update).and_return(true)
          patch :update, id: product.id, product: { name: product.name }
        end
        it { expect(response).to be_redirect }
        it { expect(flash[:notice]).to eq('Product was successfully updated.') }
      end
      context 'updates unsuccesfully' do
        before do
          allow(product).to receive(:update).and_return(false)
          patch :update, id: product.id, product: { name: product.name }
        end
        it { expect(response).to be_success }
        it { expect(response).to render_template(:edit) }
      end
    end
  end

  describe '#show' do
    context 'not found' do
      before { get :show, id: product.id }
      it_behaves_like 'product not found'
    end

    context 'found' do
      before do
        allow(Product).to receive(:where).and_return([product])
        get :show, id: product.id
      end
      it { expect(response).to be_success }
      it { expect(response).to render_template(:show) }
    end
  end

  describe '#destroy' do
    context 'not found' do
      before { delete :destroy, id: product.id }
      it_behaves_like 'product not found'
    end
    context 'found' do
      before do 
        allow(Product).to receive(:where).and_return([product])
        allow(product).to receive(:destroy).and_return(true)
        delete :destroy, id: product.id
      end
      it { expect(response).to be_redirect }
      it { expect(flash[:notice]).to eq('Product was successfully destroyed.') }
    end
  end
end