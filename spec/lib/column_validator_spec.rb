
RSpec.describe TableInspector::ColumnValidator do
  describe "#validate!" do
    let(:model_class) { User }
    let(:column_name) { "name" }
    let(:column_name_that_not_exists) { "name1" }

    context "pass column_name that exists in table of model" do
      let(:validator) { described_class.new(model_class, column_name_that_not_exists) }

      it "return false" do
        expect(validator.validate!)
      end

      it "output" do
        expect do
          validator.validate!
        end.to output(/doesn't exist in table/).to_stdout
      end
    end

    context "pass column_name that does not exists in table of model" do
      it "return true" do
        validator = described_class.new(model_class, column_name)
        expect(validator.validate!).to be_truthy
      end
    end
  end
end