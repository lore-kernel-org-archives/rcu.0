Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67591F60A
	for <rcu@vger.kernel.org>; Mon, 24 Feb 2025 03:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740367291; cv=none; b=DRVY1IPJS0pP8Wjij2ZDxzQmvWIvYlAMba+YM8Jz1DwpWQ4kHSRfs8sEwlxqR6Is1dlRwFkMjZ5FFXEYT7CYmhvv1yk39deBYzwe8oI9DwCQV1yDt8S0MllBG+MHFXqhUe1eqJSOKsvMJ1mxI/kzs7V+7jJkuwn39etquFZICuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740367291; c=relaxed/simple;
	bh=yPYcHc7689Kv1yAmqLrOopWuAopjKHUQiQ5M4366OUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyZerHq6ALofaEHN0X2jqrugAoPmAGGg+9E4CIvdWwF+YgBaWnVCTJlyRQB0DuLUuWEdDRz6ujUZoYf41k1odfeWCxLHX1Bt5p3M2l/L5J2Im1SyfujUkEjMoT6gs2xyGpD4JoSh6Mvml12jqROj3sb9bOvUlv/vWh7tEqj7HpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1qZqLX0; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1qZqLX0"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-471f686642cso36316231cf.2
        for <rcu@vger.kernel.org>; Sun, 23 Feb 2025 19:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740367288; x=1740972088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSkZx7vbBdwiCyic8Zgu9vzr7G8VUQnSYz0b9POKDRM=;
        b=i1qZqLX09qaQmLYTc8yitcKg3E6P5luYAxGv3h0OSrDPmLjiaZ+sdN0/ebFUtY+W5k
         GNVFF025QOvV6h5VwzT/SV39JsfgfejANBqgkfMBuyM1sltdK2UXxc2Y2XZIKJa3Ujw9
         GJA/3uY1DzOHV6wmfl4x5seChi5QFC6+bZKqG5dEP1I+GON30UYDv1mdhgQ7g87CjGES
         XLuSHV6WMn3eSOMt6zoUSFbZdoYu4zjYkOcVpo5uw5vlCgvgkaggc3duoRKY8nWlDX0k
         GRo0kbHEOgTwz1tCW6lnmkrY4Z3XcmtY+LFnZ6dA2uMM47yi7OE/m3NuPGgdsOCqLDh7
         u68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740367288; x=1740972088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSkZx7vbBdwiCyic8Zgu9vzr7G8VUQnSYz0b9POKDRM=;
        b=lLr8tkm3C+tEdbO40CJp9Ovs2e0IJbbmZmnQpMWna5SDGDmdDdqxUggPsMsj2HnBid
         IGu/7nx8/j2+ik9MsDJ8cpY12TcvR82pb7ajoB74fpmofiC+9KRXohGij/dQN+ASlSmE
         bqnqFA7X40AvzLL4iOcLlMzT6xfgiOjuObOweudirb+QmF0oAW4nkvb9t1Wie38AJ2wV
         LiEwws3raG+R0wnQJ2BOam4fbiDh/3NBUCPxq+eQuhkBnJvK3RCPrsxykgYRllg/cRx8
         +XTRMwsJDtNKvEC0btXKBCd/K5kDC1/ZC5qN9JPYl6lMOMXjpO+8tJa0N5KpQ8p8pjA+
         LIGg==
X-Forwarded-Encrypted: i=1; AJvYcCWI0R8XMw1Ydnl06IaZhlZR0tLk8USLUteUcUO4Le4GEsZZwe1HNmCMKzxOObM9LwOnQOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgOEEPB7TTURyt6wT7dO3nP80pRx1F8T0yUbxyQF6b/0l1sYm9
	evwOEsuRNRzSij/Tnd6AvIfzKjYObc5+V32AbZ0HDzeAQ/ptEAaY
