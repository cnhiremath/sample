#!/usr/bin/env perl

#----------------------------------------------------------------------------
#
# sealoearth.pl
#
#
# SYNTAX: 	Volunteer.pl 
#
# Chaitanya N. Hiremath
# Jan 14, 2012
#
# Copyright 2011  All rights reserved. 
#
#--------------------
#
# Version History
#
# v 0.0	  Brand new working script                        CNH    01/14/2012
# v 0.1	  Added the usuage()                              CNH    03/09/2014
# v 0.2	  Modified for volunteer information              CNH    05/18/2014
# v 0.3	  Modified for new website		          CNH    09/01/2020
#
#----------------------------------------------------------------------------

require 5.000;	# This is a perl 5.0 script

use Getopt::Std;
use CGI;
use CGI qw/:standard/;

my $debug = undef;
  #$debug = "on";        # For debugging only

my %global = ();

print "Content-type: text/html\n\n";

main();

exit(0);


#--------------------
# Main
#--------------------

sub main {
  
  my %feedback = ();
  
  %global = getglobal();

  my $q = new CGI;
  
  # Get the input
  $feedback{'resp'}     = $q->param('resp');
  $feedback{'name'}     = $q->param('name');
  $feedback{'email'}    = $q->param('email');
  $feedback{'address'}  = $q->param('address');
  $feedback{'city'}     = $q->param('city');
  $feedback{'country'}  = $q->param('country');
  $feedback{'phone'}    = $q->param('phone');
  $feedback{'hours'}    = $q->param('hours');
  $feedback{'project'}  = $q->param('project');
  $feedback{'duration'} = $q->param('duration');

  $feedback{'service'}  = $q->param('service');
  $feedback{'code1'} = $q->param('code1');
  $feedback{'code2'} = $q->param('code2');
  
  # Sanity check
  my $valid = 0;
     $valid = 1 if ($feedback{code1} == $feedback{code2});
  
 #my $notify = sanitycheck(\%feedback);
  
  # Flow
  # Step 1
  my $step1 = 0;
     $step1 = 1 if (defined $feedback{resp});
     
  # Step 2
  my $step2 = 0;
    #$step2 = 1 if (defined $code);
     
  my $form1 = "";
  my $form2 = "";  
 
 #$valid =1; #temp only 
  if ( (($valid) && ($step1)) || ($step2) ) {
  
    if ($step1) {
      $form2 = deliver(\%feedback);
      display2($form2);  
    }
    
    if ($step2) {
      #display3(\%feedback);         
    }
    
  } else { # valid
    $form1 = setfeedbackform();
    display1($form1);
  } # valid

} # main


#--------------------
# Get/Set global values
#--------------------

sub getglobal {

  # CHANGE THESE VALUES AT YOUR OWN PERIL

  # Program name
  $global{'program'} = getprogram();
    
  return %global;

} # getglobal


#--------------------
# Header
#--------------------

sub header {
 
  my $header = q(
    <html>
    <head> 
      <Title>
        SEALOEarth - Serene Environment And Life On Earth
      </title>
      
      <meta name="robots" content="noindex, nofollow" />
      <meta name="googlebot" content="noindex">
      <meta name="Slurp" content="noindex"> 
 
 
      <style>body,table{font-family: arial,sans-serif; font-size: 15px;}</style>

      <STYLE TYPE="text/css">
        <!--
	  A {text-decoration:none}
	  -->
       </STYLE> 
	 
    </head>

      <center>
         <img src="../art/SEALOEarth_(c)2011_DrChaitanyaHiremath.jpg" width="530" alt="SEALOEarth_(c)2011_DrChaitanyaHiremath"/>
      </center>
 
    <body>
    
      <table style="font-size:100%" width="100%" border="5" cellpadding=5 bordercolor="#99ccff" bordercolorlight="#99ccff" bordercolordark="#0066ff" bgcolor="#ffffcc">

        <tr bgcolor="#ffffcc">
          <td width="9%" align="center"> <b> ABOUT </b> </td>
          <td width="9%" align="center"> <a href="http://sealoearth.org"> Home </a> </td>
          <td width="9%" align="center"> <a href="../symbolism.html"> Symbolism </a> </td>
          <td width="9%" align="center"> <a href="../environment.html"> Environment </a> </td>
          <td width="9%" align="center"> <a href="../treeoflife.html"> Tree of Life </a> </td>
          <td width="9%" align="center"> <a href="../news.html"> News </a> </td>
          <td width="9%" align="center"> <a href="../store.html"> Store </a> </td>
          <td width="9%" align="center"> <a href="../donate.html"> Donate </a> </td>
          <td width="9%" align="center"> <a href="http://sealoearth.org/feedback/membership.pl"> Membership</a> </td>
          <td width="9%" align="center"> <a href="../board.html"> Board </a> </td>
          <td width="9%" align="center"> <a href="http://sealoearth.org/feedback/sealoearth.pl"> Contact</a> </td>
        </tr>

        <tr bgcolor="#ccffff">
          <td width="9%" align="center"> <b> PROGRAMS </b> </td>
          <td width="9%" align="center"> <a href="../earthdaycelebration.html"> Earth Day Celebration </a> </td>
          <td width="9%" align="center"> <a href="../environmentaldistinction.html"> Environmental Distinction </a> </td>
          <td width="9%" align="center"> <a href="../essaycontest.html"> Essay Contest </a> </td>
          <td width="9%" align="center"> <a href="../earthday.html"> Earth Day CARE</a> </td>
          <td width="9%" align="center"> <a href="../workshops.html"> Workshops </a> </td>
          <td width="9%" align="center"> <a href="../parades.html"> Parades </a> </td>
          <td width="9%" align="center"> <a href="../zerowaste.html"> Zero Waste </a> </td>
          <td width="9%" align="center"> <a href="../stewardship.html"> Stewardship </a> </td>
          <td width="9%" align="center"> <a href="../ambassador.html"> Ambassador </a> </td>
          <td width="9%" align="center"> <a href="../volunteer.html"> Volunteer </a> </td>
        </tr>

      </table>
      
    <p>
  );
 
  return $header;

} # header


