# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `rubocop-extension-generator` gem.
# Please instead update this file by running `bin/tapioca gem rubocop-extension-generator`.

# source://rubocop-extension-generator//lib/rubocop/extension/generator/version.rb#1
module RuboCop; end

# source://rubocop-extension-generator//lib/rubocop/extension/generator/version.rb#2
module RuboCop::Extension; end

# source://rubocop-extension-generator//lib/rubocop/extension/generator/version.rb#3
module RuboCop::Extension::Generator; end

# source://rubocop-extension-generator//lib/rubocop/extension/generator/cli.rb#4
class RuboCop::Extension::Generator::CLI
  # @return [CLI] a new instance of CLI
  #
  # source://rubocop-extension-generator//lib/rubocop/extension/generator/cli.rb#15
  def initialize(argv); end

  # source://rubocop-extension-generator//lib/rubocop/extension/generator/cli.rb#19
  def run; end

  private

  # source://rubocop-extension-generator//lib/rubocop/extension/generator/cli.rb#32
  def fail!(opt); end

  class << self
    # source://rubocop-extension-generator//lib/rubocop/extension/generator/cli.rb#11
    def run(argv); end
  end
end

# source://rubocop-extension-generator//lib/rubocop/extension/generator/cli.rb#5
RuboCop::Extension::Generator::CLI::BANNER = T.let(T.unsafe(nil), String)

# source://rubocop-extension-generator//lib/rubocop/extension/generator/generator.rb#4
class RuboCop::Extension::Generator::Generator
  # @return [Generator] a new instance of Generator
  #
  # source://rubocop-extension-generator//lib/rubocop/extension/generator/generator.rb#5
  def initialize(name); end

  # source://rubocop-extension-generator//lib/rubocop/extension/generator/generator.rb#9
  def generate; end

  private

  # source://rubocop-extension-generator//lib/rubocop/extension/generator/generator.rb#178
  def classname; end

  # source://rubocop-extension-generator//lib/rubocop/extension/generator/generator.rb#182
  def cops_file_name; end

  # source://rubocop-extension-generator//lib/rubocop/extension/generator/generator.rb#174
  def dirname; end

  # Returns the value of attribute name.
  #
  # source://rubocop-extension-generator//lib/rubocop/extension/generator/generator.rb#186
  def name; end

  # source://rubocop-extension-generator//lib/rubocop/extension/generator/generator.rb#162
  def patch(path, pattern, replacement); end

  # source://rubocop-extension-generator//lib/rubocop/extension/generator/generator.rb#155
  def put(path, content); end

  # source://rubocop-extension-generator//lib/rubocop/extension/generator/generator.rb#170
  def root_path; end
end

# source://rubocop-extension-generator//lib/rubocop/extension/generator/version.rb#4
RuboCop::Extension::Generator::VERSION = T.let(T.unsafe(nil), String)

# source://rubocop/1.36.0/lib/rubocop/ast_aliases.rb#5
RuboCop::NodePattern = RuboCop::AST::NodePattern

# source://rubocop/1.36.0/lib/rubocop/ast_aliases.rb#6
RuboCop::ProcessedSource = RuboCop::AST::ProcessedSource

# source://rubocop/1.36.0/lib/rubocop/ast_aliases.rb#7
RuboCop::Token = RuboCop::AST::Token
