Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0961C244EAB;
	Tue,  8 Apr 2025 22:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744150881; cv=none; b=gVQwrzVUvZLCKvtvbGKKZV09SxSQYyHkn+yIFebWlAfWzyHzvcqZS+7XdZYsFVJ7kvq6NHFfnuHIlBU+Ef6VAetNGM1CiOwOE04+wKek7UWbPAW4lttJ9CUGNoJll5/sp3+Rb3X1vjWTelm/6Kw/IWh1OQtF08PTOV1rpg3ZQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744150881; c=relaxed/simple;
	bh=NWS839TG5Vm1Sg8n5S04N6bKuX4zID63zZ78pUCvvL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7nSYAudn+iENd82f0XYbGcvpSiB3ypET6JdAu+Oe5L3Uc9554J01tINutACA4S9Mx9Z5sYHdDiFHUQ17U9XDyZqO0ex1J4z3aedfJKXOPzV9FrCfGuSXsqDGix0uKCDie3/fg8ImjMTuVGK+50Gw8djMOv3fCupcOoFm4ISOJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X03YeStb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X03YeStb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79550C4CEE5;
	Tue,  8 Apr 2025 22:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744150880;
	bh=NWS839TG5Vm1Sg8n5S04N6bKuX4zID63zZ78pUCvvL4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=X03YeStbBBdBcw/7vH+TFlmxL4s+Vjn/K4Mj7/fX068keMlogIoeKATjU4NayOMtV
	 uNBL7Xt2VI50aITx/ayf/FSJKTv4zSvzTYNAfDIeUOd3BcmHNbn2klbbh0169PU3n/
	 2axzYLTr6b+GcvKyNBMpMCgLuj4U/laVJrm+/9k/adkiCxgwQTEB27SbqC5Q0CLV06
	 xf01q6Plvzx/JvH3SGOwXQ2OgKsrsYMtHKwIb7Ww0hmeA4p76cCNNEN40IYadS2xqE
	 mbLgnlI8PxwOCY4QyIRlRx+AZGGPfVRVN7GiKtewmVhh6skfXnnz1T74KEytfcnaUd
	 kB6Mldc8T8plg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 220A7CE0F64; Tue,  8 Apr 2025 15:21:20 -0700 (PDT)
Date: Tue, 8 Apr 2025 15:21:20 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu <rcu@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	kernel-team <kernel-team@meta.com>, rostedt <rostedt@goodmis.org>
Subject: Re: [v2,05/12] rcutorture: Add tests for SRCU up/down reader
 primitives
Message-ID: <6fddad7f-0d07-4d41-a8a1-3445c873ea9a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250331210314.590622-5-paulmck@kernel.org>
 <174414348524.117.7223153072511748144@patchwork.local>
 <8ee04d0a-dc22-4eb1-8c22-1777f94fd9fb@paulmck-laptop>
 <702640f3-170c-41be-861c-7ec436a02dad@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <702640f3-170c-41be-861c-7ec436a02dad@nvidia.com>

On Tue, Apr 08, 2025 at 06:05:19PM -0400, Joel Fernandes wrote:
> 
> 
> On 4/8/2025 4:58 PM, Paul E. McKenney wrote:
> > On Tue, Apr 08, 2025 at 08:18:05PM -0000, Joel Fernandes wrote:
> >> Hello, Paul,
> >>
> >> On Tue, 8 Apr 2025 20:16:08 GMT, "Paul E. McKenney" wrote:
> >>> This commit adds a new rcutorture.n_up_down kernel boot parameter
> >>> that specifies the number of outstanding SRCU up/down readers, which
> >>> begin in kthread context and end in an hrtimer handler.  There is a new
> >>> kthread ("rcu_torture_updown") that scans an per-reader array looking
> >>> for elements whose readers have ended.  This kthread sleeps between one
> >>> and two milliseconds between consecutive scans.
> >>>
> >>> [ paulmck: Apply kernel test robot feedback. ]
> >>> [ paulmck: Apply Z qiang feedback. ]
> >>>
> >> [...]
> >>> +	for (i = 0; i < n_up_down; i++) {
> >>> +		init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors, rand);
> >>> +		hrtimer_init(&updownreaders[i].rtorsu_hrt, CLOCK_MONOTONIC,
> >>> +			     HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
> >>
> >> This will now fail to build and needs the following: I will squash it into my
> >> for-next branch into this patch, but let me know if you prefer to provide an
> >> update.
> > 
> > Please feel free to squash it in with your "[]" tag like shown above.
> 
> Yep done already. :-)
> 
> > 
> > As you say, you will be sending them all out soon enough anyway.  ;-)
> 
> True. ;-)
> 
> > 
> > My plan is to rebase on your stack once you finish your first long-form
> > round of testing.
> 
> Perfect, my first long-form test should be done by tomorrow AM.

Very good, I have fired off overnight tests on v6.15-rc1.  Perhaps a
bit more than overnight in one case.  ;-)

							Thanx, Paul

> >>     Fix build error by converting hrtimer_init to hrtimer_setup, see:
> >>     https://lore.kernel.org/all/174384280127.31282.2714486346304643188.tip-bot2@tip-bot2/
> >>
> >> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> >> index 4f0a00a8bdee..14a22ef3b56f 100644
> >> --- a/kernel/rcu/rcutorture.c
> >> +++ b/kernel/rcu/rcutorture.c
> >> @@ -2480,9 +2480,8 @@ static int rcu_torture_updown_init(void)
> >>         }
> >>         for (i = 0; i < n_up_down; i++) {
> >>                 init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors, rand);
> >> -               hrtimer_init(&updownreaders[i].rtorsu_hrt, CLOCK_MONOTONIC,
> >> -                            HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
> >> -               updownreaders[i].rtorsu_hrt.function = rcu_torture_updown_hrt;
> >> +               hrtimer_setup(&updownreaders[i].rtorsu_hrt,
> >> rcu_torture_updown_hrt, CLOCK_MONOTONIC,
> >> +                             HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
> >>                 torture_random_init(&updownreaders[i].rtorsu_trs);
> >>                 init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors,
> >>                                                 &updownreaders[i].rtorsu_trs);
> >>
> >> Thanks.
> 