#--------------------
# Footer
#--------------------

sub footer {

  my $footer = q(
  
    <a> 
      <center>
        <div style="font: bold 12px Arial; padding: 5px;">

	   SEALOEarth © Copyright 2020. All rights reserved.

	   &nbsp; &nbsp; &nbsp; &nbsp;

	</div>
      </center>
    </a>
    </body>
    </html>
  );

  return $footer;  

} # footer


#--------------------
# Display 1
#--------------------

sub display1 {
  my ($output) = @_;

  my $header = header();
  my $footer = footer();

  my $DEBUG = "";   
     $DEBUG = "This program is in a debug mode <p>" if ($debug);

  print <<END_HTML;

    $header
   
    $DEBUG

    $output
    <p>
           
    $footer

END_HTML

} # display1


#--------------------
# Display 2
#--------------------

sub display2 {
  my ($output) = @_;


  my $header = "";
     $header = header();
  my $footer = footer();
  
  my $display = "";
     $display = "<b>Feedback Status</b>";


  my $DEBUG = "";   
     $DEBUG = "This program is in a debug mode <p>" if ($debug);
  
  print <<END_HTML;

    $header
    
    $display

    $DEBUG
    
    $output
           
    $footer

END_HTML

} # display2


#--------------------
#  Set Feedback Form
#--------------------

