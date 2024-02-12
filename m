Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBAFF9E4
	for <rcu@vger.kernel.org>; Mon, 12 Feb 2024 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707728757; cv=none; b=XeonJPzdn3Jjd4OES1byk/SrwIRU2zsID2raNHejkLvyepNk1KjobZpbfNWitO+u6MBknXj2au3DT0TqjfqVlTt4S6tteaNqk6gP+P+thTvhBG4I3hHFx9eyPH2LI64J1TNqRPRonCvrNyxNqIOAErdlSrxZjTU6ezVKqB0jE0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707728757; c=relaxed/simple;
	bh=ieWpqkPky+f79nIKJVAoVLamawV+rx5I7VqfZBuwZw8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meeeukH0ly0FSoASznfofHT+H4MryNPbpvkpGZf9i50kTHlhpSjEkGlcwrmksEnV964NnHnb1q2hMOMSfkz21jRbZNrTcNn9nJgHD3uqZpLMM2/vThgGoBjtFkvS5NOqEUj0Mad1rhNapHllbrMn4kuQmOlPXHrtiiilVgl5dOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T886Zebq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T886Zebq"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d0f415fd8eso13570531fa.0
        for <rcu@vger.kernel.org>; Mon, 12 Feb 2024 01:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707728754; x=1708333554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mnYOLcgSiP4QnAWYcGnRLMa6HMvsz2VopVSiHmjbjVM=;
        b=T886Zebq47eDLMJX2LFIOPO9Npbpv1k+67gF/CDYHVGaIDuN6dC2IcZYoZpy5XCTGg
         cFhyS3vVJAI05vyPTQcdaIhzph/dcAzpyh1fxLC3OHqCucPdF28MnbIEwesVt2KQc4WA
         mpUwL0o75VHjjuh8Q5B3nzvKjRcui8k7FiNggPoWRs9AY949EFtdtE35Ra2dAix2yu9D
         TptDwYwaqixprYUQEh0wex0oUPPi8/UPd7VQkRToytGmdEFGvRrmYjHFCJbspghvx5gl
         rF8hSPTS45gVXSN8h1qK5NFSBLHPDMmDnCE9ZNuCiuzlrDw4jV0JK1Lyx2Oo/e3m8wak
         rRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707728754; x=1708333554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnYOLcgSiP4QnAWYcGnRLMa6HMvsz2VopVSiHmjbjVM=;
        b=WEzlCGCVlzqbS6h5SerLsjoxNNBdJ0pw1Op6HaSQMjFv/l5DMCiT33NiWEcVjLFM+I
         V66lbFlfuttvufiSf3g0GlGUwoCmzGWAZuNowDM3ttdgMud95NsqergWtzPoJ1D1uI/o
         U8AEGCCS05zOxHjnxdZh0ZDT/ZuZM3KZpGJA6q8DrZnfH/yhEJQLITebFV8Zx0EFvDR5
         OtqAFTUrENeMlNFxosGV/f+BV0rxCC/BzMZ/7HPJ8I8TqxPV51dLevX8qISWiz+0k26P
         NaX/jvuebA5ZREAZWI12ifUWXHOtFM6bPU1x1Sv0SzA1W+efeNgU0h0ArGoQy85Zlqqc
         1qDg==
X-Forwarded-Encrypted: i=1; AJvYcCXgu+WqlPEqVb4kkn7LVm8mMD7foTasEZT3Lcvmdhq9hdjfXYo6NNeR1UmwWTtF4IGbp2ZkGE/qNsc0kbkH92E8+RfR
X-Gm-Message-State: AOJu0Yx+86ZCDJG7FvZV+cqwWwmK9UwuqDWV4fxaZr+yjVVXJBdGIAeg
	dxfg7xo0BoUm98xl7srhwjtezZjiOjT71uoS4NqA1ZhRwD7UeKAC
X-Google-Smtp-Source: AGHT+IH1PgKK3gFenrY/oFY44S+ZAnXmGlDzUio1YCjoI8/WSmCm8frW0/TmuoJJHLuSvL8oCruN1A==
X-Received: by 2002:a05:651c:220c:b0:2d1:22d:f103 with SMTP id y12-20020a05651c220c00b002d1022df103mr13632ljq.16.1707728753263;
        Mon, 12 Feb 2024 01:05:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4i38yWlq4VtJnVtaDBMxD+9k9PvH3AtHnWg8ro4i1TvG0+FrmyODntVCMZ5OzrgXx0wJOWdBEcoqpHdLLMEM4HXURyfuIpvtZ7aKwtZhCRoKJ7oZCWah1hAMYaOC0PWFv7HCegQLQjvuL3/FXdikyJq27PzgFkZeXQBHiGTIH7c6F3HYvVJpHh62o3OH8RG7SBxNbYJXu3v0t
