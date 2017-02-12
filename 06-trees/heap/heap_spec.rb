include RSpec

require_relative 'heap'

RSpec.describe Heap, type: Class do
  let (:root) { Node.new("The Matrix", 87) }

  let (:tree) { Heap.new(root) }
  let (:pacific_rim) { Node.new("Pacific Rim", 72) }
  let (:braveheart) { Node.new("Braveheart", 78) }
  let (:jedi) { Node.new("Star Wars: Return of the Jedi", 80) }
  let (:donnie) { Node.new("Donnie Darko", 85) }
  let (:inception) { Node.new("Inception", 86) }
  let (:district) { Node.new("District 9", 90) }
  let (:shawshank) { Node.new("The Shawshank Redemption", 91) }
  let (:martian) { Node.new("The Martian", 92) }
  let (:hope) { Node.new("Star Wars: A New Hope", 93) }
  let (:empire) { Node.new("Star Wars: The Empire Strikes Back", 94) }
  let (:mad_max_2) { Node.new("Mad Max 2: The Road Warrior", 98) }

  describe "#insert(data)" do
    it "properly inserts a new node as lower value left child" do
      tree.insert(root, district)
      expect(root.left.title).to eq "District 9"
    end

    it "properly inserts a new node as higher value right child" do
      tree.insert(root, shawshank)
      tree.insert(root, empire)
      expect(root.right.title).to eq "Star Wars: The Empire Strikes Back"
    end

    it "properly inserts a new node as a lower value root" do
      tree.insert(root, jedi)
      tree.insert(root, pacific_rim)
      expect(root.title).to eq "Pacific Rim"
    end
  end

  describe "#find(data)" do
    it "handles nil gracefully" do
      tree.insert(root, empire)
      tree.insert(root, mad_max_2)
      expect(tree.find(root, nil)).to eq nil
    end
    #
    # it "properly finds a left node" do
    #   tree.insert(root, pacific_rim)
    #   expect(tree.find(root, pacific_rim.title).title).to eq "Pacific Rim"
    # end
    #
    # it "properly finds a left-left node" do
    #   tree.insert(root, braveheart)
    #   tree.insert(root, pacific_rim)
    #   expect(tree.find(root, pacific_rim.title).title).to eq "Pacific Rim"
    # end
  end

  describe "#delete(data)" do
    it "handles nil gracefully" do
      expect(tree.delete(root, nil)).to eq nil
    end
    #
    # it "properly deletes a left node" do
    #   tree.insert(root, hope)
    #   tree.delete(root, hope.title)
    #   expect(tree.find(root, hope.title)).to be_nil
    # end
    #
    # it "properly deletes a left-left node" do
    #   tree.insert(root, braveheart)
    #   tree.insert(root, pacific_rim)
    #   tree.delete(root, pacific_rim.title)
    #   expect(tree.find(root, pacific_rim.title)).to be_nil
    # end
  end

  describe "#printf" do
    #  specify {
    #    expected_output = "Mad Max 2: The Road Warrior: 98\nStar Wars: The Empire Strikes Back: 94\nStar Wars: A New Hope: 93\nThe Shawshank Redemption: 91\nThe Martian: 92\nPacific Rim: 72\nInception: 86\nBraveheart: 78\nStar Wars: Return of the Jedi: 80\nThe Matrix: 87\nDistrict 9: 90\n"
    #    tree.insert(root, hope)
    #    tree.insert(root, empire)
    #    tree.insert(root, jedi)
    #    tree.insert(root, martian)
    #    tree.insert(root, pacific_rim)
    #    tree.insert(root, inception)
    #    tree.insert(root, braveheart)
    #    tree.insert(root, shawshank)
    #    tree.insert(root, district)
    #    tree.insert(root, mad_max_2)
    #    expect { tree.printf }.to output(expected_output).to_stdout
    #  }
     #
    #  specify {
    #    expected_output = "Mad Max 2: The Road Warrior: 98\nStar Wars: The Empire Strikes Back: 94\nDistrict 9: 90\nThe Shawshank Redemption: 91\nStar Wars: A New Hope: 93\nInception: 86\nPacific Rim: 72\nThe Matrix: 87\nStar Wars: Return of the Jedi: 80\nBraveheart: 78\nThe Martian: 92\n"
    #    tree.insert(root, mad_max_2)
    #    tree.insert(root, district)
    #    tree.insert(root, shawshank)
    #    tree.insert(root, braveheart)
    #    tree.insert(root, inception)
    #    tree.insert(root, pacific_rim)
    #    tree.insert(root, martian)
    #    tree.insert(root, jedi)
    #    tree.insert(root, empire)
    #    tree.insert(root, hope)
    #    expect { tree.printf }.to output(expected_output).to_stdout
    #  }
  end
end
