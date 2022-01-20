Name: DoctorFreeScripts
Version:    %{_version}
Release:    %{_release}
Summary:    DoctorFreeScripts suite of tools
License:    MIT
BuildArch:  noarch
URL:        https://gitlab.com/doctorfree/DoctorFreeScripts
Vendor:     Doctorwhen's Bodacious Laboratory
Packager:   ronaldrecord@gmail.com

%global __os_install_post %{nil}

%description
Utility Bash shell scripts

%prep

%build

%install
cp -a %{_sourcedir}/usr %{buildroot}/usr

%post
exec 1>/proc/${PPID}/fd/1
exec 2>/proc/${PPID}/fd/2
[ -x /usr/local/DoctorFreeScripts/etc/postinstall ] && /usr/local/DoctorFreeScripts/etc/postinstall

%preun
exec 1>/proc/${PPID}/fd/1
exec 2>/proc/${PPID}/fd/2
[ -x /usr/local/DoctorFreeScripts/etc/preremove ] && /usr/local/DoctorFreeScripts/etc/preremove

%files
/usr/local/DoctorFreeScripts
/usr/local/share/doc/doctorfree-scripts
/usr/local/share/applications/*
/usr/local/share/bash/*
/usr/local/share/images/*
/usr/local/share/man/man*/*

%changelog
