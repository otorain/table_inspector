RSpec.describe User, type: :model do
  describe ".ti" do
    context "output table structure" do
      it_behaves_like "output table info without SQL type and colorful scheme", -> { User.ti }
    end

    context "output column structure" do
      it_behaves_like "output column info without SQL type and colorful scheme", -> { User.ti(:name) }
    end
  end

  describe ".ati" do
    context "output table structure" do
      it_behaves_like "output table info without SQL type and with colorful scheme", -> { User.ati }
    end

    context "output column structure" do
      it_behaves_like "output column info without SQL type and with colorful scheme", -> { User.ati(:name) }
    end
  end
end