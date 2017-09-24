require 'pry'
class MusicLibraryController
attr_accessor :path

  def initialize(path = './db/mp3s')
    @path = path
    new_imp = MusicImporter.new(path)
    new_imp.import
  end

  def call
    answer = ""
    while answer != "exit"
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    answer = gets.strip


    case answer
    when "list songs"
      list_songs
    when "list artists"
      list_artists
    when "list genres"
      list_genres
    when "list artist"
      list_songs_by_artist
    when "list genre"
      list_songs_by_genre
    when "play song"
      play_song
    end
    end
  end


  def list_songs
    Song.all.sort {|x, y| x.name <=> y.name}.each_with_index do |x,i|
      # x.name, i+2
      puts "#{i+1}. #{x.artist.name} - #{x.name} - #{x.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort {|x, y| x.name <=> y.name}.each_with_index do |x,i|
      puts "#{i+1}. #{x.name}"
    end
  end

def list_genres
  Genre.all.sort {|x, y| x.name <=> y.name}.each_with_index do |x,i|
    puts "#{i+1}. #{x.name}"
  end
end

def list_songs_by_artist
  puts "Please enter the name of an artist:"
  answer = gets.chomp
  # artist = Artist.new(answer.capitalize)
  if artist = Artist.find_by_name(answer)
  artist.songs.sort {|x, y| x.name <=> y.name}.each_with_index do |x,i|
    puts "#{i+1}. #{x.name} - #{x.genre.name}"
  end
end
end

def list_songs_by_genre
  puts "Please enter the name of a genre:"
  answer = gets.chomp
  if genre = Genre.find_by_name(answer)
  genre.songs.sort {|x, y| x.name <=> y.name}.each_with_index do |x,i|
    puts "#{i+1}. #{x.artist.name} - #{x.name}"
  end
end
end

def play_song
  puts "Which song number would you like to play?"
  # list_songs
  answer = gets.strip.to_i
  if (1..Song.all.length).include?(answer)
    song = Song.all.sort{ |a, b| a.name <=> b.name }[answer - 1]
    # puts "Playing #{song.name} by #{song.artist.name}"
  end
        puts "Playing #{song.name} by #{song.artist.name}" if song
end

end
