require "minitest/autorun"

class TestRelations < Minitest::Test
  def setup
    @paul = User.create(name: 'Paul')
    @neeraj = User.create(name: 'Neeraj')
    @jt_project = Project.create(name: 'JT Project')
    @bb_project = Project.create(name: 'BB Project')

    Participation.create(user: @paul,  project: @jt_project, role: :admin)
    Participation.create(user: @paul,  project: @bb_project, role: :user)
    Participation.create(user: @neeraj,  project: @jt_project, role: :user)
    Participation.create(user: @neeraj,  project: @bb_project, role: :admin)
  end

  def teardown
    [Participation, Project, User].map(&:destroy_all)
  end

  def test_jt_admins_ids
    assert_equal @jt_project.admins.ids, [@paul.id]
  end

  def test_bb_users_names
    assert_equal @bb_project.users.pluck(:name), ['Paul']
  end

  def test_count_admins_by_project_id
    admins_by_project_id = Participation.where(role: :admin).group(:project_id).count
    assert_equal admins_by_project_id, { @jt_project.id => 1, @bb_project.id => 1 }
  end

  def test_count_admins_by_project_name
    admins_by_project_name = Participation.where(role: :admin).joins(:project).group('projects.name').count
    assert_equal admins_by_project_name, { 'JT Project' => 1, 'BB Project' => 1 }
  end

end
