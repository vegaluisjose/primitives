use askama::Template;
use lastmile::vivado::Vivado;

fn main() -> anyhow::Result<()> {
    let vivado = Vivado::new("top", "./some.v")?;
    println!("{}", vivado.render()?);
    Ok(())
}
