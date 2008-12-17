class FillLevels < ActiveRecord::Migration
  def self.up
    Level.create(:name => "Rails fra scratch", :description => "Ruby on rails for nybegynnere.")
    Level.create(:name => "Rails for viderekommende", :description => "Ruby on rails for viderekommende.")
    Level.create(:name => "Profesjonelle railshackere", :description => "Ruby on rails for profesjonelle.")
  end

  def self.down
    Level.delete(:all)
    
  end
end
