f = File.new("test.test", "r")
if f
  content = f.sysread(f.size)
  arr =  content.split(",")
  arr.push("2","3").uniq!
  
  f.reopen("test.test", "w")
  f.syswrite(arr.join(","))
end
f.close