sub setfeedbackform {

  # Generate random number
  my $range   = 1000;     # From 0 to 999
  my $minimum = 1000;   

  my $random_num = 4321;
     $random_num = int(rand($range)) + $minimum;     # From 1000 to 1999
     
  my $form = "";
     $form .= "<b><center><a> REGISTRATION </a> </center></b><br><br>";
     $form .= "<a> Dear Volunteer: </a> <br><br>";
     $form .= "<a> To get the recognition/certificate you deserve, please complete this form.</a> <br><br>";
     $form .= "<a> Your time in filling out this form is truly appreciated.</a> <br><br>";     $form .= "&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ";
     $form .= "&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ";
     $form .= "<font color=red>* indicates required fields</font>";
     $form .= "<br><p>";
      
  $form .= '<FORM METHOD="post" ACTION="./' . $global{'program'} . '">';
 
  $form .= q( 
              <table cellpadding=3>
                <tr>
                  <td valign="top">
                    <label for="name">Your Name (Certificate)<font color=red>*</font> </label>
                  </td>
                  <td valign="top">
                    <input  type="text" name="name" maxlength="50" size="30">
                  </td>
                </tr>
	        <tr>
	          <td valign="top">
	            <label for="email">Your Valid Email <font color=red>*</font> </label>
	          </td>
	          <td valign="top">
	            <input  type="text" name="email" maxlength="50" size="30">
	          </td>
	        </tr>
	        <tr>
	          <td valign="top">
	            <label for="subj">Your Address <font color=red>*</font> </label>
	          </td>
	          <td valign="top">
	            <input  type="text" name="address" maxlength="50" size="30">
	          </td>
	        </tr>
	        <tr>
	          <td valign="top">
	            <label for="subj">Your City <font color=red>*</font> </label>
	          </td>
	          <td valign="top">
	            <input  type="text" name="city" maxlength="50" size="30">
	          </td>
	        </tr>
	        <tr>
	          <td valign="top">
	            <label for="subj">Your Country <font color=red>*</font> </label>
	          </td>
	          <td valign="top">
	            <input  type="text" name="country" maxlength="50" size="30">
	          </td>
	        </tr>
	        <tr>
	          <td valign="top">
	            <label for="subj">Your phone <font color=red>*</font> </label>
	          </td>
	          <td valign="top">
	            <input  type="text" name="phone" maxlength="50" size="30">
	          </td>
	        </tr>
	        <tr>
	          <td valign="top">
	            <label for="subj">Number of Volunteer Hours <font color=red>*</font> </label>
	          </td>
	          <td valign="top">
	            <input  type="text" name="hours" maxlength="50" size="30">
	          </td>
	        </tr>
	        <tr>
	          <td valign="top">
	            <label for="subj">Project Name <font color=red>*</font> </label>
	          </td>
	          <td valign="top">
	            <input  type="text" name="project" maxlength="50" size="30">
	          </td>
	        </tr>
	        <tr>
	          <td valign="top">
	            <label for="subj">Duration of the project <font color=red>*</font> </label>
	          </td>
	          <td valign="top">
	            <input  type="text" name="duration" maxlength="50" size="30">
	          </td>
	        </tr>
	        <tr>
	          <td valign="top">
	            <label for="code">Anti-spam code <font color=red>*</font> </label>
	          </td>
	          <td valign="top">	             
            );

  $form .= "<input type=hidden name=code1 value=". $random_num . ">";

  $form .= "<input type=text name=code2 maxlength=4 size=4>";
 #$form .= "<input type=text name=code2 value=". $random_num . " maxlength=4 size=4>";
  
  $form .= " &nbsp; <a>". $random_num . "</a>";
  
  $form .= q( 	                        
	          </td>
	        </tr>	        
	        <tr>
	          <td valign="top">
	            <label for="comm">Service Rendered (In detail)<font color=red>*</font> </label>
	          </td>
	          <td valign="top">
	            <textarea  name="service" maxlength="1000" cols="50" rows="15"></textarea>
	          </td>
	        </tr>
	        <tr>
	          <td valign="top">
	          </td>
	          <td>
	            <input type="submit" name="resp" value="Submit">
	          </td>
	        </tr>
	      </table>
	      </form>
            );
  
  return $form;  

} # setfeedbackform


#--------------------
# Deliver
#--------------------

