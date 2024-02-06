Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09603DF5A
	for <rcu@vger.kernel.org>; Tue,  6 Feb 2024 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241878; cv=none; b=cJBr8QajKoShdAryId4gYkXDSCZZVrsqf9HH9t5O4LkAgdjKZTa2hOR11BIYI50MDICa8RRP2aTr2GhmDk1fy/E4sbcIhb86TErUOMRsNXMSgr3HsXNmdIbSg0WiZGDY0IhUXZ6aWZw863iAochfdYFmzWdZ3lj7L7QW7emR+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241878; c=relaxed/simple;
	bh=/wmZEf4UtFwiyhBdB6SIzto0XsUZmP3bQBeE14dF5ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQoK6dDeA1IXAAHWovoWpcEi/oDsv31f8r2Fwl7eJ7HvguowGsdvt7CLwe0suad+v+ABCeQga7h0/N5MVZRTOOQ3U7qHYCs4R9ZE9pruZCfKYdvTHnwfttaKrN0u3I+oy4W8xfT1Qz9FhLBz5WB/oFxEXZeYQO5uaxcJcw/uA4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=mNJ+zIk0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="mNJ+zIk0"
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7186E3F6A4
	for <rcu@vger.kernel.org>; Tue,  6 Feb 2024 17:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1707241868;
	bh=/BSXljzr4kO7G7nYnZ5oEqwnkyhgQzswt+vUy4MigA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=mNJ+zIk0xwprEwrZIwrZXpw2NFm1CVDS+QWSkPJ99Ysxzq74eVXZ4WUgYDBlnfppb
	 u7oe14lN+Kwp73nBSXGVc9qLuJ63Ez4zKQCFU9W4FGsZfhHdmyqt1JiUANW9A/ZLql
	 eMSPozD31okgeopvYdecTebG2smDLT1F0pAryHMJkYIxb2yVJl2pfdFIjna3F2qDPN
	 3geiK+Jfg5OsAwnLxEmB457jPOK8Y7kzIPdd40OtI2PLeacV/qzV6PdzmGzgZpx0h1
	 qhH8tXr3jwa/z84ObO+PB2kuJEkGE//tyXlLfoi9YksgaH63sV6B0oJ6TqD9Nv2siZ
	 bvThZLp851zow==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a350f83730eso271591066b.2
        for <rcu@vger.kernel.org>; Tue, 06 Feb 2024 09:51:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707241864; x=1707846664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BSXljzr4kO7G7nYnZ5oEqwnkyhgQzswt+vUy4MigA0=;
        b=dT5JPBw7quhJhY4CTSFnJ9O4VMUVJJ+NWwKU03b4HYeG8lgz/C7oDY5FfydANOXG+q
         3lIfPY3jM6oC/sfj0ItJuLK5odbzb8yBn96Hr99cPSJkwVTW92VbSoUFLtXsg076tTi3
         nQmztqAkz57UHxM7vSaq6vQVg5T3TD+JePbcZ4ZU5Jzy0ggt3LPGM0LK5x35DCHhCeRh
         bbGw4sUTP8Ksd1sHKTjKSiT92ZaGiqn2f23Ss67Vtd2OZfu0wdNiHt7WrhRfKhg4TzOC
         8WCcrOqhICSlS6CLIp7wQREaHBVJ4NEcJsEF+83p6cCgNHUmGByO7wunnKvD3kzmFI8o
         laQA==
X-Gm-Message-State: AOJu0Yz8GdqMteH9NOwO7C+/MMjQeczvI0c0j9zBAfuI/YfGwfzsra4N
	wYEj3HrFTEeGyLTiuVIyaeJeMJPOisunqGxgdr+sqGP30nOc9XOrnY2yiQtMeDaaPxiocvP6gsB
	OEtodOCcxR7+QGVEw/sf3jAf2xIqN2R++G+nueNkzTAGxXDG6caKsNP6WRwyXtdtyqQ==
X-Received: by 2002:a17:907:7856:b0:a38:3ec3:9379 with SMTP id lb22-20020a170907785600b00a383ec39379mr1270927ejc.44.1707241864399;
        Tue, 06 Feb 2024 09:51:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZ7k3NUD1YbGT3cZXrx07xlgN0FwFHqt6ReSFsHzbfiQP8mYou3OTVjGS+sL9i56x3HAWLsQ==