X-Gm-Gg: ASbGncuFP6LTgOdJ2efls/TDW8KPQWvFOVApeD+xK6LKvGVtgXik3qc4oXWyGtVTu7U
	PT+NitPzrSmvw71ECGs4JA5daz17YOD36L7CZitstOw5sWOC4SUCDgnFuiEOCu5FRE4LAvulfTI
	Q5+zIXAvD+h8iF9qO+r1sP+ZHa51Ul/GTxEvZxsp2rvDCU0RvkVWy0TC1EoeX9CEldhA656saHv
	E2vxQTcy61UPlR0821ASZg+0fFgx1AjYeo/kowFbUYS31KISZdWM9e5ejW+lkgau+SRpkLvW++k
	hyDUh7M51cDmb+S6SSIYA9UaworUzzeUieuCQWWdWBaYsVXPtu35yt/LIm8E92bCx3TgOGHJTT2
	tMSBfDAbBf6cHIIoZ
X-Google-Smtp-Source: AGHT+IFfFkmrwo+EVskko+g9Igh5n/At7a3mirrhI7pJpepJ9gQk+LNslzpZv+BggmTR1qSbrQmCRg==
X-Received: by 2002:ac8:574e:0:b0:472:133f:93b3 with SMTP id d75a77b69052e-47224923383mr163794591cf.47.1740367288537;
        Sun, 23 Feb 2025 19:21:28 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-472210256d8sm43059381cf.35.2025.02.23.19.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 19:21:28 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 717711200066;
	Sun, 23 Feb 2025 22:21:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 23 Feb 2025 22:21:27 -0500
X-ME-Sender: <xms:t-W7ZxAXlmeklsZuy15O72NEnS92tVvor7FUZXm7G1EyJndUX9vBug>
    <xme:t-W7Z_hNVl7t4J3XnR7fXyguVV85gHOeGDMi0aH48w-pbnPRpHb11SDD-Kg5XwW3u
    XufKEq6QGgLxM7Dwg>
X-ME-Received: <xmr:t-W7Z8lazJxN29QFQk876j5MavP8EMODXCMI4diAOgedjMvDzumCcHidjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfdtjeehuedvkeehuedtudejhfehieethffg
    teehhfeuvdffhfeuleffieeilefhnecuffhomhgrihhnpedtuddrohhrghdpkhgvrhhnvg
    hlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghe
    dtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhes
    fhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopeholhhivhgvrhdrshgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthht
    ohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnkhhurhdrrg
    drrghrohhrrgesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepohgvqdhlkhhpsehlihhs
    thhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprh
    gtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehf
    rhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:t-W7Z7ypwqADtUYP7ukSqts4gpUAHJk1yKu3V3LavAJzJAYAxfZTPw>
    <xmx:t-W7Z2Tx9BSMSlK0tjHCa6_sYBs3GI8pnRjF-Gc_nnHGqIyIsdqOUA>
    <xmx:t-W7Z-Y7Qb4vi2-u-MVb3YBlU10LaQ_QsSPiVr1fmvUnrtcNQmtThA>
    <xmx:t-W7Z3S2PLxkMY5xdUrFxXanrZictxnE4mD1laJM33IIArqY_rUk9w>
    <xmx:t-W7Z0C0ZoWCVJjlnpi8dBfY6WzexJiqZfXNv877lEIr4vA6JCjZlKNl>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 22:21:26 -0500 (EST)
Date: Sun, 23 Feb 2025 19:21:25 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Oliver Sang <oliver.sang@intel.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [linux-next:master] [rcu]  c9b55f9da0:
 WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_one_extend_check[rcutorture]
Message-ID: <Z7vltauHgdSdo7Ui@Mac.home>
References: <202502171415.8ec87c87-lkp@intel.com>
 <08e755d1-9f7d-4238-ac2d-1869d68a8ddc@paulmck-laptop>
 <Z7gkXQMxTc2J4KQ9@xsang-OptiPlex-9020>
 <64d58e80-3601-4f9b-ae46-756dd124345f@paulmck-laptop>
 <Z7vXylQt2yR6HCa6@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7vXylQt2yR6HCa6@xsang-OptiPlex-9020>

