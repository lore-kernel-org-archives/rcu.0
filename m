Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00CE4502F;
	Tue, 12 Nov 2024 05:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731390508; cv=none; b=NwumaCY0mqEPpjURuYbIzORfHoOOamnP6XT/gjKs34ApCvw9segRxT+PyULpadtAtYaIe4SpLVKu2ITf0fCxsXtjyNAoMREsxfGT9hyt+qcbJHD8+EKme0HVezY3HnspoCg1M2246Ho1dZuZz/PEQ+lOyHfiYdO93YiIcvXE5S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731390508; c=relaxed/simple;
	bh=NNNdXWGLzUbm9D1B/YjIV69/AsR3ITx0kBkkTgQMo58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwHp/ANTbyW1dUZEbrptB1RVq/v36kSu25bXGyI+D6V+M7S0g/6Ee+6tOhVTAwxckj8GNxgFcePjtMFP31qaew33s8TZ+3pO/gd2RfRGWXjuQbP+Ypu+2T64OMvoQzEVTB9m1hmFDOzAmwdX/P+ZZlNhRE3UZxcsix3pA9Usr/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbWoeR6I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbWoeR6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C74C4CECD;
	Tue, 12 Nov 2024 05:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731390508;
	bh=NNNdXWGLzUbm9D1B/YjIV69/AsR3ITx0kBkkTgQMo58=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=DbWoeR6IYclnUbGJnSqeMd5saGrksmMVx1Nl2cTQ/XM8GIndaADgJ7dwpt+y2Iuog
	 L+yVgLhLMZft7HqCrPvuFBFe80o8aUiLjgaRUzX8rC/muAjjvjVqADcy6arjQhmpWR
	 X4XOtpoeHNhtDjfFtsbH6uIT0ZIMDN+W/tkRLuVrqUMPLbr2H5Rw/5mkHRmZvGH4Cy
	 Uo++7B0XzAI4VCQHSMAb9XksemYVGezzqM3GQfp0gnDyVWXPZRNCzjz1y6/N0mxpTd
	 q6wImLY5D251yG1SzHiKpZR4RZPDqmGrWskC2z/RWwGxUzhheq/i+N8mAKHudZCSvt
	 ZbXPXWEGU2H9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D351BCE0BA3; Mon, 11 Nov 2024 21:48:27 -0800 (PST)
Date: Mon, 11 Nov 2024 21:48:27 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, frederic@kernel.org
Subject: Re: [PATCH rcu 2/3] srcu: Check for srcu_read_lock_lite() across all
 CPUs
Message-ID: <bd8d6204-76d5-4e81-8fbf-830529e5e13d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <bb96e032-4f7d-41bf-a675-81350dca8d0a@paulmck-laptop>
 <20241112013143.1926484-2-paulmck@kernel.org>
 <0b88aca1-fd46-44d0-b114-c6daed1a5a11@amd.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b88aca1-fd46-44d0-b114-c6daed1a5a11@amd.com>

On Tue, Nov 12, 2024 at 08:58:08AM +0530, Neeraj Upadhyay wrote:
> On 11/12/2024 7:01 AM, Paul E. McKenney wrote:
> > If srcu_read_lock_lite() is used on a given srcu_struct structure, then
> > the grace-period processing must to synchronize_rcu() instead of smp_mb()
> 
> s/to/do/

Good eyes, fixed!

> > between the scans of the ->srcu_unlock_count[] and ->srcu_lock_count[]
> > counters.  Currently, it does that by testing the SRCU_READ_FLAVOR_LITE
> > bit of the ->srcu_reader_flavor mask, which works well.  But only if
> > the CPU running that srcu_struct structure's grace period has previously
> > executed srcu_read_lock_lite(), which might not be the case, especially
> > just after that srcu_struct structure has been created and initialized.
> > 
> > This commit therefore updates the srcu_readers_unlock_idx() function
> > to OR together the ->srcu_reader_flavor masks from all CPUs, and
> > then make the srcu_readers_active_idx_check() function that test the
> > SRCU_READ_FLAVOR_LITE bit in the resulting mask.
> > 
> > Note that the srcu_readers_unlock_idx() function is already scanning all
> > the CPUs to sum up the ->srcu_unlock_count[] fields and that this is on
> > the grace-period slow path, hence no concerns about the small amount of
> > extra work.
> > 
> > Reported-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > Closes: https://lore.kernel.org/all/d07e8f4a-d5ff-4c8e-8e61-50db285c57e9@amd.com/
> > Fixes: c0f08d6b5a61 ("srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()")
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/rcu/srcutree.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 70979f294768c..5991381b44383 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -458,7 +458,7 @@ static bool srcu_readers_lock_idx(struct srcu_struct *ssp, int idx, bool gp, uns
> >   * Returns approximate total of the readers' ->srcu_unlock_count[] values
> >   * for the rank of per-CPU counters specified by idx.
> >   */
> > -static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
> > +static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx, unsigned long *rdm)
> >  {
> >  	int cpu;
> >  	unsigned long mask = 0;
> > @@ -468,11 +468,11 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
> >  		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
> >  
> >  		sum += atomic_long_read(&sdp->srcu_unlock_count[idx]);
> > -		if (IS_ENABLED(CONFIG_PROVE_RCU))
> > -			mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
> > +		mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
> >  	}
> >  	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
> >  		  "Mixed reader flavors for srcu_struct at %ps.\n", ssp);
> > +	*rdm = mask;
> >  	return sum;
> >  }
> >  
> > @@ -482,10 +482,11 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
> >   */
> >  static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
> >  {
> > -	bool did_gp = !!(raw_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE);
> > +	unsigned long rdm;
> >  	unsigned long unlocks;
> >  
> > -	unlocks = srcu_readers_unlock_idx(ssp, idx);
> > +	unlocks = srcu_readers_unlock_idx(ssp, idx, &rdm);
> > +	bool did_gp = !!(rdm & SRCU_READ_FLAVOR_LITE);
> 
> Move "did_gp" declaration up?

C now allows this?  ;-)

Fixed!

> Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

And applied all three, again, thank you!

							Thanx, Paul
