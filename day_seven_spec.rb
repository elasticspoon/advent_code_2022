require_relative 'day_seven'

RSpec.describe DaySeven do
  let(:computer) { DaySeven.new }

  describe '#populate_directory' do
    it 'adds file to directory' do
      computer.populate_directory('1000 file1')
      file_struct = computer.current_directory.items.join
      expect(file_struct).to eq('- file1 (file, size=1000)')
    end

    it 'adds directory to directory' do
      computer.populate_directory('dir dir1')
      file_struct = computer.current_directory.items.join
      expect(file_struct).to eq('- dir1 (dir)')
    end
  end

  describe '#computer_state' do
    before do
      computer.populate_directory('dir dir1')
      computer.populate_directory('1000 file1')
      computer.change_directory('dir1')
      computer.populate_directory('2000 file1')
      computer.populate_directory('3000 file2')
    end

    it 'returns file structure' do
      expect(computer.computer_state).to eq(
        <<~OUTPUT
          - / (dir)
            - dir1 (dir)
              - file1 (file, size=2000)
              - file2 (file, size=3000)
            - file1 (file, size=1000)
        OUTPUT
                                                    .strip
      )
    end
  end

  describe '#change_directory' do
    it 'changes directory to child' do
      computer.populate_directory('dir dir1')
      computer.change_directory('dir1')
      expect(computer.current_directory.to_s).to eq('- dir1 (dir)')
    end

    it 'changes directory to parent' do
      computer.populate_directory('dir dir1')
      computer.change_directory('dir1')
      computer.change_directory('..')
      expect(computer.current_directory.to_s).to eq(
        <<~OUTPUT
          - / (dir)
            - dir1 (dir)
        OUTPUT
                                                            .strip
      )
    end
  end

  describe '#clean_space' do
    it 'cleans space' do
      computer.build_file_structure(<<~INPUT
        $ cd /
        $ ls
        dir a
        14848514 b.txt
        8504156 c.dat
        dir d
        $ cd a
        $ ls
        dir e
        29116 f
        2557 g
        62596 h.lst
        $ cd e
        $ ls
        584 i
        $ cd ..
        $ cd ..
        $ cd d
        $ ls
        4060174 j
        8033020 d.log
        5626152 d.ext
        7214296 k
      INPUT
                                   )
      expect(computer.clean_space(1_000_000)).to eq(24_933_642)
    end
  end

  describe '#build_file_structure' do
    it 'builds file structure' do
      computer.build_file_structure(<<~INPUT
        $ cd /
        $ ls
        dir a
        14848514 b.txt
        8504156 c.dat
        dir d
        $ cd a
        $ ls
        dir e
        29116 f
        2557 g
        62596 h.lst
        $ cd e
        $ ls
        584 i
        $ cd ..
        $ cd ..
        $ cd d
        $ ls
        4060174 j
        8033020 d.log
        5626152 d.ext
        7214296 k
      INPUT
                                   )
      expect(computer.computer_state).to eq(
        <<~OUTPUT
          - / (dir)
            - a (dir)
              - e (dir)
                - i (file, size=584)
              - f (file, size=29116)
              - g (file, size=2557)
              - h.lst (file, size=62596)
            - b.txt (file, size=14848514)
            - c.dat (file, size=8504156)
            - d (dir)
              - j (file, size=4060174)
              - d.log (file, size=8033020)
              - d.ext (file, size=5626152)
              - k (file, size=7214296)
        OUTPUT
                                                    .strip
      )
    end
  end
end

RSpec.describe FileDirectory do
  let(:directory) { FileDirectory.new('dir1', nil) }

  describe '#size' do
    it 'size of items' do
      directory << ElfFile.new('file1', 1000)
      directory << ElfFile.new('file2', 2000)
      expect(directory.size).to eq(3000)
    end

    it 'size of items and subdirectories' do
      directory << ElfFile.new('file1', 1000)
      directory << ElfFile.new('file2', 2000)
      directory << FileDirectory.new('dir2', directory)
      directory.items.last << ElfFile.new('file3', 3000)
      expect(directory.size).to eq(6000)
    end
  end

  describe '#size_smaller_than' do
    it 'size of items' do
      directory << ElfFile.new('file1', 1000)
      directory << ElfFile.new('file2', 2000)
      expect(directory.size_smaller_than(1500)).to eq(0)
    end

    it 'size of items' do
      directory << ElfFile.new('file1', 1000)
      directory << ElfFile.new('file2', 2000)
      expect(directory.size_smaller_than(4000)).to eq(3000)
    end

    it 'size of items and subdirectories' do
      directory << ElfFile.new('file1', 1000)
      directory << ElfFile.new('file2', 2000)
      directory << FileDirectory.new('dir2', directory)
      directory.items.last << ElfFile.new('file3', 3000)
      expect(directory.size_smaller_than(1500)).to eq(0)
    end

    it 'size of items and subdirectories' do
      directory << ElfFile.new('file1', 1000)
      directory << ElfFile.new('file2', 2000)
      directory << FileDirectory.new('dir2', directory)
      directory.items.last << ElfFile.new('file3', 3000)
      expect(directory.size_smaller_than(3000)).to eq(0)
    end

    it 'size of items and subdirectories' do
      directory << ElfFile.new('file1', 1000)
      directory << ElfFile.new('file2', 2000)
      directory << FileDirectory.new('dir2', directory)
      directory.items.last << ElfFile.new('file3', 3000)
      expect(directory.size_smaller_than(10_000)).to eq(9000)
    end
  end

  describe '#dir_sizes' do
    it 'returns directories with size greater than' do
      directory << ElfFile.new('file1', 1000)
      directory << ElfFile.new('file2', 2000)
      directory << FileDirectory.new('dir2', directory)
      directory.items.last << ElfFile.new('file3', 3000)
      expect(directory.dir_sizes).to eq([6000, 3000])
    end
  end
end
