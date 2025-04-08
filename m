Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1CC1DA60F;
	Tue,  8 Apr 2025 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145916; cv=none; b=jlex5tRoh3GCJUMJD/YwZjKaEGNYEnJJelkG4AVMlWrbhICQlO+ZnSMiRdRwd8FK9y7J4Tte7mAqvLNpTNR5eRM+5RLrDFQZi/o1sqHDmIGP08GoLsf7rvbGaoUnNnodio1AG0JxZjBc9brfmY9NrcWbl+mcj7c+EhXmm8zwa54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145916; c=relaxed/simple;
	bh=bmD2laFYlLFaaNRCLWOZfiKH3pLHNfWxDOxL25EAenk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYsDRkLOkRVyPF8uSDN74dzViKOdYJ78a+C0Uxwo3wpi7+aHIu0jd8fiFcGStK12OnO3RSwoUxJpbA3bEcFIRkPMDmId0yg/CszqfWnF+LGAHEwA1wO9+/LgZiSb41P+fZLla9rtWfHWCcs2BWS/IgU246Oh88wLxTKudkEUXrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sL0fMtAr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sL0fMtAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6997C4CEE5;
	Tue,  8 Apr 2025 20:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744145915;
	bh=bmD2laFYlLFaaNRCLWOZfiKH3pLHNfWxDOxL25EAenk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=sL0fMtArYUPodhKywizC6P5f3M6qwxRNqn1U1l0chFdGQ/JSNvvCbWGRmV4njm3Za
	 l0qtfJOajINqVWXLCn1awpdDeTzXNE1PufLZkakEqO55pYhuuf4+IocihHLavuVKsn
	 gi/sBpYU4fjpqGXW+w5Y83GAGUeUdhzMcjh0gQv1qUCzeXCwAxKIATIl9U2avcX9Da
	 BYF7dI9o3RbcPwaITKzGqMnFYx8ejBov4WiHpQJuFEDIp3ZoDymhgBvWQHP84JlqlU
	 2NNfC0AFm5FkoANE3b2Y6R/M1+T7eTPSWxCsEw+b/hgzLoHZeknWQFm1cdnKbo+SF/
	 4RvtU5bwKp0Dw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 62636CE0F64; Tue,  8 Apr 2025 13:58:35 -0700 (PDT)
Date: Tue, 8 Apr 2025 13:58:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu <rcu@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	kernel-team <kernel-team@meta.com>, rostedt <rostedt@goodmis.org>
Subject: Re: [v2,05/12] rcutorture: Add tests for SRCU up/down reader
 primitives
Message-ID: <8ee04d0a-dc22-4eb1-8c22-1777f94fd9fb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250331210314.590622-5-paulmck@kernel.org>
 <174414348524.117.7223153072511748144@patchwork.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174414348524.117.7223153072511748144@patchwork.local>

On Tue, Apr 08, 2025 at 08:18:05PM -0000, Joel Fernandes wrote:
> Hello, Paul,
> 
> On Tue, 8 Apr 2025 20:16:08 GMT, "Paul E. McKenney" wrote:
> > This commit adds a new rcutorture.n_up_down kernel boot parameter
> > that specifies the number of outstanding SRCU up/down readers, which
> > begin in kthread context and end in an hrtimer handler.  There is a new
> > kthread ("rcu_torture_updown") that scans an per-reader array looking
> > for elements whose readers have ended.  This kthread sleeps between one
> > and two milliseconds between consecutive scans.
> > 
> > [ paulmck: Apply kernel test robot feedback. ]
> > [ paulmck: Apply Z qiang feedback. ]
> > 
> [...]
> > +	for (i = 0; i < n_up_down; i++) {
> > +		init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors, rand);
> > +		hrtimer_init(&updownreaders[i].rtorsu_hrt, CLOCK_MONOTONIC,
> > +			     HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
> 
> This will now fail to build and needs the following: I will squash it into my
> for-next branch into this patch, but let me know if you prefer to provide an
> update.

Please feel free to squash it in with your "[]" tag like shown above.

As you say, you will be sending them all out soon enough anyway.  ;-)

My plan is to rebase on your stack once you finish your first long-form
round of testing.

							Thanx, Paul

>     Fix build error by converting hrtimer_init to hrtimer_setup, see:
>     https://lore.kernel.org/all/174384280127.31282.2714486346304643188.tip-bot2@tip-bot2/
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 4f0a00a8bdee..14a22ef3b56f 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -2480,9 +2480,8 @@ static int rcu_torture_updown_init(void)
>         }
>         for (i = 0; i < n_up_down; i++) {
>                 init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors, rand);
> -               hrtimer_init(&updownreaders[i].rtorsu_hrt, CLOCK_MONOTONIC,
> -                            HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
> -               updownreaders[i].rtorsu_hrt.function = rcu_torture_updown_hrt;
> +               hrtimer_setup(&updownreaders[i].rtorsu_hrt,
> rcu_torture_updown_hrt, CLOCK_MONOTONIC,
> +                             HRTIMER_MODE_REL | HRTIMER_MODE_SOFT);
>                 torture_random_init(&updownreaders[i].rtorsu_trs);
>                 init_rcu_torture_one_read_state(&updownreaders[i].rtorsu_rtors,
>                                                 &updownreaders[i].rtorsu_trs);
> 
> Thanks.
