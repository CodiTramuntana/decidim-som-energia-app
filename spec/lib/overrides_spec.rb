# frozen_string_literal: true

require "rails_helper"

# We make sure that the checksum of the file overriden is the same
# as the expected. If this test fails, it means that the overriden
# file should be updated to match any change/bug fix introduced in the core
checksums = [
  {
    package: "decidim-core",
    files: {
      "/app/controllers/decidim/devise/invitations_controller.rb" => "faa5403c358f686a87eea2d9f4eaf1d4",
      "/app/views/layouts/decidim/mailer.html.erb" => "5bbe335c1dfd02f8448af287328a49dc"
    }
  },
  {
    package: "decidim-assemblies",
    files: {
      "/app/views/decidim/assemblies/_filter_by_type.html.erb" => "76988d76b84d96079e6d9e1b252a3fda"
    }
  },
  {
    package: "decidim-proposals",
    files: {
      "/app/controllers/concerns/decidim/proposals/orderable.rb" => "066b6b777567297eefd80020468d4610",
      "/app/controllers/decidim/proposals/proposals_controller.rb" => "793356c0a8dc924d25b1e6bfbcb91621"
    }
  },
  {
    package: "decidim-meetings",
    files: {
      "/app/views/decidim/meetings/registration_mailer/confirmation.html.erb" => "8b1da026a6cada495fa7c1c921e62bee",
      # Meetings natural order, to remove when available as a feature of decidim
      "/app/controllers/decidim/meetings/meetings_controller.rb" => "e8fd8b7006d32781aa89b85559ab86c7"
    }
  },
  {
    package: "decidim-consultations",
    files: {
      # not directly manipulated but worth taking a look if anythign changes
      "/app/controllers/decidim/consultations/consultations_controller.rb" => "3d75aa7d00721dc3d91aca131d348362",
      "/app/controllers/decidim/consultations/questions_controller.rb" => "1b7ec4c7265caccd47f9dc9be08498a9",
      "/app/views/decidim/consultations/consultations/_question.html.erb" => "364d7f8370cdbe7ae70c545fff2e21fa",
      "/app/helpers/decidim/consultations/consultations_helper.rb" => "bb921ed6da446b9544b81c9f9f9a7574"
    }
  },
  {
    package: "decidim-initiatives",
    files: {
      "/app/controllers/decidim/initiatives/initiatives_controller.rb" => "62144c4ad2a96dfae9c8f77e92ab1ee3",
      "/app/mailers/decidim/initiatives/initiatives_mailer.rb" => "435a4110f6bc5c8f37eebc36fae4d444",
      "/app/views/decidim/initiatives/initiatives_mailer/notify_creation.html.erb" => "5ce00a2d62b52b098bb8464e5bf5e16a",
      "/app/views/decidim/initiatives/initiatives_mailer/notify_state_change.html.erb" => "6472242f33e29183e08c2caefd5d6067"
    }
  },
  {
    package: "decidim-admin",
    files: {

      "/app/jobs/decidim/admin/import_participatory_space_private_user_csv_job.rb" => "009725677f2ca25c6a8c32270c21fca3",
      "/app/commands/decidim/admin/process_participatory_space_private_user_import_csv.rb" => "06cafc1c6bd098bf30c8fba9f3a12a4d",
      "/app/commands/decidim/admin/create_participatory_space_private_user.rb" => "3218d35c8bbc77abfbbc56ba1d2bf427",
      "/app/controllers/decidim/admin/concerns/has_private_users_csv_import.rb" => "5e6f74f827fc3d0d485cfeec7ecb43e3",
      "/app/forms/decidim/admin/participatory_space_private_user_form.rb" => "3479f27dcc88f98267374490b446b24c",
      "/app/forms/decidim/admin/participatory_space_private_user_csv_import_form.rb" => "f93e15ec32dbb59a0989b27641356075",
      # views
      "/app/views/decidim/admin/participatory_space_private_users/_form.html.erb" => "be3e6ce2ae14caee518d0def6091c9e0",
      "/app/views/decidim/admin/participatory_space_private_users/index.html.erb" => "9b23dffda10546025aa467a3628b2184"
    }
  }
]

describe "Overriden files", type: :view do
  # rubocop:disable Rails/DynamicFindBy
  checksums.each do |item|
    spec = ::Gem::Specification.find_by_name(item[:package])

    item[:files].each do |file, signature|
      it "#{spec.gem_dir}#{file} matches checksum" do
        expect(md5("#{spec.gem_dir}#{file}")).to eq(signature)
      end
    end
  end
  # rubocop:enable Rails/DynamicFindBy

  private

  def md5(file)
    Digest::MD5.hexdigest(File.read(file))
  end
end
