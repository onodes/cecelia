#encoding: utf-8
require 'rspec'
require './lib/cecelia/graph.rb'


describe Graph,"Iniaialize method" do
  it "Graph.new()に空引数" do
    Graph.new.should be_true
  end

  it "Graph.new()にSQLiteを指定" do
    Graph.new("sqlite:hoge.db").should be_true
  end

  after(:each) do
    Sequel::DATABASES.delete(Sequel::DATABASES.first)
  end
end

describe Graph, "ノード追加に関するテスト" do
  let(:g){Graph.new}
  it "空グラフのノード数" do 
    g.vertices.size.should == 0
  end

  it "ノード一つ追加" do
    g.add_vertex("0").should be_true
  end

  it "グラフのノード数確認" do
    g.vertices.size.should == 1
  end

  it "グラフに複数ノード追加" do
    10.times{|i| g.add_vertex(i.to_s)}.should be_true
  end

  it "グラフの複数ノード数確認" do 
    g.vertices.size.should == 10 
  end

  it "同名ノードの追加" do
    10.times{|i|
      g.add_vertex(i.to_s)
    }.should be_true
  end

  it "同名ノードの禁止" do
    g.vertices.size.should == 10
  end

  after(:each) do
    Sequel::DATABASES.delete(Sequel::DATABASES.first)
  end 
end

describe Graph,"エッジの追加に関するテスト" do
  let(:g){Graph.new}
  #before(:all){10.times{|i| g.add_vertex(i.to_s)}}

  it "空グラフのエッジ数" do
    g.edges.size.should == 0
  end

  it "エッジを1本作成" do
    g.add_vertex("1")
    g.add_vertex("2")
    g.add_edge("1","2")
    g.edges.size.should == 1
  end

  it "存在しないノード間エッジは禁止" do
    size = g.vertices.size
    g.add_edge("100","200")
    (g.vertices.size - size).should == 2
  end

  it "複数ノードの追加" do
    10.times{|i|
      g.add_vertex(i.to_s)
    }.should be_true
  end

  it "複数エッジの追加" do
    size = g.edges.size
    g.add_edge("3","4")
    g.add_edge("5","6")
    g.add_edge("6","7")
    g.add_edge("1","6")

    (g.edges.size - size).should == 4
  end

  after(:each) do
      Sequel::DATABASES.delete(Sequel::DATABASES.first)
  end 
end

describe Graph,"ノード削除に関するテスト" do
  let(:g){Graph.new}

  before(:each){
    10.times do |i|
    g.add_vertex(i.to_s)
    end
  }


  it "ノードを1つ削除" do
    size = g.vertices.size
    g.remove_vertex("1")
    (size - g.vertices.size).should == 1
  end

  after(:all) do
    Sequel::DATABASES.delete(Sequel::DATABASES.first)
  end 
end

describe Graph,"エッジ削除に関するテスト" do

  let(:g){Graph.new}

  before(:all){
    10.times do |i|
    g.add_vertex(i.to_s)
    end

  g.add_edge("1","2")
  g.add_edge("3","4")
  g.add_edge("5","6")
  }

  it "エッジを1つ削除" do
    size = g.edges.size
    g.remove_edge("1")
    (size - g.edges.size).should == 1
  end

  after(:all) do
    Sequel::DATABASES.delete(Sequel::DATABASES.first)
  end 
end

describe Graph,"トランザクション関係" do
  let(:g){Graph.new}

  it "トランザクション開いて，ノードを一つ追加" do
    size = g.vertices.size
    g.transaction do |t|
      t.add_vertex("10")
    end
    (g.vertices.size - size).should == 1
  end
end

