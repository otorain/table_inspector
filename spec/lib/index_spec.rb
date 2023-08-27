
RSpec.describe TableInspector::Indexes do
  let(:model) { User }
  let(:column_name) { :name }

  context "with specific column" do
    context "with colorize" do
      it "output indexes info with highlighted column" do
        expect do
          described_class.new(model, :name, colorize: true).render
        end.to output(/\e\[33mname/).to_stdout
      end
    end

    context "without colorize" do
      it "output indexes info without highlighted column" do
        expect do
          described_class.new(model, :name, colorize: false).render
        end.not_to output(/\e\[33mname/).to_stdout
      end
    end
  end

  context "without specific column" do
    context "table which has no index" do
      it "output 'Empty' in index table" do
        expectation = expect { described_class.new(Post).render }
        expectation.to output(/.*Empty\./).to_stdout
      end
    end

    context "with colorize" do
      it "output indexes info with highlighted column" do
        expect do
          described_class.new(model, colorize: true).render
        end.to output(/\e\[33mname/).to_stdout
      end
    end

    context "without colorize" do
      it "output indexes info without highlighted column" do
        expect do
          described_class.new(model, colorize: false).render
        end.not_to output(/\e\[33mname/).to_stdout
      end
    end
  end
end