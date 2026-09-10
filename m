Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13433A7595;
	Thu, 10 Sep 2026 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059239; cv=none; b=m8nuaTTnfYwJVhdpggUTBKNqunWaNz/3xDb3+hHs+kCRYIImY5YU3mQPNeVCHJpHZqSHniJHkU4KWJQvjgyVCR0MU39wSjatqTYilexBchFdsDB347eD2EMTlzsS16JBKwWQ2jIMRQ/rB2B2n+i9wi8x/JrGQWcYEAcELTn9lnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059239; c=relaxed/simple;
	bh=EwIRQiZDeP9jcV48+fYK33i7Q5nXsKkdVDUb7jfVuOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5oDpJndh4UoUO9aXJiOduElbAQFV1J/HF6Qm2wSQQRQJLNzrNbJFvbLN1dV1KMIhHrCzaMW105BqRbV3yKe3ZpfXQ3kfH/YHuVHynDtGVhHlHSuOP2IeZZOi/GNLf/KwQW/xE0t/6y8ep7x9/WkCgbl7GzZN1ddrOcTyEigt9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dx7dR1rA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dx7dR1rA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9731F000FF;
	Thu, 10 Sep 2026 16:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789059238;
	bh=FD5nXIMiPV61lrBrD1d8yCN+4eakWsm2ZBfangVEUH0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=dx7dR1rA/DDXLi/TrzG0ESyFYTXbo3jwILMZ5NG1Gcim0UPTtGZeNtXM0uwDrCgaa
	 8t7+aUyn/5GiYVHvC+63Qqagqf470nm9j0JtJ/MkHwTDKng0zkRsPY1Fms4uXtkDfc
	 cg12B0q+65vMn1ZmGBn5C0sd93PefkwldGHYVvUyPyYQpuEMm5gmpV3iir5CoFOZRw
	 ZoBzwEcVhZO3vOAFPi3Nq2ZbxrpL1W55WShcakk9RLeBZIQv2vf2SCusufrHMKtzze
	 eJmMiv5bXl5SmfD7X2E5GoXv0H2dnrK0rAS7oMoWMo2fLjYqU3FAoMSKmDMlPET8Ox
	 BEa8ag5bxaUyw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 27436CE1580; Thu, 10 Sep 2026 09:53:58 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:53:58 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcutree: Skip torture to-big transition for atomic SRCU
Message-ID: <8d55847a-9e4d-4f1e-95bc-4dc77bea73c3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260910041427.3579817-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910041427.3579817-1-kunwu.chan@gmail.com>

On Thu, Sep 10, 2026 at 12:14:27PM +0800, Kunwu Chan wrote:
> Atomic SRCU does not use the srcu_node combining tree.  Exclude it
> from the SRCU_SIZING_IS_TORTURE() transition in
> srcu_torture_stats_print().
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> ---
>  kernel/rcu/srcutree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index d462102c6bb6..99d11fb4123a 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -2421,7 +2421,7 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
>  		}
>  		pr_cont(" T(%ld,%ld)\n", s0, s1);
>  	}
> -	if (SRCU_SIZING_IS_TORTURE())
> +	if (SRCU_SIZING_IS_TORTURE() && ssp->srcu_reader_flavor != SRCU_READ_FLAVOR_ATOMIC)
>  		srcu_transition_to_big(ssp);
>  }

Much better, thank you!

Could you also please add an "else" clause with a WARN_ON_ONCE()
for ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC?

This is after all a user error where someone said to torture atomic SRCU
but also said to transition to big.

							Thanx, Paul

>  EXPORT_SYMBOL_GPL(srcu_torture_stats_print);
> -- 
> 2.43.0
> 
