{ flavor, ... }:
{
  vim.options = {
    tabstop = if flavor == "dev" then 12 else 10;
  };
}
