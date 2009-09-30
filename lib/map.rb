module SpriteJam
  class Map
     attr_accessor :contents
     def initialize(map_file)
       @contents = File.readlines(map_file).map{|text| text.chop}
     end

     def contents_size
       @contents.size
     end

     def index_header
       @contents.index("[map]")
     end

     def info_header
       @contents.index("[info]")
     end

     def tiles_header
       @contents.index("[tiles]")
     end

     def tile_codes
       @contents[tiles_header + 1, index_header - 4]
     end
     
     def tile_size
       @contents[info_header + 1].to_i
     end
     
     def ascii_tiles
      @contents[index_header + 1, contents_size]
     end
     
     def width
       ascii_tiles[0].length
     end
     
     def height
       ascii_tiles.size
     end
     
     def boundary_for(opts)
       action = ((opts[:coord] == :y) ? height : width)
       ((action * tile_size) - opts[:viewport]) / tile_size
     end
     
     def filename
       @contents[info_header + 2]
     end
   end
end
