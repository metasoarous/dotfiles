require 'rake'
require 'erb'
require 'pry'


desc "install the dot files into user's home directory - use replace_all=true to replace all files"
task :install do
  install_oh_my_zsh
  switch_to_zsh
  install_pathogen
  pathogen_plugins do |plugin|
    install_pathogen_plugin plugin
  end
  replace_all = ENV['replace_all'] == 'true'
  dotfiles.each do |file|
    system %Q{mkdir -p "$HOME/.#{File.dirname(file)}"} if file =~ /\//
    if File.exist?(dotted_filename(file))
      if File.identical? file, dotted_filename(file)
        puts "identical ~/.#{file.sub(/\.erb$/, '')}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite #{dotted_filename(file, true)}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping #{dotted_filename(file, true)}"
        end
      end
    else
      link_file(file)
    end
  end
end

desc "backup all dot files"
task :backup do
  bkp_dir = "backups/backup_#{Time.now.strftime('%Y-%m-%d_%H-%M.%S')}"
  puts "Backing up dotfiles to "
  system %Q{mkdir -p "#{bkp_dir}"}
  dotfiles.map {|f| dotted_filename(f)}.each do |file|
    system %Q{cp -r "#{file}" "#{bkp_dir}"} if File.exists?(file)
  end
  puts "Backup complete - `rake install` with confidence!"
end


def dotted_filename(undotted_name, pp=false)
  unerbed = undotted_name.sub(/\.erb$/, '')
  if undotted_name.match /bin\/.?/
    base = unerbed
  else
    base = ".#{unerbed}"
  end
  if pp
    File.join('~', base)
  else
    File.join(ENV['HOME'], base)
  end
end

def dotfiles
  files = Dir['*'] - %w[Rakefile README.md LICENSE oh-my-zsh backups bin pathogen_plugins]
  files += Dir['bin/*']
  files << "oh-my-zsh/custom/plugins/rbates"
  files << "oh-my-zsh/custom/rbates.zsh-theme"
  files
end

def replace_file(file)
  system %Q{rm -rf "#{dotted_filename(file)}"}
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub(/\.erb$/, '')}"
    File.open(dotted_filename(file), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "#{dotted_filename(file)}"}
  end
end

def install_pathogen
  if File.exist?(File.join(ENV['HOME'], '.vim/bundle'))
    puts "Already using pathogen"
  else
    puts "Installing pathogen"
    system %Q{mkdir -p ~/.vim ~/.vim/tmp ~/.vim/autoload ~/.vim/bundle}
    system %Q{curl -Sso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim}
  end
end

def install_pathogen_plugin repo
  name = repo.split('/')[1]
  path = File.join(ENV['HOME'], '.vim/bundle', name)
  if File.exist?(File.join(ENV['HOME'], '.vim/bundle', name))
    puts "    Already using #{name}"
  else
    puts "Installing pathogen plugin #{name}"
    system %Q{git clone git://github.com/#{repo}.git "$HOME/.vim/bundle/#{name}"}
  end
end

def pathogen_plugins
  File.open('pathogen_plugins').each_line do |line|
    yield line.chomp
  end
end

def switch_to_zsh
  if ENV["SHELL"] =~ /zsh/
    puts "Already using zsh"
  else
    print "switch to zsh? (recommended) [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "switching to zsh"
      system %Q{chsh -s `which zsh`}
    when 'q'
      exit
    else
      puts "skipping zsh"
    end
  end
end

def install_oh_my_zsh
  if File.exist?(File.join(ENV['HOME'], ".oh-my-zsh"))
    puts "Already using oh-my-zsh"
  else
    print "install oh-my-zsh? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing oh-my-zsh"
      system %Q{git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"}
    when 'q'
      exit
    else
      puts "skipping oh-my-zsh - you may need to change ~/.zshrc"
    end
  end
end

