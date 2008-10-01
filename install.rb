unless File.exist?(Bunster::FindBySqlFile::SQL_PATH) &&
       File.directory?(Bunster::FindBySqlFile::SQL_PATH)

  FileUtils.mkdir_p Bunster::FindBySqlFile::SQL_PATH
end