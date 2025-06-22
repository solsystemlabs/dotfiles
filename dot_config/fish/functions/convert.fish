function convert -d "Convert files using ffmpeg"
  # use argparse when necessary eventually
  argparse s/source d/destination f/framerate -- $argv
  or return

    #  if count($argv) < 2
    #    echo "provide a source and a destination"
    #    return
    #  end

  if not set -ql _flag_s
    echo "source must be set with -s or --source"
    return
  end 

  if not set -ql _flag_d
    echo 'destination must be set with -d or --destination'
  end

  if not set -ql _flag_f
    set _flag_f 30
  end

  #  ffmpeg -i $_flag_s -crf $_flag_f $_flag_d
  echo $_flag_s 
  echo $_flag_d
  echo $_flag_f
end
