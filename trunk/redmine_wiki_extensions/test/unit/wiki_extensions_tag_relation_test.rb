require File.dirname(__FILE__) + '/../test_helper'

class WikiExtensionsTagRelationTest < Test::Unit::TestCase
  fixtures :wiki_extensions_tag_relations

  # Replace this with your real tests.
  def test_create
    relation = WikiExtensionsTagRelation.new
    assert !relation.save
    
    relation.errors.each{|error|
      #p error
    }

    tag = WikiExtensionsTag.find_or_create(1, 'bbb')
    relation.tag = tag
    relation.wiki_page_id = 1
    assert relation.save

    relation.destroy
  end

  def test_destroy
    tag_name = 'adfafdfadfafdaf'
    tag = WikiExtensionsTag.find_or_create(1, tag_name)
    relation = WikiExtensionsTagRelation.new
    relation.tag = tag
    relation.wiki_page_id = 1
    assert relation.save
    relation_id = relation.id
    tag_id = tag.id
    assert_not_nil(WikiExtensionsTag.find(:first, :conditions => ['name = ?', tag_name]))
    assert_not_nil(WikiExtensionsTagRelation.find(:first, :conditions => ['id = ?', relation_id]))
    relation.destroy
    assert_nil(WikiExtensionsTagRelation.find(:first, :conditions => ['id = ?', relation_id]))
    assert_nil(WikiExtensionsTag.find(:first, :conditions => ['name = ?', tag_name]))
  end
end
