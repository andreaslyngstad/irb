class Page < ActiveRecord::Base
  acts_as_textiled :body
  acts_as_nested_set
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :proposed_parent_id
  
  belongs_to :parent, :class_name => "Page", :foreign_key => 'parent_id' 
  after_save :move_to_proposed_parent
  def validate_on_update
    errors.add(:parent_id, "Cannot be the same as the category id") if parent_id == id
    errors.add(:parent_id, "Cannot be one of this categories children") if all_children_ids.include?(parent_id)
  end
  
  def self.find_main
    Page.find(:all, :conditions => ['parent_id IS NULL'], :order => 'lft')
  end
  
  def self.find_subpages
    Page.find(:all, :conditions => ['parent_id'], :order => 'lft')
  end
  
  def all_children_ids
    all_children.map(&:id)
  end
  
  
  
  def available_parents
    if new_record?
      self.class.find(:all, :order => "lft")
    else
      self.class.find(:all, :order => "lft", :conditions => ["id not in(#{[id].concat(all_children_ids).join(",")})"])
    end
  end
  
  def move_to_proposed_parent
    unless proposed_parent_id.to_s == parent_id.to_s
      new_parent = self.class.find_by_id(proposed_parent_id)

      if new_parent.nil?
        self.move_to_right_of(self.class.roots.last)
      else
        unless new_parent.children.last.nil?
          self.move_to_right_of(new_parent.children.last)
        else
          self.move_to_child_of(new_parent)
        end
      end
    end
  end


end