Received: from pc636 (host-90-235-18-79.mobileonline.telia.com. [90.235.18.79])
        by smtp.gmail.com with ESMTPSA id s9-20020a2e2c09000000b002d0c8960490sm1333600ljs.41.2024.02.12.01.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 01:05:52 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 12 Feb 2024 10:05:50 +0100
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrea Righi <andrea.righi@canonical.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org,
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <ZcnfbhteSsngapOP@pc636>
References: <ZcJxhoNpkTM7LnOr@gpd>
 <9f9b6885-6d9d-4f30-9635-49443e1615e9@joelfernandes.org>
 <ZcOwRsEhbQhGv9X2@gpd>
 <CAEXW_YQN=Dm4TXv+F=Q4bfnKWn1Tv52=8hz50JLkbufcM5hUpQ@mail.gmail.com>
 <ZcO4c6nxemyxRFz3@gpd>
 <1fcf7e8a-c245-4c5c-ac86-7f0a1531032d@joelfernandes.org>
 <ZcR66cxax008lPGv@gpd>
 <ZcTO5lKeZoJZH1Mp@pc636>
 <ZcTqWiCJXg4H1wxp@pc636>
 <29e6c22d-0487-42a5-b840-e3c7ea7c6270@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29e6c22d-0487-42a5-b840-e3c7ea7c6270@joelfernandes.org>

On Sun, Feb 11, 2024 at 07:22:55PM -0500, Joel Fernandes wrote:
> 
> 
> On 2/8/2024 9:51 AM, Uladzislau Rezki wrote:
> > On Thu, Feb 08, 2024 at 01:53:58PM +0100, Uladzislau Rezki wrote:
> >> On Thu, Feb 08, 2024 at 07:55:37AM +0100, Andrea Righi wrote:
> >>> On Thu, Feb 08, 2024 at 12:54:58AM -0500, Joel Fernandes wrote:
> >>> ...
> >>>>>> Slightly related, but one of the things we are wondering also is how
> >>>>>> much of the overhead for your nohz-full and lazy-RCU test (on top of
> >>>>>> baseline - that is just CONFIG_HZ=1000 without nohz-full or nocbs) is
> >>>>>> because of just using NOCB. Uladsizlau mentioned he might run a test
> >>>>>> for comparing along those lines as well.
> >>>>>
> >>>>> Just to clarify, "lazy rcu on" results are just with rcu_nocb=all and
> >>>>> lazy RCUs enabled (and HZ=1000), so without nohz_full.
> >>>>>
> >>>>> If I enable only nohz_full=all (without rcu_nocb) I see something like
> >>>>> this:
> >>>>
> >>>> Ok. I did want to mention nohz_full implies rcu_nocb on the same CPUs as well.
> >>>>
> >>>> Its also mentioned in the boot param docs on the last line of the description:
> >>>>
> >>>>         nohz_full=      [KNL,BOOT,SMP,ISOL]
> >>>>                         The argument is a cpu list, as described above.
> >>>>                         In kernels built with CONFIG_NO_HZ_FULL=y, set
> >>>>                         the specified list of CPUs whose tick will be stopped
> >>>>                         whenever possible. The boot CPU will be forced outside
> >>>>                         the range to maintain the timekeeping.  Any CPUs
> >>>>                         in this list will have their RCU callbacks offloaded,
> >>>>                         just as if they had also been called out in the
> >>>>                         rcu_nocbs= boot parameter.
> >>>
> >>> Ah I didn't realize that, it definitely makes sense, thanks for
> >>> clarifying it.
> >>>
> >>> Then basically in the results that I posted the difference is
> >>> "nohz_full=all+rcu_nocb=all" vs "rcu_nocb=all+lazy_RCU=on".
> >>>
> >> So, you say that a hrtimer_interrupt() handler takes more time in case
> >> of lazy + nocb + rcu_nocb=all and for nohz_full + rcu_nocb=all it faster?
> >> Could you please clarify this? I will try to measure from my side!
> >>
> >> I have done some basic research about hrtimer_interrupt() latency on my
> >> HW with latest Linux kernel. I have compared below cases:
> >>
> >> case a: 1000HZ + lazy + nocb_all_cpus
> >> case b: 1000HZ + nocb_all_cpus
> >>
> >> I used "ftrace" to measure time(in microseconds). Steps:
> >>
> >> echo 0 > tracing_on
> >> echo function_graph > current_tracer
> >> echo funcgraph-proc > trace_options
> >> echo funcgraph-abstime > trace_options
> >> echo hrtimer_interrupt > set_ftrace_filter
> >>
> >> fio --rw=write --bs=1M --size=1G --numjobs=8 --name=worker --time_based --runtime=50&
> >>
> >> echo 1 > tracing_on; sleep 10; echo 0 > tracing_on
> >>
> >> data is based on 10 seconds collection:
> >>
> >> <case a>
> >>      6  2102 ############################################################
> >>      8  2079 ############################################################
> >>     10  1464 ##########################################
> >>      7   897 ##########################
> 
> So first column is microseconds and second one is count?
> 
> >>      9   625 ##################
> >>     12   490 ##############
> >>     13   479 ##############
> >>     11   289 #########
> >>      5   249 ########
> >>     14   124 ####
> >>     15    72 ###
> >>     16    41 ##
> >>     17    24 #
> >>      4    22 #
> >>     18    12 #
> >>     22     2 #
> >>     19     1 #
> >> <case a>
> >>
> >> <case b>
> >>      9  1658 ############################################################
> >>     13  1308 ################################################
> >>     12  1224 #############################################
> 
> Assuming that, it does seem the "best" case is off by 3 microseconds (9 vs 6),
> still would not warrant being regarded a bug and possibly just in the noise.
> 
> >>     10   972 ####################################
> >>      8   703 ##########################
> >>     14   595 ######################
> >>     15   571 #####################
> >>     11   525 ###################
> >>     17   350 #############
> >>     16   235 #########
> >>      7   214 ########
> >>      4    73 ###
> >>      5    68 ###
> >>      6    54 ##
> >>     20     9 #
> >>     18     9 #
> >>     19     6 #
> >>     33     1 #
> >>      3     1 #
> >>     28     1 #
> >>     27     1 #
> >>     25     1 #
> >>     22     1 #
> >>     21     1 #
> >> <case b>
> >>
> >> I do not see the difference, there is a nose of 1/2/3 microseconds diff.
> >>
> > Let me further have a look at what we use for lazy in terms on hrtimer though.
> 
> Thanks for tracing it. Yeah it would be nice to count how many counts of
> do_nocb_deferred_wakeup() does the fio test trigger. If it is few, then maybe
> the problem with hrtimer_interrupt() is something else.
> 

