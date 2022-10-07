# typed: strict

# For String#camelize
require 'active_support/core_ext/string/inflections'
require 'rubocop/cop/modularization/namespaced_under_package_name/desired_zeitwerk_api'

module RuboCop
  module Cop
    module Modularization
      # This cop helps ensure that each pack exposes one namespace.
      #
      # @example
      #
      #   # bad
      #   # packs/foo/app/services/blah/bar.rb
      #   class Blah::Bar; end
      #
      #   # good
      #   # packs/foo/app/services/foo/blah/bar.rb
      #   class Foo::Blah::Bar; end
      #
      class NamespacedUnderPackageName < Base
        extend T::Sig

        include RangeHelp

        sig { void }
        def on_new_investigation
          absolute_filepath = Pathname.new(processed_source.file_path)
          relative_filepath = absolute_filepath.relative_path_from(Pathname.pwd)
          relative_filename = relative_filepath.to_s

          # This cop only works for files ruby files in `app`
          return if !relative_filename.include?('app/') || relative_filepath.extname != '.rb'

          relative_filename = relative_filepath.to_s
          package_for_path = ParsePackwerk.package_from_path(relative_filename)
          return if package_for_path.nil?

          namespace_context = desired_zeitwerk_api.for_file(relative_filename, package_for_path)
          return if namespace_context.nil?

          allowed_global_namespaces = Set.new([
                                                namespace_context.expected_namespace,
                                                *cop_config['GloballyPermittedNamespaces']
                                              ])

          package_name = package_for_path.name
          actual_namespace = namespace_context.current_namespace

          if allowed_global_namespaces.include?(actual_namespace)
            # No problem!
          else
            package_enforces_namespaces = cop_config['IncludePacks'].include?(package_for_path.name)
            expected_namespace = namespace_context.expected_namespace
            relative_desired_path = namespace_context.expected_filepath
            pack_owning_this_namespace = namespaces_to_packs[actual_namespace]

            if package_enforces_namespaces
              add_offense(
                source_range(processed_source.buffer, 1, 0),
                message: format(
                  '`%<package_name>s` prevents modules/classes that are not submodules of the package namespace. Should be namespaced under `%<expected_namespace>s` with path `%<expected_path>s`. See https://go/packwerk_cheatsheet_namespaces for more info.',
                  package_name: package_name,
                  expected_namespace: expected_namespace,
                  expected_path: relative_desired_path
                )
              )
            elsif pack_owning_this_namespace
              add_offense(
                source_range(processed_source.buffer, 1, 0),
                message: format(
                  '`%<pack_owning_this_namespace>s` prevents other packs from sitting in the `%<actual_namespace>s` namespace. This should be namespaced under `%<expected_namespace>s` with path `%<expected_path>s`. See https://go/packwerk_cheatsheet_namespaces for more info.',
                  package_name: package_name,
                  pack_owning_this_namespace: pack_owning_this_namespace,
                  expected_namespace: expected_namespace,
                  actual_namespace: actual_namespace,
                  expected_path: relative_desired_path
                )
              )
            end
          end
        end

        # In the future, we'd love this to support auto-correct.
        # Perhaps by automatically renamespacing the file and changing its location?
        sig { returns(T::Boolean) }
        def support_autocorrect?
          false
        end

        private

        sig { returns(DesiredZeitwerkApi) }
        def desired_zeitwerk_api
          @desired_zeitwerk_api ||= T.let(nil, T.nilable(DesiredZeitwerkApi))
          @desired_zeitwerk_api ||= DesiredZeitwerkApi.new
        end

        sig { returns(T::Hash[String, String]) }
        def namespaces_to_packs
          @namespaces_to_packs = T.let(nil, T.nilable(T::Hash[String, String]))
          @namespaces_to_packs ||= begin
            all_packs_enforcing_namespaces = ParsePackwerk.all.select do |p|
              cop_config['IncludePacks'].include?(p.name)
            end

            namespaces_to_packs = {}
            all_packs_enforcing_namespaces.each do |package|
              namespaces_to_packs[desired_zeitwerk_api.get_pack_based_namespace(package)] = package.name
            end

            namespaces_to_packs
          end
        end
      end
    end
  end
end