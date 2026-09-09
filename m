Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A17235957;
	Wed,  9 Sep 2026 00:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788912410; cv=none; b=qSk2KREQeMcEs98U3Ng50wzkSEurQiBjb+NrZxeVGFmDEphZD8IsbElxwDy1mcZ5C2TxSZ/eA38gnecblMVUZsqLhnNRKreWvhAszIzBU2lxmHceraiadNOgWd7JksFyhujMgTMBHGfQoPl7zvRA6BaqEI3yXYnKucd7OdLMteA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788912410; c=relaxed/simple;
	bh=juKFm/1JN7QV05Hb3rl/5WD6wJNhN4CvNwm8NgfVbwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVVBjP6tBObnvmqPW58bdjQbCsVIDmBXM9oayWeZjeF90/GE9irb4HrOqwBCLeyz1/43J6QbeDDsPy6kRkELI7Z688dNj50nnz0+JcdElud5F31/MhaQbiLKzEZdT+fhsS5ugKkStRrEi35u9G5OdzMqRWbnRavqfsGoriMPVFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b83pCAPA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b83pCAPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9C71F00A3A;
	Wed,  9 Sep 2026 00:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788912409;
	bh=y/8n3hL9BgiOsN82LR3RpgTXRundN3xyANlTZFFJFKg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=b83pCAPAiSJS+qQcjx0vFXRL75ZZGEV1hJoYqIoRzDH2pyp1MBZmmYbotrTp74Avb
	 oLw2Pdwv+bdLi7Oc6oGW0/ypszbbQ7cq97jOdEjH2F+v3OU7bOpycPj8/tDWgg5ZFC
	 1w/P/TUVzU3qRaVbvTKuZRovqhOFtUNifvjAqC8GaSTt4TkXGby4eMxQtHlWVosuPN
	 /MwNwSRZwlXqV7FPTVcN8z2qResVoVRnYqNKJ0nRtSQ2IMdSvpk31Ct8RQcCu85PQM
	 K4dYucPF8Ctm9Wx442riHHmXw/H+q1jC/rsVCFZi9vNNt9IpTmOWkJno7QQs0B/1z+
	 yc7crO5mM1V4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E5602CE18F4; Tue,  8 Sep 2026 17:06:48 -0700 (PDT)
Date: Tue, 8 Sep 2026 17:06:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] srcutree: Remove debug pr_alert()s
Message-ID: <0cca667b-ab3e-471e-b9d5-14f34e9feafd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <20260907075829.2073224-13-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907075829.2073224-13-kunwu.chan@linux.dev>

On Mon, Sep 07, 2026 at 03:58:28PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> Remove the debug pr_alert()s from srcu_gp_start() and
> synchronize_srcu_atomic().
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Good point, we have gotten beyond where this debug code would be useful
(famous last words!).  I have folded this into the original commit with
attribution to prevent "&&&&" confusion.

							Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index a93bf803e2f7..a016c93d65cb 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -916,7 +916,6 @@ static void srcu_gp_start(struct srcu_struct *ssp)
>  {
>  	int state;
>  
> -	/*&&&&*/pr_alert("%s() start: ->srcu_gp_seq: %lx ->srcu_gp_seq_needed: %lx\n", __func__, ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed);
>  	lockdep_assert_held(&ACCESS_PRIVATE(ssp->srcu_sup, lock));
>  	WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed));
>  	WRITE_ONCE(ssp->srcu_sup->srcu_gp_start, jiffies);
> @@ -2152,7 +2151,6 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
>  	// OK, we really have to do it ourselves.  Start the grace period.
>  	non_block_start();  // We must not voluntarily block!
>  	smp_store_release(&sup->srcu_gp_seq_needed, srcu_state); // See srcu_funnel_gp_start().
> -	/*&&&&*/pr_alert("%s() start: ->srcu_gp_seq: %lx ->srcu_gp_seq_needed: %lx\n", __func__, ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed);
>  	ASSERT_EXCLUSIVE_WRITER(ssp->srcu_sup->srcu_gp_seq);
>  	srcu_gp_start(ssp);
>  	raw_spin_unlock_irq_rcu_node(sup);
> @@ -2208,7 +2206,6 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
>  		cpu_relax();
>  		srcu_advance_state(ssp, true);
>  	}
> -	/*&&&&*/pr_alert("%s() end: ->srcu_gp_seq: %lx ->srcu_gp_seq_needed: %lx\n", __func__, ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed);
>  	ASSERT_EXCLUSIVE_WRITER(sup->srcu_atomic_gp_flag);
>  	atomic_set_release(&sup->srcu_atomic_gp_flag, 0);
>  	preempt_enable();
> -- 
> 2.43.0
> 
