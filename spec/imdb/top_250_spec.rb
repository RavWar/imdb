require 'spec_helper'

describe 'Imdb top250', vcr: { cassette_name: 'top250' } do
  before(:each) do
    @movies = Imdb::Movie.top250
  end

  it "should be a list of movies" do
    @movies.each { |movie| movie.should be_an_instance_of(Imdb::Movie) }
  end

  it "should return the top 250 movies from IMDB.com" do
    @movies.size.should == 250
  end

  it "should provide array like access to the movies" do
    @movies.first.title.should eq "The Shawshank Redemption"
  end
end
