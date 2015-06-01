object false
node(:count) { @labels.count }
child(@labels => :labels) do
  attributes :id, :title
end
