# rubocop:disable Metrics/BlockLength
Sequel.migration do
  up do
    # SQLite's INTEGER type already supports 64-bit integers, skip for SQLite
    # database_type returns the database adapter type (e.g., :sqlite, :postgres, :mysql)
    unless database_type.to_s.include?('sqlite')
      alter_table(:repositories) do
        set_column_type :id, :bigint
      end

      alter_table(:users) do
        set_column_type :id, :bigint
      end

      alter_table(:hosts) do
        set_column_type :id, :bigint
      end

      alter_table(:authentication_tokens) do
        set_column_type :id, :bigint
        set_column_type :user_id, :bigint
      end

      alter_table(:repositories_users) do
        set_column_type :repository_id, :bigint
        set_column_type :user_id, :bigint
      end

      alter_table(:hosts_repositories) do
        set_column_type :host_id, :bigint
        set_column_type :repository_id, :bigint
      end
    end
  end

  down do
    # SQLite's INTEGER type already supports 64-bit integers, skip for SQLite
    # database_type returns the database adapter type (e.g., :sqlite, :postgres, :mysql)
    unless database_type.to_s.include?('sqlite')
      alter_table(:hosts_repositories) do
        set_column_type :host_id, :integer
        set_column_type :repository_id, :integer
      end

      alter_table(:repositories_users) do
        set_column_type :repository_id, :integer
        set_column_type :user_id, :integer
      end

      alter_table(:authentication_tokens) do
        set_column_type :user_id, :integer
        set_column_type :id, :integer
      end

      alter_table(:hosts) do
        set_column_type :id, :integer
      end

      alter_table(:users) do
        set_column_type :id, :integer
      end

      alter_table(:repositories) do
        set_column_type :id, :integer
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
