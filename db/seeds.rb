# encoding: utf-8
seed_file = File.join(Rails.root, 'db', 'seed.yml')
config = YAML::load_file(seed_file)


User.create(config["users"])

Entity.create(config["entities"])

District.create(config["districts"])

Municipality.create(config["municipalities"])

Agent.create(config["agents"])

Icd.create(config["icds"])

Laboratory.create(config["laboratories"])

Center.create(config["centers"])

Phi.create(config["phis"])

config["hes"].each do |hes|
  # puts hes["nurse"].inspect
  nurse_id = hes["nurse"] ? User.find_by_uid(hes["nurse"]).id : nil
  center_id = hes["dz"] ? Center.find_by_uid(hes["dz"]).id : nil
  he = {
    "nurse_id" => nurse_id, 
    "name" => hes["name"], 
    "center_id" => center_id, 
    "code" => hes["code"]
  }
  He.create he
end