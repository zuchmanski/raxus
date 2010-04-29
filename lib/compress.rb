require "rubygems"
require "zip/zip"
require "zip/zipfilesystem"

def compress(files)
  if files.size == 1
    archive = File.join("/tmp", File.basename(files[0] + ".zip"))
  else
    archive = File.join("/tmp", "download.zip")
  end

  FileUtils.rm archive, :force => true

  Zip::ZipFile.open(archive, 'w') do |zip|
    files.each do |file|
      if File.directory? file  
        Dir["#{file}/**/**"].each do |f|
          zip.add(File.join(File.basename(file), f.sub(file + '/', '')), f)
        end
      else
        zip.add(File.basename(file), file)
      end
    end
  end

  archive
end
