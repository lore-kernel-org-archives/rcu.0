Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A66338F40
	for <rcu@vger.kernel.org>; Fri,  9 Jan 2026 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954751; cv=none; b=G+j3gW/252cGFhUzYFcyazbE6I2weN+DjzrBLMQqb0Ix24VFCE8CYXgwwXT5eK5sw6V+ytv3bySVXUAJDFUHoiC45KbA9XTEF4CkslRNmEdly+BvPiJ/eKAwNw9uQ8swdtfU+L6rOSYkzF2N3Pe6LZB+jN42+1IpuOeOt/uOTXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954751; c=relaxed/simple;
	bh=gFUPgCbBYeaMfTkS0TVFCUQOxO9/BSZo6qMziocd14g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQ2RxFvmQ1t4bOvJaJ7HyyBAUrWwLil2O0JDtPpC4Oey1wY2NL/XqZcGzPKMx+QpDcuhoGwA2RqimFaH6ltVDdpyBAxmASsHzefG1EqYeB+FYUmVEjKS9u5gh5uR+eDS4ertzd655eQzHHc8KBlR+9K9VJqmGY6NrrPP/Lzxws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ng8IcLaw; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng8IcLaw"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8bb6a27d3edso407734085a.3
        for <rcu@vger.kernel.org>; Fri, 09 Jan 2026 02:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767954746; x=1768559546; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hoz9vaEG2rzkjBHMKuXghhRwQ4CONX9kiJuqE0jAvds=;
        b=ng8IcLawl2jDGVzRsqh+WD/pgEI+gkLHtvP/RHlIpvxHxZFf4JEhDqo76x0KNIlyY5
         AmYCiY6odudEz20XjB1tA5nkYBouRpY6ZAUdjZGPlDqVBnRDrfy8tnUCGPG0nxkEo9M4
         4q0yIMyNZEoBSiGAbXfeWGizYrR7t/0O5efVPEWjEoUxXablUbSNvBKFvxtnFMeMEZ2A
         8L7zGxhg36/RXm8LcWCYAhY+fOPLDTBOWkYmfA8kwsMUO/TYJl35kSJMJhLrg615Me+p
         4xdlcMbCT+2ZS7fQJKM0u3v9uIX/g1beqC5onY03+dM+tMS+bHwXwSPPFIhTpMB814sg
         ymqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767954746; x=1768559546;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hoz9vaEG2rzkjBHMKuXghhRwQ4CONX9kiJuqE0jAvds=;
        b=J/kwgbqyzd8EUdNi72xJClvUooespW8TELbLk9QY5iM4Y0boL5+I+KvfERxSTIk8Sg
         w8EBPp9CV5qXITvg9CJLkPlwJnAFqj2eytQqwoK5L5nUXvsi+ci7fhnkQU2CGSGaNHTf
         AZ2HikSxsqQEbO81ixkxJp14GD7OEBCdvGuwkCFIe8AI1smtRBVnkqqkcr7YcqRZ5BSL
         ApETbQUPU5JDkURVcmPwRmTwu/uDMFG7q1ZdExgtExwSjHT9DBiLIWLUAoh9aKGOFOkS
         4IYbQGVElOC/CPhMLKOywhoHemZQYoC0giGhSXIdd11n9rOcBBCfHrmQ8xMnf5yQCHZY
         re9g==
X-Forwarded-Encrypted: i=1; AJvYcCUKNanW6/szY2rLf4NEaeGeWVv8h8dCHYO1vO0peJRxC6b/jNbd+BfjA4YkfSy3w7qVTK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsdhV5pWyT3LXWyyUBajK0QNw+rZ/4L12Sr5I1sHqQtRxxPDzt
	iXcMMfZIPr7AH0AFJkYL7NuQw1JtY7jQSpI6qcz8DcPy5lOeKzJgoUkh
