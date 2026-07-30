


local label = noctalia.getConfig("label")

-- On click, we want to change the 
function onClick()
  clicks += 1
  noctalia.notify(noctalia.tr("title"), noctalia.trp("clicks", clicks))
  render()
end


