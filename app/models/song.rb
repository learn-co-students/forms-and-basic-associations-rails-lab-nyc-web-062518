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
    self.notes.map do |note|
      if note.content.strip != "" && note.content != nil
      note.content
      end
    end
  end

end