X-Gm-Gg: AY/fxX6tEO3gaFKBuq7mLBbR81tRs1ITNs3GfZRnsogzJLDt/YPoblgu0gNGSHxHLiQ
	/301Oneil2WTeCIjYw55dqnEOMoE8eKOsEGtETIq2nq4sgL6OCIffG6oyRKQCYyVDbB367CUqlv
	wy75TiDGtl8sEB4q8EcVEYjAd8Qwo7DJVBSDZjNWY0BZe4BzeGwqDjMDlsaeLo9Ck2eAcBUj1NG
	btzsdwIoa+BqvUIqC6me3tPQ3Tsz9TJudk4kNdAO4b85CM6GrNuFdVmZYmh0D87eQ4fmILy/i6e
	55N3lCYYNrb7UXm4osmiBknqDa3GtqjaU0XbJv4uRVk+tNKpwKa1zSJpQOd/l6UHKsSxYZfKPgN
	WMozFIiQlsMw0URN/nGVDgmrRIv63ch6Bwduret2/HlpnTb5VIYaz5WCnMaMtulcr81sOVe2lR3
	PYTmP4h2J22Oi6Jxm7TnYObRNQiW60XMoFedhQfLPF5am28pN+oFWAEFPNUrYsETTmM45tszxe4
	TjcqVHu/J/ob+U=
X-Google-Smtp-Source: AGHT+IFZBBtDve+r17mYMFKXP+3O3XqOe1xEDBH+49zQtecPABdiNb07uUKveccCfOBazCnuzwa/tQ==
X-Received: by 2002:a05:620a:2a0b:b0:892:63c8:2861 with SMTP id af79cd13be357-8c3893bc3f4mr1261352985a.40.1767954746292;
        Fri, 09 Jan 2026 02:32:26 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907724ee7asm70781156d6.39.2026.01.09.02.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 02:32:25 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id BDE8CF4006A;
	Fri,  9 Jan 2026 05:32:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 09 Jan 2026 05:32:24 -0500
X-ME-Sender: <xms:ONlgafz-J9i5SIeSzihyDKXkPmVL9w-YbcjFkli_FhSYD-_EitIigw>
    <xme:ONlgac1YIUTPhdjIV1AK-RGZwmryj3Cu0J8-xMCEtWIfBlibDVk38OpAqU8evbGnV
    glcXv61LtYP0sWw0ja7wIhUZzMVg3yr5xSs_vBSzT5NOQFnRAQ90g>
X-ME-Received: <xmr:ONlgaS6FSK_Y_yuDmI1sOQESl5R4HozCGM3HSFdWrseO7yMzR2R3-VRK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeortddttddunecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnheptdevhfefteevieeuteehhfehvdeileevueffteduveeuveeukeevudehheei
    ffeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhgpdhrtghpthhtoh
    epfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgvlhgrghhn
    vghlfhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgpdhrtghpthhtohepuhhr
    vgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumh
    hishdrohhrgh
X-ME-Proxy: <xmx:ONlgaaZGdlM6MprOzszX88LJKw8Dnf_9-qvpWc-p5CtFaetMxSdODA>
    <xmx:ONlgaYRU2Vcn1LB4mHMn_WFInnyNv_potScD8PFT7S24EBSRtcfqtg>
    <xmx:ONlgafLfjdywNLRYR3oSz73_2DcwHj_B-c5HA6Y2bsvtCMh1CWOeYw>
    <xmx:ONlgaeUDs35cPTqphfyt54-krowm4PNsYpdPg0bUX7WUVJ2ugYTB9A>
    <xmx:ONlgabjkDDHPSTvcqAnE0DtheHYstkqgKp1Zp2lPdaECr9CoyjMZqum1>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 05:32:24 -0500 (EST)
Date: Fri, 9 Jan 2026 18:32:22 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH -next 3/8] rcu/nocb: Remove unnecessary WakeOvfIsDeferred
 wake path
Message-ID: <aWDZNnIckOHZDolF@tardis-2.local>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
 <20260101163417.1065705-4-joelagnelf@nvidia.com>
 <aV_T5kLzX2qMpxpt@localhost.localdomain>
 <20260109013911.GA1102915@joelbox2>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109013911.GA1102915@joelbox2>

