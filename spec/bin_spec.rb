describe "bin/git-fame" do
  it "should include the authors name" do
    run("--help").should include_output("Linus Oleander")
  end

  it "should include the the current version" do
    run("--version").should include_output(GitFame::VERSION)
  end

  it "should fail on invalid option" do
    run("--nope").should_not be_a_succees
  end

  it "should not accept a non-existent repository" do
    run("--repository=??").should_not be_a_succees
  end

  [
    "--sort=name",
    "--sort=commits",
    "--sort=loc",
    "--progressbar=0",
    "--progressbar=1",
    "--whitespace",
    "--bytype",
    "--include=hello",
    "--exclude=hello",
    "--extension=rb,ln",
    "--branch=master",
    "--format=csv",
    "--format=pretty",
    "--before=2010-01-01",
    "--after=1980-01-01",
    "--version",
    "--help"
  ].each do |option|
    it "should support #{option}" do
      run(option).should be_a_succees
    end
  end

  it "should sort by loc by default" do
    run("--sort=loc", "--progressbar=0").first.should eq(run("--progressbar=0").first)
  end

  it "should fail on invalid before date" do
    res = run("--before='---'")
    res.should_not be_a_succees
    res.first.should eq("Error: '---' is not a valid date\n")
  end

  it "should fail on invalid after date" do
    res = run("--after='---'")
    res.should_not be_a_succees
    res.first.should eq("Error: '---' is not a valid date\n")
  end
end