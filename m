Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167F279926
	for <rcu@vger.kernel.org>; Thu,  8 Feb 2024 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707403872; cv=none; b=B4cZ5WrQARr9cyRVeQAKU5+jD5jFpjk09gx/n7S7Rz+GpZnsjYDZjSdjGQyRv9cwHgWtJrAzAZZGiRgt3WJJ9GF/NydFK8NYRSR8oeBxa+OuRK1bjdHjMGIEz/bdujjWAOdlKPPIp78RHY87M5t5o3UvhABRa9ihrYeE//oIQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707403872; c=relaxed/simple;
	bh=Zu1zCD6k7M8shzYC7OO3X+lEBEVmH9A4kMKypbHXJTo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEtV2YqDYX+7dQn99J/yIdLCqOSXEaFi7GAsNTfFeJNK7mtvRqLx8Y3QQ5xDGPVTjgnxs5xyb0XMPjgjxG7mIUbNi4R/lmX7uzK+QVC1bVquxzbgQvNqoxY67w8PsDDRZdxC7gadp5GqFcQrkbXixyGtev/7gO1NfoXwdbRnGfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpS9LbWp; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpS9LbWp"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d0a0e40672so10180951fa.0
        for <rcu@vger.kernel.org>; Thu, 08 Feb 2024 06:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707403869; x=1708008669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DV06rcunBPBALIVlHenPv51cZhhW7Zimmh9/welqPzE=;
        b=OpS9LbWpTCyzo96igMhe7zBxreXCTSGKD3j5q1TrFE0WInIJx27IWc8srokJljIUvD
         sBKKmCcsCpcDrtVt2qPZlIikeQxTYa4WnkGikjuIj9JUuviK4u04ubjLPTXzdQApP94+
         IRagQnD2Bg87UAK0HZ5MOX3YVH3uqBisaNbb0J+DxJWAduskAbhclOISniJ+T+GtZVC1
         NKg8Zj39ck5vpjyMUe3c7/adZNmD2BtFDCu4Gm40MH7pgA0J8I8hhf1Wld+ymuCp81JJ
         dcYlEwW0kboiJI8aF2vKXt8T0sbQACYDuVrGAUxY4rnHmw3OGhdSgwmQEXaLZYP7xAQY
         jW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707403869; x=1708008669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DV06rcunBPBALIVlHenPv51cZhhW7Zimmh9/welqPzE=;
        b=hxAwimBzj57HqK/7TZ53hjJdqthjqRV2KCQ3nBW4lTli+wT5WfcDp9HdyDIlPp55qZ
         1ZMKmM/e+3djkvIGzUADkiPkSIVp3ILWFSeh9UabbMuuU9z0vBQLjDpD0xwUXfMjZ41f
         RZPQ1JZpLrNRev5f3eHxvllj6U94IAVckDbIyBP3ZmJP1YA98COr3Y+c8OyS7Wcjwljh
         Dgm48gTrHoM124U0dU8ZRalwW6ohKOgz092jWULjCUj0j/jKflfBgGs4XAqo7bgSn5V8
         T27S4VCHYgJNLHVrFayo0nnBlD63+F9krtmCGquzfUjdEgdvTEGsytmuIb2eACcCv9HM
         tkBg==
X-Gm-Message-State: AOJu0YzPwVqO1ike0Kg+wbLFtktDqvygSYcGTiexdsMy7YQPCxOR1sxs
	Mfobps00/HEnSW+B59fgw5KOGSiQQ231R2oMQwBXtYNLpCOazJzLct2RB+Ps
X-Google-Smtp-Source: AGHT+IFL5hyaGGSXpOsAufIM2w8QLygmpL9W/RgkWuS9eQBlMHPZLqHAgDuialbPiAzKByweDywvsQ==
X-Received: by 2002:a2e:9cc2:0:b0:2cf:1de7:1fd with SMTP id g2-20020a2e9cc2000000b002cf1de701fdmr1106420ljj.20.1707403868976;
        Thu, 08 Feb 2024 06:51:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmEJfKy9xm0TWS2dSV2jEqaI7lpRdkQtRmaLndcxQSt0j8d+jfESxSXX/upJWxwJiEwGomDpDhkIXCqwvxtWaHawxWe7LX26WyDIbz1kIBhP1ByGB70D2za2yIcSifXdT9hDo20tCFiu8AJceoKx9lvRems1WOHa6fV8nSQfhwLcXmXZFHjelAaNWm0qzHfv2qvEfBzWI=
