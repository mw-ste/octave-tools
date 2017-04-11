function bool = is_octave()
  bool = 0;
  if exist('OCTAVE_VERSION', 'builtin')
    bool = 1;
  end
end