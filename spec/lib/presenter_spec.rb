# frozen_string_lister

RSpec.describe TableInspector::Presenter do
  let(:model_klass) { User }
  let(:column_name) { 'name' }

  describe "#extract_meta" do
    context "with `sql_type: true` option" do
      context "with `colorize: false`" do
        it "return column definition from column" do
          presenter = described_class.new(model_klass, sql_type: true, colorize: false)
          column = model_klass.columns.find{|column| column.name == column_name }

          expect(presenter.extract_meta(column)) .to eq({"name"=>"name",
                                                         "type"=>"string",
                                                         "limit"=>nil,
                                                         "null"=>true,
                                                         "default"=>nil,
                                                         "precision"=>nil,
                                                         "scale"=>nil,
                                                         "comment"=>nil,
                                                         "sql_type"=>"varchar"})
        end
      end

      context "with `colorize: true`" do
        it "return column definition with color" do
          presenter = described_class.new(model_klass, sql_type: true, colorize: true)
          column = model_klass.columns.find{|column| column.name == column_name}

          expect(presenter.extract_meta(column)).to eq({"name"=>"\e[33mname\e[0m",
                                                        "type"=>"\e[33mstring\e[0m",
                                                        "limit"=>nil,
                                                        "null"=>"\e[32mtrue\e[0m",
                                                        "default"=>nil,
                                                        "precision"=>nil,
                                                        "scale"=>nil,
                                                        "comment"=>nil,
                                                        "sql_type"=>"\e[33mvarchar\e[0m"})
        end
      end
    end

    context "with `sql_type: false` option" do
      context "with `colorize: false`" do
        it "return column definition from column" do
          presenter = described_class.new(model_klass, sql_type: false, colorize: false)
          column = model_klass.columns.find{|column| column.name == column_name }

          expect(presenter.extract_meta(column)) .to eq({"name"=>"name",
                                                         "type"=>"string",
                                                         "limit"=>nil,
                                                         "null"=>true,
                                                         "default"=>nil,
                                                         "precision"=>nil,
                                                         "scale"=>nil,
                                                         "comment"=>nil})
        end
      end
    end
  end

  describe "#headings" do
    context "with option sql_type: true" do
      it 'return ["Name", "Type", "Limit", "Null", "Default", "Precision", "Scale", "Comment", "SqlType"]' do
        presenter = described_class.new(User, sql_type: false)
        expect(presenter.headings).to eq(["Name", "Type", "Limit", "Null", "Default", "Precision", "Scale", "Comment"])
      end
    end

    context "with option sql_type: false" do
      it 'return ["Name", "Type", "Limit", "Null", "Default", "Precision", "Scale", "Comment"]' do
        presenter = described_class.new(User, sql_type: false)
        expect(presenter.headings).to eq(["Name", "Type", "Limit", "Null", "Default", "Precision", "Scale", "Comment"])
      end
    end
  end
end