On Thu, Jan 08, 2026 at 08:39:11PM -0500, Joel Fernandes wrote:
> On Thu, Jan 08, 2026 at 04:57:26PM +0100, Frederic Weisbecker wrote:
> > Le Thu, Jan 01, 2026 at 11:34:12AM -0500, Joel Fernandes a écrit :
> > > @@ -974,8 +959,7 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp_gp,
> > >  		return false;
> > >  	}
> > >  
> > > -	ndw = rdp_gp->nocb_defer_wakeup;
> > > -	ret = __wake_nocb_gp(rdp_gp, rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
> > > +	ret = __wake_nocb_gp(rdp_gp, rdp, false, flags);
> > 
> > The force parameter can now be removed, right? (same applies to wake_nocb_gp()).
> > 
> > Other than that:
> > 
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Ah true! Thanks, so the following hunk needs to be squashed into the patch
> then, with the review tag. Boqun, if you want to do that please do, or I can
> send it again for the next merge window.
> 

We still have time for this merge window, but I see there is still
reviewing going on for other patches, maybe you could resend these 3
patches once we reach agreement, and then we can decide which merge
window. Thoughts?

Regards,
Boqun

> ---8<-----------------------
> 
> From: "Joel Fernandes" <joelagnelf@nvidia.com>
> Subject: [PATCH] fixup! rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake
>  path
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/tree.c      |  2 +-
>  kernel/rcu/tree.h      |  2 +-
>  kernel/rcu/tree_nocb.h | 14 +++++++-------
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 293bbd9ac3f4..2921ffb19939 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3769,7 +3769,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
>  	}
>  	rcu_nocb_unlock(rdp);
>  	if (wake_nocb)
> -		wake_nocb_gp(rdp, false);
> +		wake_nocb_gp(rdp);
>  	smp_store_release(&rdp->barrier_seq_snap, gseq);
>  }
>  
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 653fb4ba5852..7dfc57e9adb1 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -499,7 +499,7 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
>  static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
>  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
>  static void rcu_init_one_nocb(struct rcu_node *rnp);
> -static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
> +static bool wake_nocb_gp(struct rcu_data *rdp);
>  static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  				  unsigned long j, bool lazy);
>  static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index daff2756cd90..c6f1ddecc2d8 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -192,7 +192,7 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
>  
>  static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
>  			   struct rcu_data *rdp,
> -			   bool force, unsigned long flags)
> +			   unsigned long flags)
>  	__releases(rdp_gp->nocb_gp_lock)
>  {
>  	bool needwake = false;
> @@ -225,13 +225,13 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
>  /*
>   * Kick the GP kthread for this NOCB group.
>   */
> -static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
> +static bool wake_nocb_gp(struct rcu_data *rdp)
>  {
>  	unsigned long flags;
>  	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
>  
>  	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
> -	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
> +	return __wake_nocb_gp(rdp_gp, rdp, flags);
>  }
>  
>  #ifdef CONFIG_RCU_LAZY
> @@ -553,7 +553,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
>  					   TPS("WakeLazy"));
>  		} else if (!irqs_disabled_flags(flags)) {
>  			/* ... if queue was empty ... */
> -			wake_nocb_gp(rdp, false);
> +			wake_nocb_gp(rdp);
>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>  					    TPS("WakeEmpty"));
>  		} else {
> @@ -959,7 +959,7 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp_gp,
>  		return false;
>  	}
>  
> -	ret = __wake_nocb_gp(rdp_gp, rdp, false, flags);
> +	ret = __wake_nocb_gp(rdp_gp, rdp, flags);
>  	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DeferredWake"));
>  
>  	return ret;
> @@ -1255,7 +1255,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  		}
>  		rcu_nocb_try_flush_bypass(rdp, jiffies);
>  		rcu_nocb_unlock_irqrestore(rdp, flags);
> -		wake_nocb_gp(rdp, false);
> +		wake_nocb_gp(rdp);
>  		sc->nr_to_scan -= _count;
>  		count += _count;
>  		if (sc->nr_to_scan <= 0)
> @@ -1640,7 +1640,7 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
>  {
>  }
>  
> -static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
> +static bool wake_nocb_gp(struct rcu_data *rdp)
>  {
>  	return false;
>  }
> -- 
> 2.34.1
> 
