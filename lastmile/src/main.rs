use lastmile::profile::Profile;

fn main() -> anyhow::Result<()> {
    let profile = Profile::from_timing_and_utilization("data/timing.rpt", "data/util.rpt")?;
    println!("{:#?}", profile);
    Ok(())
}