X-Received: by 2002:a17:907:7856:b0:a38:3ec3:9379 with SMTP id lb22-20020a170907785600b00a383ec39379mr1270909ejc.44.1707241863906;
        Tue, 06 Feb 2024 09:51:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWiCo/gWLGmkhqn56AvmTXH336wFMRMP84elAv3++iX9REcmJ8gX27O+9NR3GFelAphU6wHQ1ogjm2NoqUbKNI2LT0G3dQwprGmlbu+/KgmBEPqs9/lCLEexomrjlk480Ca/JX9tnDUFg+6vWKG5MXCWtlhjFP+lb2laH+alrqPmT7M
Received: from localhost (host-95-245-37-163.retail.telecomitalia.it. [95.245.37.163])
        by smtp.gmail.com with ESMTPSA id t1-20020a1709060c4100b00a373379de8csm1383605ejf.100.2024.02.06.09.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:51:03 -0800 (PST)
Date: Tue, 6 Feb 2024 18:51:02 +0100
From: Andrea Righi <andrea.righi@canonical.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org,
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <ZcJxhoNpkTM7LnOr@gpd>
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
 <6a2b6857-57e7-4321-adae-132ba69a4fff@paulmck-laptop>
 <0e15e91e-da47-45dd-b7de-7f89b7b6002b@joelfernandes.org>
 <ZbieCjYk8cIgZS8L@gpd>
 <cf1c60fc-6295-402e-b546-6f67cf0955b2@paulmck-laptop>
 <ZbjYSXhIrVyCpRNM@pc636>
 <ZbjdL04k2Z2ZdUyp@gpd>
 <b8d80604-18a5-4f82-b846-5c00c6aeae6f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8d80604-18a5-4f82-b846-5c00c6aeae6f@paulmck-laptop>

