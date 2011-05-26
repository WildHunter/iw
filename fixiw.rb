require 'rubygems'  # not necessary for Ruby 1.9
require 'mongo'

db = Mongo::Connection.new.db("islamworld")

r = db["resources"]
t = db["tags"]
tr = db["tags_resources"]


r.find().each { |row|
	tags = Array.new
	tr.find("resource_id" => row["id"]).each { |x| tags << x["tag_id"] }
	#r.update({:_id => row[:id]}, '$set' => { :tags => {}})
	tagA = Array.new
	tags.each { |tagid| 
		tag = t.find_one("id" => tagid)
		tagA << {"name" => tag["name"],"index_order" => tag["index_order"], "longname" => tag["longname"]} 
	}
	row[:tags] = tagA
	r.save(row)
	#puts row.inspect
}

#my_doc = r.find_one()
#puts my_doc.inspect