I finally find why I cannot reproduce this, I accidentally used
next.2025.02.10a to build the kernel first, which has commit
("rcutorture: Move RCU_TORTURE_TEST_{CHK_RDR_STATE,LOG_CPU} to bool"),
which changes Kconfig RCU_TORTURE_TEST_CHK_DRD_STATE into a bool and
that disabled the test... (because config from you has it as =m).

On Mon, Feb 24, 2025 at 10:22:02AM +0800, Oliver Sang wrote:
> hi, Paul,
> 
> On Fri, Feb 21, 2025 at 05:02:51PM -0800, Paul E. McKenney wrote:
> 
> [...]
> 
> > > > 
> > > > And rcutorture's WARN_ON() has a bug that is exposed by that change
> > > > in Kconfig option.  Does the patch shown below help?
> > > 
> > > the patch does not fix the WARNING in our tests. attached one dmesg FYI.
> > 
> > Just to make sure that I understand, this patch was applied against this
> > commit, correct?
> > 
> > c9b55f9da0d2 ("rcu: limit PREEMPT_RCU configurations")
> > 
> > I am guessing this based on this dmesg line:
> > 
> >  [  109.553307][  T781] CPU: 1 UID: 0 PID: 781 Comm: rcu_torture_rea Tainted: G                T  6.14.0-rc1-00007-gc9b55f9da0d2 #1
> 
> above line is not from the dmesg I attached in last mail. it's from
> https://download.01.org/0day-ci/archive/20250217/202502171415.8ec87c87-lkp@intel.com/dmesg.xz
> which is for our original report.
> 
> > 
> > Is this really the case, or am I confused?
> 
> we applied your patch as:
> 
> 89519085afdf2 fix for c9b55f9da0 from Paul
> c9b55f9da0d2c rcu: limit PREEMPT_RCU configurations
> f001b7165def8 osnoise: provide quiescent states
> 
> so in the dmesg I attached in last mail (I attached it again in this mail):
> 
> [    0.000000][    T0] Linux version 6.14.0-rc1-00008-g89519085afdf (kbuild@9871be4fdbcc) (gcc-12 (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT Fri Feb 21 00:34:02 CST 2025
> ...
> [  117.463907][  T812] CPU: 1 UID: 0 PID: 812 Comm: rcu_torture_rea Tainted: G                T  6.14.0-rc1-00008-g89519085afdf #1
> 
> the change of this 89519085afdf2 is as [1]
> 
> I'm not sure if it's better to upload dmesg for fix patch to
> https://download.01.org/0day-ci/archive/20250217/202502171415.8ec87c87-lkp@intel.com
> again, so I did not do that. sorry if this causes confusion.
> 
> not sure if this is the correct applyment? thanks
> 
> [1]
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index d26fb1d33ed9a..de85a88810cf6 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1873,6 +1873,8 @@ static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
>  #define ROEC_ARGS "%s %s: Current %#x  To add %#x  To remove %#x  preempt_count() %#x\n", __func__, s, curstate, new, old, preempt_count()
>  static void rcutorture_one_extend_check(char *s, int curstate, int new, int old, bool insoftirq)
>  {
> +       int mask;
> +
>         if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE))
>                 return;
> 
> @@ -1902,8 +1904,10 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
>         WARN_ONCE(cur_ops->extendables &&
>                   !(curstate & (RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED)) &&
>                   (preempt_count() & PREEMPT_MASK), ROEC_ARGS);
> -       WARN_ONCE(cur_ops->readlock_nesting &&
> -                 !(curstate & (RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2)) &&
> +       mask = RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2;
> +       if (IS_ENABLED(CONFIG_PREEMPT_RCU))

Now look into this, I think this should be:

	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))

because:

