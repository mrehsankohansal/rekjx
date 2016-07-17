do
local function run(msg,matches)
  
if matches[1]:lower() == "get" then
    local file = matches[2]
    if is_sudo(msg) then
      send_document('user#id'..msg.from.id, "cloud/"..file, ok_cb, false)
      else 
        return nil
    end
  end
if matches[1]:lower() == "get>" then 
    if is_sudo(msg) then
      send_document('chat#id'..msg.to.id, "cloud/"..matches[2], ok_cb, false)
      else 
        return nil
    end
  end
if matches[1]:lower() == 'dir' and is_sudo(msg) then
local text = io.popen("cd cloud && ls"):read('*all')
  return text
end
end
return {
  patterns = {
"^([Gg]et) (.*)",
"^([Gg]et>) (.*)",
"^([Dd]ir)",
"%[(document)%]",
"%[(photo)%]",
"%[(video)%]",
"%[(audio)%]"
  },
  run = run
  }
  end