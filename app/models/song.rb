class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
    self.save
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def note_contents=(notes)
    notes.each do |note_content|
      note = Note.create(content: note_content)
      self.notes << note
      self.save
    end
  end

  def note_contents
    self.notes.select{|i| i.content.strip != ''}.map do |note|
      note.content
    end
  end

  def genre_name=(genre)
    self.genre = Genre.find_or_create_by(name: genre)
    self.save
  end

  def genre_name
    self.genre ? self.genre.name : nil
  end

end