urezki@pc638:~$ fio --rw=write --bs=1M --size=1G --numjobs=8 --name=worker --time_based --runtime=1000 > /dev/null 2>&1&
[1] 697
urezki@pc638:~$ sudo cat /sys/kernel/debug/tracing/trace_pipe  | grep Timer
          <idle>-0       [005] ..s1.   175.762689: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [002] ..s1.   186.002386: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [005] ..s1.   186.002391: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [001] ..s1.   228.497061: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [001] ..s1.   242.831956: rcu_nocb_wake: rcu_preempt 4 Timer
             fio-705     [004] ..s..   272.009997: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [002] ..s1.   282.253447: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [004] ..s1.   347.786758: rcu_nocb_wake: rcu_preempt 4 Timer
            cron-714     [004] ..s1.   362.429287: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [007] .Ns1.   377.993814: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [002] ..s1.   393.353371: rcu_nocb_wake: rcu_preempt 0 Timer
    kworker/6:1H-172     [006] ..s1.   410.760933: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [007] ..s1.   427.148456: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [004] ..s1.   438.220173: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [007] .Ns1.   451.719831: rcu_nocb_wake: rcu_preempt 4 Timer
    kworker/6:1H-172     [006] ..s1.   472.199389: rcu_nocb_wake: rcu_preempt 4 Timer
           <...>-717     [000] ..s..   482.434074: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [004] ..s1.   484.969012: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [007] ..s1.   495.750151: rcu_nocb_wake: rcu_preempt 4 Timer
             fio-702     [000] ..s1.   516.439595: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [004] ..s1.   578.212713: rcu_nocb_wake: rcu_preempt 4 Timer
    kworker/6:1H-172     [006] ..s1.   595.583863: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [004] ..s1.   597.634693: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [005] ..s1.   617.598664: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [004] ..s1.   655.996890: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [004] ..s1.   660.606691: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [004] ..s1.   680.059867: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [004] ..s1.   688.227533: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [004] ..s1.   698.491126: rcu_nocb_wake: rcu_preempt 4 Timer
             fio-703     [000] ..s1.   705.925823: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [004] ..s1.   721.018256: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [007] ..s1.   732.793797: rcu_nocb_wake: rcu_preempt 4 Timer
    kworker/6:1H-172     [006] ..s1.   747.129268: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [007] ..s1.   766.075583: rcu_nocb_wake: rcu_preempt 4 Timer
             fio-701     [004] ..s2.   767.047547: rcu_nocb_wake: rcu_preempt 4 Timer
    kworker/6:1H-172     [006] ..s1.   782.456032: rcu_nocb_wake: rcu_preempt 4 Timer
    kworker/6:1H-172     [006] ..s1.   797.303567: rcu_nocb_wake: rcu_preempt 4 Timer
    kworker/6:1H-172     [006] ..s1.   813.686996: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [005] ..s1.   828.534430: rcu_nocb_wake: rcu_preempt 4 Timer
             fio-700     [004] ..s2.   850.536698: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [007] ..s1.   860.789367: rcu_nocb_wake: rcu_preempt 4 Timer
     ksoftirqd/6-63      [006] ..s..   888.948515: rcu_nocb_wake: rcu_preempt 4 Timer
             fio-699     [000] ..s..   905.854912: rcu_nocb_wake: rcu_preempt 0 Timer
    kworker/6:1H-172     [006] ..s1.   911.987781: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [005] ..s1.   924.275337: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [004] ..s1.   938.208899: rcu_nocb_wake: rcu_preempt 4 Timer
    kworker/0:1H-100     [000] ..s1.   938.236053: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [004] ..s1.   948.338615: rcu_nocb_wake: rcu_preempt 4 Timer
             fio-702     [000] ..s2.   958.216274: rcu_nocb_wake: rcu_preempt 0 Timer
           <...>-728     [004] ..s..   962.432149: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [002] ..s1.   978.545645: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [003] ..s1.  1002.608935: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [004] ..s1.  1002.614904: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [001] ..s1.  1012.848592: rcu_nocb_wake: rcu_preempt 0 Timer
    kworker/6:1H-172     [006] ..s1.  1021.552408: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [002] ..s1.  1042.543682: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [001] ..s1.  1068.654892: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [002] ..s1.  1080.430541: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [000] ..s1.  1098.349992: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [002] ..s1.  1115.757464: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [005] ..s1.  1170.539822: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [000] ..s1.  1178.191592: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [000] ..s1.  1188.459281: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [004] ..s1.  1196.139077: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [000] ..s1.  1216.762430: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [004] ..s1.  1238.374788: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [004] ..s1.  1241.194246: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [003] ..s1.  1251.433991: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [004] ..s1.  1261.673634: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [001] ..s1.  1261.673637: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [007] ..s1.  1271.913347: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [005] ..s1.  1308.263711: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [000] ..s1.  1308.263738: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [005] ..s1.  1308.270707: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [000] ..s1.  1326.183705: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [004] ..s1.  1326.183709: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [004] ..s1.  1326.193714: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [005] ..s1.  1336.423403: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [003] ..s1.  1336.423404: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [000] ..s1.  1368.678480: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [007] ..s1.  1398.373573: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [005] ..s1.  1428.580662: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [001] ..s1.  1428.580666: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [007] ..s1.  1468.515358: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [000] ..s1.  1488.482412: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [000] ..s1.  1548.385082: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [005] ..s1.  1548.385083: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [003] ..s1.  1572.448367: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [004] ..s1.  1572.448367: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [004] ..s1.  1572.453972: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [005] ..s1.  1582.688060: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [001] ..s1.  1582.688062: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [004] ..s1.  1592.927895: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [007] ..s1.  1608.287294: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [001] ..s1.  1608.799312: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [002] ..s1.  1621.086909: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [005] ..s1.  1631.326609: rcu_nocb_wake: rcu_preempt 4 Timer
          <idle>-0       [003] .Ns1.  1653.854052: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [001] ..s1.  1668.189531: rcu_nocb_wake: rcu_preempt 0 Timer
          <idle>-0       [007] ..s1.  1678.429219: rcu_nocb_wake: rcu_preempt 4 Timer
<snip>

1000 seconds runtime of "fio" test triggers the do_nocb_deferred_wakeup_timer()
around 100 times. Most of them are handled from the soft-irq context. I have
looked at the perf figures vs hrtimer_interrupt(). I do not see any obvious
performance issues with it.

8xCPUs KVM system;
1000HZ timer;
lazy + all offloading.

--
Uladzislau Rezki
