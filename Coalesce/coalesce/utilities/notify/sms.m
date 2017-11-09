function sms(number, carrier, subject, message)
%SMS Send SMS text message.
%
% Syntax:
%   sms(number, carrier, subject, message)
%
% Required Input Arguments:
%   number - (CHAR) 10 digit phone number in string form, no dashes.
%   carrier - (CHAR) 'alltel', 'att', 'boost', 'cricket', 'nextel',
%       'sprint', 'tmobile', 'verizon', or 'virgin'.
%   subject - (CHAR) Message subject.
%   message - (CHAR) Message content.
%
% Description:
%   Sends a text message via sms to any US phone number.
%
% Copyright 2013-2014 Mikhail S. Jones

	% Setup email credentials
	emailAddress = '';
	emailPassword = '';

	% Define carrier domain
	switch carrier
	case 'alltel';
		emailTo = strcat(number, '@message.alltel.com');
	case 'att';
		emailTo = strcat(number, '@txt.att.net');
	case 'boost';
		emailTo = strcat(number, '@myboostmobile.com');
	case 'cricket';
		emailTo = strcat(number, '@sms.mycricket.com');
	case 'nextel';
		emailTo = strcat(number, '@messaging.nextel.com');
	case 'sprint';
		emailTo = strcat(number, '@messaging.sprintpcs.com');
	case 'tmobile';
		emailTo = strcat(number, '@tmomail.net');
	case 'verizon';
		emailTo = strcat(number, '@vtext.com');
	case 'virgin';
		emailTo = strcat(number, '@vmobl.com');
	end

	% Set up gmail SMTP service
	setpref('Internet', 'E_mail', emailAddress);
	setpref('Internet', 'SMTP_Server', 'smtp.gmail.com');
	setpref('Internet', 'SMTP_Username', emailAddress);
	setpref('Internet', 'SMTP_Password', emailPassword);

	props = java.lang.System.getProperties;
	props.setProperty('mail.smtp.auth', 'true');
	props.setProperty('mail.smtp.socketFactory.class', ...
		'javax.net.ssl.SSLSocketFactory');
	props.setProperty('mail.smtp.socketFactory.port', '465');

	% Send text message
	sendmail(emailTo, subject, message)
end % sms