sub deliver {
  my ($feedback_hashref) = @_;

  my %feedback = %$feedback_hashref;
    
  my $flag = 0;
     $flag = 1 unless ( ($feedback{name} eq "") || ($feedback{email} eq "") || ($feedback{address} eq "") || ($feedback{city} eq "") || ($feedback{country} eq "") || ($feedback{phone} eq "") || ($feedback{hours} eq "") || ($feedback{project} eq "") || ($feedback{duration} eq "") || ($feedback{service} eq "") );
      
  my $display = "";
  
  my $to      = 'cnhiremath@sealoearth.org, cnhiremath@hotmail.com';
  my $from    = 'info@sealoearth.org';
  my $replyto = trim($feedback{email});
  my $subject = 'SEALOEarth Volunteer: ' . trim($feedback{subj});
  my $name    = trim($feedback{name});

  # Service
  my $service = trim($feedback{service});  
  
  # Message
  my $message  = "";
     $message .= "VOLUNTEER"                       . "\n"; 
     $message .= "    " . $feedback{name}          . "\n"; 
     $message .= "    " . $feedback{address}       . "\n"; 
     $message .= "    " . $feedback{city}          . "\n"; 
     $message .= "    " . $feedback{country}       . "\n"; 
     $message .= "    " . $feedback{email}         . "\n"; 
     $message .= "    " . $feedback{phone}         . "\n"; 
     $message .= "HOURS"                           . "\n"; 
     $message .= "    " . $feedback{hours}         . "\n"; 
     $message .= "PROJECT"                         . "\n"; 
     $message .= "    " . $feedback{project}       . "\n"; 
     $message .= "    " . $feedback{duration}      . "\n"; 
     $message .= "SERVICE "                        . "\n"; 
     $message .= "    " . $feedback{service}       . "\n"; 
  
  # Save into Global
  $global{'replyto'} = $replyto;
  $global{'name'}    = $feedback{name};
  $global{'address'} = $feedback{address};
  $global{'city'}    = $feedback{city};
  $global{'country'} = $feedback{country};
  $global{'email'}   = $feedback{email};
  $global{'phone'}   = $feedback{phone};
  $global{'hours'}   = $feedback{hours};
  $global{'project'} = $feedback{project};
  $global{'duration'}= $feedback{duration};
  $global{'service'} = $feedback{service};
  $global{'message'} = trim($message);  
  
  #
  my $missing = "<font color=red>MISSING</font>";
  $from     = $missing if ($from eq "");
  $subject  = $missing if ($subject eq "");
  $message  = $missing if ($message eq "");
  $name     = $missing if ($name eq "");
  
  my $test = 1;
  if ($test) {
     $display .= "<p>";
    #$display .= "<a> To      : " . $to . "</a><br>";
     $display .= "<a> From    : " . $replyto . "</a><br>";
     $display .= "<a> Subject : " . $subject . "</a><br>";
     $display .= "<a> Message : " . $message . "</a><br>";  
     $display .= "<a> Name    : " . $name . "</a><br><p>";  
  }
  
  # Send email
  my $sendmail = '/usr/lib/sendmail';
  
  if ($flag) {
    open(MAIL, "|$sendmail -oi -t");
      print MAIL "From: $from\n";
      print MAIL "To: $to\n";
      print MAIL "Reply-To: $replyto\n";
      print MAIL "Subject: $subject\n\n";
      print MAIL "$message\n\n";
      print MAIL "$name\n";
    close(MAIL);
    
    usuage();
  } 
   
  # Status
  if ($flag) {
    $display .= q( 
                   <a><font color=green> 
                      SUCCESS: &nbsp;
                      Thank you for providing your valuable service. 
                      Your volunteer hours have been successfully logged. Your certificate will processed soon.
                   </font></a>
                 );
  } else {
    $display .= q( 
                   <a><font color=red> 
                      ERROR: &nbsp;
                      Your form was not delivered. &nbsp; 
                      Please go back and complete the required fields. &nbsp; 
                      Thank you.
                   </font></a>
                 );
  }

  return ($display);  

} # deliver


#--------------------
# Usuage
#--------------------

sub usuage {
  
  use DateTime;
  
  my $usuagelog = "";
     $usuagelog = "on";   # To update the log file
  
  my $logfile = "";
     $logfile = "../log/log_sealoearth_volunteer.txt";
     
  open (LOG_FH, ">>", "$logfile") || die ("Error : can't open log file");
  
    my $SESSION = "";
    if ($usuagelog) {

      my $localtime = DateTime->now( time_zone => 'America/New_York' );
      my @tmp  = split 'T', $localtime;
      my $date = $tmp[0];
      my $time = $tmp[1];
      
      my $day = $localtime->day_abbr;
      
      my $address = $ENV{REMOTE_ADDR};
 
      $SESSION .=  "Volunteer * " . "\t"; 
      $SESSION .=  $date . "\t";
      $SESSION .=  $time . "\t";
      $SESSION .=  $day .  "\t";

      $SESSION .=  "". $global{'name'} . "\t";     
      $SESSION .=  "". $global{'address'} . "\t";     
      $SESSION .=  "". $global{'city'} . "\t";     
      $SESSION .=  "". $global{'country'} . "\t";     
      $SESSION .=  "". $global{'email'} . "\t";     
      $SESSION .=  "". $global{'phone'} . "\t";     
      $SESSION .=  "". $global{'hours'} . "\t";     
      $SESSION .=  "". $global{'project'} . "\t";     
      $SESSION .=  "". $global{'duration'} . "\t";     
      $SESSION .=  "". $global{'service'} . "\t";     
      
      $SESSION .=  $address . "\t";
    
      $SESSION .=  "* \n";      
  
    }
    print LOG_FH "$SESSION";
  
  close (LOG_FH);

} # Usuage


#--------------------
# Trim the String.
#--------------------

sub trim {
  my ($string) = @_;

  # Cleanup this value.
  $string =~ s/\r|\n//;   # Trim return and newline
  $string =~ s/^\s+//;    # Trim leading whitespace
  $string =~ s/\s+$//;    # Trim trailing whitespace

  return $string;

} # trim


#--------------------
# Get program name.
#--------------------

sub getprogram {

  my $path = "$0";
    
  my @tmp = split(/\\/, $path);
  my $program = $tmp[$#tmp];

  return $program;

} # getprogram


#-------------------------------- THE END -----------------------------------