On Tue, Jan 30, 2024 at 05:39:37AM -0800, Paul E. McKenney wrote:
> On Tue, Jan 30, 2024 at 12:27:43PM +0100, Andrea Righi wrote:
> > On Tue, Jan 30, 2024 at 12:06:49PM +0100, Uladzislau Rezki wrote:
> > > On Tue, Jan 30, 2024 at 02:17:22AM -0800, Paul E. McKenney wrote:
> > > > On Tue, Jan 30, 2024 at 07:58:18AM +0100, Andrea Righi wrote:
> > > > > Hi Joel and Paul,
> > > > > 
> > > > > comments below.
> > > > > 
> > > > > On Mon, Jan 29, 2024 at 05:16:38PM -0500, Joel Fernandes wrote:
> > > > > > Hi Paul,
> > > > > > 
> > > > > > On 1/29/2024 3:41 PM, Paul E. McKenney wrote:
> > > > > > > On Mon, Jan 29, 2024 at 05:47:39PM +0000, Joel Fernandes wrote:
> > > > > > >> Hi Guys,
> > > > > > >> Something caught my eye in [1] which a colleague pointed me to
> > > > > > >>  - CONFIG_HZ=1000 : 14866.05 bogo ops/s
> > > > > > >>  - CONFIG_HZ=1000+nohz_full : 18505.52 bogo ops/s
> > > > > > >>
> > > > > > >> The test in concern is:
> > > > > > >> stress-ng --matrix $(getconf _NPROCESSORS_ONLN) --timeout 5m --metrics-brief
> > > > > > >>
> > > > > > >> which is a CPU intensive test.
> > > > > > >>
> > > > > > >> Any thoughts on what else can attribute a 30% performance increase
> > > > > > >> versus non-nohz_full ? (Confession: No idea if the baseline is
> > > > > > >> nohz_idle or no nohz at all). If it is 30%, I may want to evaluate
> > > > > > >> nohz_full on some of our limited-CPU devices :)
> > > > > > > 
> > > > > > > The usual questions.  ;-)
> > > > > > > 
> > > > > > > Is this repeatable?  Is it under the same conditions of temperature,
> > > > > > > load, and so on?  Was it running on bare metal or on a guest OS?  If on a
> > > > > > > guest OS, what was the load from other guest OSes on the same hypervisor
> > > > > > > or on the hypervisor itself?
> > > > > 
> > > > > That was the result of a quick test, so I expect it has some fuzzyness
> > > > > in there.
> > > > > 
> > > > > It's an average of 10 runs, it was bare metal (my laptop, 8 cores 11th
> > > > > Gen Intel(R) Core(TM) i7-1195G7 @ 2.90GHz), *but* I wanted to run the
> > > > > test with the default Ubuntu settings, that means having "power mode:
> > > > > balanced" enabled. I don't know exactly what it's doing (I'll check how
> > > > > it works in details), I think it's using intel p-states IIRC.
> > > > > 
> > > > > Also, the system was not completely isolated (my email client was
> > > > > running) but the system was mostly idle in general.
> > > > > 
> > > > > I was already planning to repeat the tests in a more "isolated"
> > > > > environment and add details to the bug tracker.
> > > > > 
> > > > > > > 
> > > > > > > The bug report ad "CONFIG_HZ=250 : 17415.60 bogo ops/s", which makes
> > > > > > > me wonder if someone enabled some heavy debug that is greatly
> > > > > > > increasing the overhead of the scheduling-clock interrupt.
> > > > > > > 
> > > > > > > Now, if that was the case, I would expect the 250HZ number to have
> > > > > > > three-quarters of the improvement of the nohz_full number compared
> > > > > > > to the 1000HZ number:
> > > > > > >> 17415.60-14866.05=2549.55
> > > > > > > 18505.52-14866.05=3639.47
> > > > > > > 
> > > > > > > 2549.55/3639.47=0.70
> > > > > > 
> > > > > > I wonder if the difference here could possibly also be because of CPU idle
> > > > > > governor. It may behave differently at differently clock rates so perhaps has
> > > > > > different overhead.
> > > > > 
> > > > > Could be, but, again, the balanced power mode could play a major role
> > > > > here.
> > > > > 
> > > > > > 
> > > > > > I have added trying nohz full to my list as well to evaluate. FWIW, when we
> > > > > > moved from 250HZ to 1000HZ, it actually improved power because the CPUidle
> > > > > > governor could put the CPUs in deeper idle states more quickly!
> > > > > 
> > > > > Interesting, another benefit to add to my proposal. :)
> > > > > 
> > > > > > 
> > > > > > > OK, 0.70 is not *that* far off of 0.75.  So what debugging does that
> > > > > > > test have enabled?  Also, if you use tracing (or whatever) to measure
> > > > > > > the typical duration of the scheduling-clock interrupt and related things
> > > > > > > like softirq handlers, does it fit with these numbers?  Such a measurment
> > > > > > > would look at how long it took to get back into userspace.
> > > > 
> > > > Just to emphasize...
> > > > 
> > > > The above calculations show that your measurements are close to what you
> > > > would expect if scheduling-clock interrupts took longer than one would
> > > > expect.  Here "scheduling-clock interrupts" includes softirq processing
> > > > (timers, networking, RCU, ...)  that piggybacks on each such interrupt.
> > > > 
> > > > Although softirq makes the most sense given the amount of time that must
> > > > be consumed, for the most part softirq work is conserved.  which suggests
> > > > that you should also at the rest of the system to check whether the
> > > > reported speedup is instead due to this work simply being moved to some
> > > > other CPU.
> > > > 
> > > > But maybe the fat softirqs are due to some debugging option that Ubuntu
> > > > enabled.  In which case checking up on the actual duration (perhaps
> > > > using some form of tracing) would provide useful information.  ;-)
> > > > 
> > > As a first step i would have a look at perf figures what is going on
> > > during a test run. For such purpose the "perf" tool can be used. As a
> > > basic step it can be run in a "top" mode:
> > > 
> > > perf top -a -g -e cycles:k 
> > > 
> > > Sorry for the noise :)
> > 
> > Yep, I'm planning to do better tests and collect more info (perf,
> > bpftrace). Also making sure that we don't have some crazy debugging
> > config enabled in the Ubuntu kernel, as correctly pointed by Paul. But
> > first of all I need to repeat the tests in a more isolated environment,
> > just to make sure we're looking at reasonable numbers here.
> 
> Very good, and looking forward to seeing what you come up with!
> 
> 							Thanx, Paul

I repeated some tests in a more isolated environment and posted the
results here:
https://discourse.ubuntu.com/t/enable-low-latency-features-in-the-generic-ubuntu-kernel-for-24-04/42255

Highlights:

 - stress-ng --matrix seems quite unpredictable to be used a benchmarks
   in this scenario (the bogo-ops/s are very susceptible to any kind of
   interference, so even if in the long runs NO_HZ_FULL still seems to
   provide some benefits looking at the average, we also need to
   consider that there might be a significant error in the measurements,
   standard deviation was pretty high)

 - fio doing short writes (in page cache) seems to perform like 2x
   better in terms of iops with nohz_full, respect to the other cases
   and it performs 2x slower with large IO writes (not sure why... need
   to investigate more)

 - with lazy RCU enabled hrtimer_interrupt() takes like 2x more to
   return, respect to the other cases (is this expected?)

Let me know if you notice anything odd, if you need more information,
etc.

Thanks,
-Andrea
