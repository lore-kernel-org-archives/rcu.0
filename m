Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB951991B;
	Tue,  8 Sep 2026 23:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911283; cv=none; b=pdOwQKwYVTLvfYc5hk92bDC/kss7fyXwd1LlNYrwdHMdZlKIEME8Y6B4wJakMGHJaYMgTyzbxIO0nhhzR+8QqvS1v5jswd26kcyhEK5Vk9sB5NwR3++bYFk80uOGRD+EQ0QsKKTF9vU4v3nt8dDtGlbivkiXt1lqorapd03EBsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911283; c=relaxed/simple;
	bh=FzvlGRQhejKMTkUh4Bkunnw/4ypQNfEqgaCdxO/U/cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8LhFf8O5U+QLKfgMUyw3iW1Ib16v8Eny7iS/MUwDmAfFVM7+oRZeAv0wgOHKAeUGcmr63a5zwz9TZ4TvT/NWNE6rrESGuTQnGO5qEuDtgfs842Sdn9PXjU1kY8gqa4XPA8cm8bgMF02BaxyZO6aDsG6lKpMiocXSGQbE8vzfEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7s6L9L0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7s6L9L0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF4C1F00A3A;
	Tue,  8 Sep 2026 23:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788911281;
	bh=vyjyImdOzdF/GSbm9WnhH4n21DaQ9ZcIgRSOPqYcwWU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=S7s6L9L0pHmFXgyusiO3Xr41hGDbdydMoaTiVQZjl50rY0r9nQI5QX2Gyh1BLTT93
	 MJ1D0CxTpTclcVTSfRbLbnDLHy43gJpsSbADBu2eUbREInKlGkze1EryEnIeQT+sXO
	 LA2tr8WIg6nVEnML1IWl4Ut7/entH+E6xJVmPjNcINhmijSAHxebBnVcfmP2lUhXWZ
	 B4yGbxleUjbPn+SVWkLVvw31YsSkWWqEGfIggHMXkmm7YXRyvRFlkCKcb94N8ZpQpc
	 LNaom5kXabDVix+xwv88yHAFj54XRiv04G45ZglxaLQsalZataTe+EkOcUvmRIoDa3
	 ABPIxw89vjzxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 59422CE18F4; Tue,  8 Sep 2026 16:48:01 -0700 (PDT)
Date: Tue, 8 Sep 2026 16:48:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] rcutorture: Disable srcu_expedite_current() for
 atomic SRCU
Message-ID: <25fdd81b-f16d-4eae-9dd0-3a6300308585@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
 <20260907075829.2073224-10-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907075829.2073224-10-kunwu.chan@linux.dev>

On Mon, Sep 07, 2026 at 03:58:25PM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> srcu_expedite_current() is now forbidden for atomic SRCU, so null out
> ->exp_current in srcu_torture_init_forbidden_apis().
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

And you got the testing end as well, very good, thank you!  I have
again folded this into the original with attribution in the name of
bisectability.

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index a9672fe88cbc..d795e07a12ad 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -721,6 +721,7 @@ static void srcu_torture_init_forbidden_apis(void)
>  	cur_ops->call = NULL;
>  	cur_ops->cb_barrier = NULL;
>  	cur_ops->deferred_free = NULL;
> +	cur_ops->exp_current = NULL;
>  	cur_ops->start_gp_poll = NULL;
>  }
>  
> -- 
> 2.43.0
> 
