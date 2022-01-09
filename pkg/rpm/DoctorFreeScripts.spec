Name: DoctorFreeScripts
Version:    %{_version}
Release:    %{_release}
Summary:    DoctorFreeScripts suite of tools
License:    MIT
BuildArch:  noarch
URL:        https://gitlab.com/doctorfree/DoctorFreeScripts
Vendor:     Doctorwhen's Bodacious Laboratory
Packager:   ronaldrecord@gmail.com

%description
Utility Bash shell scripts

%prep

%build

%install
cp -a %{_sourcedir}/usr %{buildroot}/usr

%files
/usr

%post
[ -x /usr/local/DoctorFreeScripts/etc/postinstall ] && /usr/local/DoctorFreeScripts/etc/postinstall

%preun
[ -x /usr/local/DoctorFreeScripts/etc/preremove ] && /usr/local/DoctorFreeScripts/etc/preremove

%files
/usr

%changelog
