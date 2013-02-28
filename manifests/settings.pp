# our filebucket
filebucket{'server':
  path => false,
}

# file type defaults
File{
  # don't backup files
  backup => false,
  # don't distribute version control metadata
  ignore => [ '.svn', '.git', 'CVS', '.ignore' ],
}

# set default path
Exec{
  path => "/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin",
}

# run stages
stage{'pre':
  before => Stage['main'],
}
class{'yum':
  stage => pre,
}
