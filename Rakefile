require 'rake'
require 'erb'


desc "install the dot files into user's home directory - use replace_all=true to replace all files"
task :install do
  install_oh_my_zsh
  install_janus
  switch_to_zsh
  replace_all = ENV['replace_all'] == 'true'
  dotfiles.each do |file|
    system %Q{mkdir -p "$HOME/.#{File.dirname(file)}"} if file =~ /\//
    if File.exist?(dotted_filename(file))
      if File.identical? file, dotted_filename(file)
        puts "identical ~/.#{file.sub(/\.erb$/, '')}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub(/\.erb$/, '')}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file.sub(/\.erb$/, '')}"
        end
      end
    else
      link_file(file)
    end
  end
end

desc "backup all dot files"
task :backup do
  bkp_dir = "backups/backup_#{Time.now.strftime('%Y-%m-d_%H-%M.%L')}"
  puts "Backing up dotfiles to "
  system %Q{mkdir -p "#{bkp_dir}"}
  dotfiles.map {|f| dotted_filename(f)}.each do |file|
    system %Q{cp -r "#{file}" "#{bkp_dir}"} if File.exists?(file)
  end
  puts "Backup complete - `rake install` with confidence!"
end


def dotted_filename(undotted_name)
  File.join(ENV['HOME'], ".#{undotted_name.sub(/\.erb$/, '')}")
end

def dotfiles
  files = Dir['*'] - %w[Rakefile README.md LICENSE oh-my-zsh janus backups]
  files << "oh-my-zsh/custom/plugins/rbates"
  files << "oh-my-zsh/custom/rbates.zsh-theme"
  files << "janus/rbates"
  files
end

def replace_file(file)
  system %Q{rm -rf "$HOME/.#{file.sub(/\.erb$/, '')}"}
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub(/\.erb$/, '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end

def switch_to_zsh
  if ENV["SHELL"] =~ /zsh/
    puts "using zsh"
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
    puts "found ~/.oh-my-zsh"
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

def install_janus
  if File.exists?(File.join(ENV['HOME'], '.vim/janus'))
    system "curl -Lo- https://bit.ly/janus-bootstrap | bash"
  end
end
