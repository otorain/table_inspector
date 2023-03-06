# frozen_string_literal: true

RSpec.describe TableInspector::ModelValidator do
  describe "#validate!" do
    let(:normal_class) { TableInspector }
    let(:model_class) { User }

    context "when pass a class which not a model class" do
      let(:validator) { described_class.new(normal_class) }
      it "return false" do
        expect(validator.validate!).to be_falsey
      end

      it "output 'not a model class'" do
        expect do
          validator.validate!
        end.to output(/not a model class/).to_stdout
      end
    end

    context "when pass a model class" do
      it "return true" do
        validator = described_class.new(model_class)
        expect(validator.validate!).to be_truthy
      end
    end
  end
end