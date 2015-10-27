require 'spec_helper'

describe "Imdb search", vcr: { cassette_name: 'search' } do
  before(:each) do
    @search = Imdb::Movie.search("Star Trek: TOS")
  end

  it "should find 37 results" do
    @search.size.should eql(37)
  end

  it "should not return movies with no title" do
    @search.each {|movie| movie.title.should_not be_empty }
  end

  it "should return only the title of the result" do
    @search.first.title.should eql("Star Trek")
  end

  describe "with an exact match" do
    before(:each) do
      @search = Imdb::Movie.search("The Coexist Comedy Tour")
    end

    it "should find one result" do
      @search.size.should eql(1)
    end

    it "should have the corrected title" do
      @search.first.title.should =~ /The Coexist Comedy Tour/i
    end
  end

  describe "with an exact match and no poster" do
    it "should not raise an exception" do
      lambda {
        @search = Imdb::Movie.search("Kannethirey Thondrinal")
      }.should_not raise_error
    end

    it "should return the movie id correctly" do
      @search = Imdb::Movie.search("Kannethirey Thondrinal")
      @search.first.id.should eql("0330508")
    end
  end
end
