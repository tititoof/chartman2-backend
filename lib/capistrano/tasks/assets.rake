# frozen_string_literal: true

Rake::Task['deploy:assets:precompile'].clear_actions
Rake::Task['deploy:assets:backup_manifest'].clear_actions