Received: from pc636 (host-90-233-221-0.mobileonline.telia.com. [90.233.221.0])
        by smtp.gmail.com with ESMTPSA id e26-20020a2e8eda000000b002cf1cf44a00sm15177ljl.52.2024.02.08.06.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 06:51:08 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 8 Feb 2024 15:51:06 +0100
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Andrea Righi <andrea.righi@canonical.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org,
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <ZcTqWiCJXg4H1wxp@pc636>
References: <ZbjdL04k2Z2ZdUyp@gpd>
 <b8d80604-18a5-4f82-b846-5c00c6aeae6f@paulmck-laptop>
 <ZcJxhoNpkTM7LnOr@gpd>
 <9f9b6885-6d9d-4f30-9635-49443e1615e9@joelfernandes.org>
 <ZcOwRsEhbQhGv9X2@gpd>
 <CAEXW_YQN=Dm4TXv+F=Q4bfnKWn1Tv52=8hz50JLkbufcM5hUpQ@mail.gmail.com>
 <ZcO4c6nxemyxRFz3@gpd>
 <1fcf7e8a-c245-4c5c-ac86-7f0a1531032d@joelfernandes.org>
 <ZcR66cxax008lPGv@gpd>
 <ZcTO5lKeZoJZH1Mp@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcTO5lKeZoJZH1Mp@pc636>

On Thu, Feb 08, 2024 at 01:53:58PM +0100, Uladzislau Rezki wrote:
> On Thu, Feb 08, 2024 at 07:55:37AM +0100, Andrea Righi wrote:
> > On Thu, Feb 08, 2024 at 12:54:58AM -0500, Joel Fernandes wrote:
> > ...
> > > >> Slightly related, but one of the things we are wondering also is how
> > > >> much of the overhead for your nohz-full and lazy-RCU test (on top of
> > > >> baseline - that is just CONFIG_HZ=1000 without nohz-full or nocbs) is
> > > >> because of just using NOCB. Uladsizlau mentioned he might run a test
> > > >> for comparing along those lines as well.
> > > > 
> > > > Just to clarify, "lazy rcu on" results are just with rcu_nocb=all and
> > > > lazy RCUs enabled (and HZ=1000), so without nohz_full.
> > > > 
> > > > If I enable only nohz_full=all (without rcu_nocb) I see something like
> > > > this:
> > > 
> > > Ok. I did want to mention nohz_full implies rcu_nocb on the same CPUs as well.
> > > 
> > > Its also mentioned in the boot param docs on the last line of the description:
> > > 
> > >         nohz_full=      [KNL,BOOT,SMP,ISOL]
> > >                         The argument is a cpu list, as described above.
> > >                         In kernels built with CONFIG_NO_HZ_FULL=y, set
> > >                         the specified list of CPUs whose tick will be stopped
> > >                         whenever possible. The boot CPU will be forced outside
> > >                         the range to maintain the timekeeping.  Any CPUs
> > >                         in this list will have their RCU callbacks offloaded,
> > >                         just as if they had also been called out in the
> > >                         rcu_nocbs= boot parameter.
> > 
> > Ah I didn't realize that, it definitely makes sense, thanks for
> > clarifying it.
> > 
> > Then basically in the results that I posted the difference is
> > "nohz_full=all+rcu_nocb=all" vs "rcu_nocb=all+lazy_RCU=on".
> > 
> So, you say that a hrtimer_interrupt() handler takes more time in case
> of lazy + nocb + rcu_nocb=all and for nohz_full + rcu_nocb=all it faster?
> Could you please clarify this? I will try to measure from my side!
> 
> I have done some basic research about hrtimer_interrupt() latency on my
> HW with latest Linux kernel. I have compared below cases:
> 
> case a: 1000HZ + lazy + nocb_all_cpus
> case b: 1000HZ + nocb_all_cpus
> 
> I used "ftrace" to measure time(in microseconds). Steps:
> 
> echo 0 > tracing_on
> echo function_graph > current_tracer
> echo funcgraph-proc > trace_options
> echo funcgraph-abstime > trace_options
> echo hrtimer_interrupt > set_ftrace_filter
> 
> fio --rw=write --bs=1M --size=1G --numjobs=8 --name=worker --time_based --runtime=50&
> 
> echo 1 > tracing_on; sleep 10; echo 0 > tracing_on
> 
> data is based on 10 seconds collection:
> 
> <case a>
>      6  2102 ############################################################
>      8  2079 ############################################################
>     10  1464 ##########################################
>      7   897 ##########################
>      9   625 ##################
>     12   490 ##############
>     13   479 ##############
>     11   289 #########
>      5   249 ########
>     14   124 ####
>     15    72 ###
>     16    41 ##
>     17    24 #
>      4    22 #
>     18    12 #
>     22     2 #
>     19     1 #
> <case a>
> 
> <case b>
>      9  1658 ############################################################
>     13  1308 ################################################
>     12  1224 #############################################
>     10   972 ####################################
>      8   703 ##########################
>     14   595 ######################
>     15   571 #####################
>     11   525 ###################
>     17   350 #############
>     16   235 #########
>      7   214 ########
>      4    73 ###
>      5    68 ###
>      6    54 ##
>     20     9 #
>     18     9 #
>     19     6 #
>     33     1 #
>      3     1 #
>     28     1 #
>     27     1 #
>     25     1 #
>     22     1 #
>     21     1 #
> <case b>
> 
> I do not see the difference, there is a nose of 1/2/3 microseconds diff.
> 
Let me further have a look at what we use for lazy in terms on hrtimer though.

--
Uladzislau Rezki