*	For preemptible RCU, ->readlock_nesting() will return 
	rcu_preempt_depth()

*	For non-preemptible RCU, ->readlock_nesting() will return
	preempt count.

, which means if RCUTORTURE_RDR_PREEMPT or RCUTORTURE_RDR_SCHED is in
the curstate for *non-preemption RCU*, ->readlock_nesting() will be >0.
That is, the "mask" needs to consider _PREEMPT and _SCHED for
*non-preemption RCU*, not preemptible RCU.

Paul? Did I get it right?

Regards,
Boqun

> +               mask |= RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
> +       WARN_ONCE(cur_ops->readlock_nesting && !(curstate & mask) &&
>                   cur_ops->readlock_nesting() > 0, ROEC_ARGS);
>  }
> 
> 
> 
> > 
> > 							Thanx, Paul
> > 
> > > > Either way, thank you for your testing efforts!
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > commit bb638fe1a683316397d5517cb7d1797d70d21c86
> > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > Date:   Wed Feb 19 08:41:11 2025 -0800
> > > > 
> > > >     rcutorture: Update rcutorture_one_extend_check() for lazy preemption
> > > >     
> > > >     The rcutorture_one_extend_check() function's last check assumes that
> > > >     if cur_ops->readlock_nesting() returns greater than zero, either the
> > > >     RCUTORTURE_RDR_RCU_1 or the RCUTORTURE_RDR_RCU_2 bit must be set, that
> > > >     is, there must be at least one rcu_read_lock() in effect.
> > > >     
> > > >     This works for preemptible RCU and for non-preemptible RCU running in
> > > >     a non-preemptible kernel.  But it fails for non-preemptible RCU running
> > > >     in a preemptible kernel because then RCU's cur_ops->readlock_nesting()
> > > >     function, which is rcu_torture_readlock_nesting(), will return
> > > >     the PREEMPT_MASK mask bits from preempt_count().  The result will
> > > >     be greater than zero if preemption is disabled, including by the
> > > >     RCUTORTURE_RDR_PREEMPT and RCUTORTURE_RDR_SCHED bits.
> > > >     
> > > >     This commit therefore adjusts this check to take into account the case
> > > >     fo non-preemptible RCU running in a preemptible kernel.
> > > >     
> > > >     Reported-by: kernel test robot <oliver.sang@intel.com>
> > > >     Closes: https://lore.kernel.org/oe-lkp/202502171415.8ec87c87-lkp@intel.com
> > > >     Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> > > >     Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > >     Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > >     Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > 
> > > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > > index 895a27545ae1e..0f446ff04eda1 100644
> > > > --- a/kernel/rcu/rcutorture.c
> > > > +++ b/kernel/rcu/rcutorture.c
> > > > @@ -1981,6 +1981,8 @@ static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
> > > >  #define ROEC_ARGS "%s %s: Current %#x  To add %#x  To remove %#x  preempt_count() %#x\n", __func__, s, curstate, new, old, preempt_count()
> > > >  static void rcutorture_one_extend_check(char *s, int curstate, int new, int old, bool insoftirq)
> > > >  {
> > > > +	int mask;
> > > > +
> > > >  	if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE))
> > > >  		return;
> > > >  
> > > > @@ -2010,8 +2012,10 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
> > > >  	WARN_ONCE(cur_ops->extendables &&
> > > >  		  !(curstate & (RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED)) &&
> > > >  		  (preempt_count() & PREEMPT_MASK), ROEC_ARGS);
> > > > -	WARN_ONCE(cur_ops->readlock_nesting &&
> > > > -		  !(curstate & (RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2)) &&
> > > > +	mask = RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2;
> > > > +	if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> > > > +		mask |= RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
> > > > +	WARN_ONCE(cur_ops->readlock_nesting && !(curstate & mask) &&
> > > >  		  cur_ops->readlock_nesting() > 0, ROEC_ARGS);
> > > >  }
> > > >  
> > > > 
> > 
> > 


