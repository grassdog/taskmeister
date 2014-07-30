
Then(/^the double `([^`]*)` should have been run with file "(.*?)"$/) do |cmd, file|
  in_current_dir {
    expect(history).to include [cmd, Pathname.new(file).expand_path.to_s]
  }
end

Then(/^the double `([^`]*)` should have been run with "(.*?)" and file "(.*?)"$/) do |cmd, arg, file|
  in_current_dir {
    expect(history).to include [cmd, arg, Pathname.new(file).expand_path.to_s]
  }
end
