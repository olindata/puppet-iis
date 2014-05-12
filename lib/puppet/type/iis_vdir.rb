require File.join(File.dirname(__FILE__), 'iis/iis_file_system_path_property')

Puppet::Type.newtype(:iis_vdir) do
  @doc = "IIS Virtual Directory"

  ensurable

  newparam(:name) do
    desc "Virtual directory name"

    newvalues(/.+\/.*/)
  end

  newparam(:iis_app) do
    desc "Path of the app the virtual directory is under"

    isrequired
  end

  newproperty(:physicalpath, :parent => Puppet::IisFileSystemPathProperty) do
    desc "Physical path"
  end

  newproperty(:logonmethod, :parent => Puppet::IisProperty) do
    desc "Logon method for the physical path"
  end

  newproperty(:username, :parent => Puppet::IisProperty) do
    desc "User name that can access the physical path"
  end

  newproperty(:password, :parent => Puppet::IisProperty) do
    desc "Password for the user name"
  end

  newproperty(:allowsubdirconfig, :parent => Puppet::IisProperty) do
    desc "Controls whether IIS will load just the Web.config file in the physical path (false) or also the Web.config files in the sub-directories of the physical path (true)"
  end

  autorequire(:iis_site) do
    self[:name].split('/')[0]
  end

  autorequire(:iis_app) do
    self[:iis_app]
  end

  def ensure_trailing_slash(value)
    (value.end_with?('/')) ? value : (value + '/')
  end
end
