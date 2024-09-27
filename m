Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C95A28EF
	for <rcu@vger.kernel.org>; Fri, 27 Sep 2024 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727421998; cv=none; b=mqViC57VdZ4KAPpNJI+DAXc/REFlwwxXEHcfIxRO0j7x1ITQFHazvuNEozLvDtXzPddCuPa/XO4VX1oJKv9q8DP5IceuAFX79LeeAF6XYT+Hc9HlcZaBkfMz8PGgCJVo95Gvguy4urdTmZ8ut75y0CSt9TVF9KOhljKhpBC3p0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727421998; c=relaxed/simple;
	bh=xMgAuIsRbpaGRuJllqDUgSrd+lucxNOpIKVPx5iakck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpYZqqp9Ijh1W7H2hqCF+oCmQNQjuTF6fce9krmmj7fad/CVFmcRSNPoEJQV1GPiZqS7KA2F8Y/KiHdQngVUVIEB6V1xBSfttUm+NIY9YUEzuNN6Icq+rXb0+uXatWLFycq6JbjZLpbeQa47DrULsqtAP8daEFqgHiIbF908UYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TRu/7hJw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TRu/7hJw"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d4093722bso248503366b.0
        for <rcu@vger.kernel.org>; Fri, 27 Sep 2024 00:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727421993; x=1728026793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=80ztDIsJWeriQoGVLSr3JhFbaWjjf3yBIgtVIEKSUh4=;
        b=TRu/7hJwrxUx3wOak5e/c2+oVr4Z3m54883QdSdso5qBSw31X+adwJtycElOCD4Q6v
         /1qASgjKoiXjg11Y+yuLtk8rSVHWLl3WoEfnZj6nZeJebmWRRulcTQmWM1eRomi08Kmy
         1piDNGEUFsS+fExW1zjOO9W/23CkRq9be2YQ/vcM8jh5Yr8mhvV83T81zii5ZfFc9bMX
         NLQQUe4OU/TNG0bkZH9KL0w9MhpzRvgZQfpew9K2P3lK8YoD8A2F+1ZjZ/P47mgtw1qG
         AnNbcwWYK9dbJJ/z3gOKJJRR5XKTiHIUpc24H6lhKhskcy08rrZufIJTKhTfutGgGiS5
         UxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727421993; x=1728026793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80ztDIsJWeriQoGVLSr3JhFbaWjjf3yBIgtVIEKSUh4=;
        b=q8ytZQBV9UIF3+ngOTRJk5pbKFVb5mFHLPQxFDJjDhNi4K5+vQT074n/iKX/8NbNef
         4NUg9O2rg44TqBK1ocfQBIAeyxGV3iUX1Y62gSCOjgi5LuwhDrQcVuzUen7pXOkNH416
         YucDbNSfJ1ODWUOC3iPokAaOBIk7bMYefMoxsmCp4MWdDa40pM05QjvhforDtKrcNE2h
         vkeXR6Hvsn2fBhLCOSciwUv72CDMXaAr6ITPiHi0DDkCKbhTSvXMWMjg/2lqrH/9pfTx
         JKru/uw36R+KgzJZe49hVW+N3tONPSQssGcnQx8jWPqQXlU6kGdf2e9u1Sz2QmUizuIG
         6aOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdSVDSIe3BT1co1hcm8zyl544ofzmCUCf91uh7qq3BkBuvieM1hIZzs67GVrvvS+z8HkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+vpkcIFS/rC+w4q1GKM9iiZUr01iWKMkaUsxOh76f1JEWRtk4
	4YBD493m2NdgwJit8M+Df/drpB0YDhb5DLAZWOoW1mofWLlfl4OpZEL5jHy0ng8=
X-Google-Smtp-Source: AGHT+IE7+CblqEppxGApcOTVpZmHP9GLtTzDm9g1t7gy3vhONmLGIDrJpXglSfFblCwn/uYQ+Ow0Nw==
X-Received: by 2002:a17:906:c115:b0:a86:4649:28e6 with SMTP id a640c23a62f3a-a93c4a98d6amr167324466b.57.1727421993567;
        Fri, 27 Sep 2024 00:26:33 -0700 (PDT)
Received: from localhost (109-81-81-255.rct.o2.cz. [109.81.81.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27776efsm93534866b.30.2024.09.27.00.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 00:26:33 -0700 (PDT)
Date: Fri, 27 Sep 2024 09:26:32 +0200
From: Michal Hocko <mhocko@suse.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 11/20] sched: Handle CPU isolation on last resort
 fallback rq selection
Message-ID: <ZvZeKBzOBbVyA-xL@tiehlicka>
References: <20240926224910.11106-1-frederic@kernel.org>
 <20240926224910.11106-12-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926224910.11106-12-frederic@kernel.org>

On Fri 27-09-24 00:48:59, Frederic Weisbecker wrote:
> When a kthread or any other task has an affinity mask that is fully
> offline or unallowed, the scheduler reaffines the task to all possible
> CPUs as a last resort.
> 
> This default decision doesn't mix up very well with nohz_full CPUs that
> are part of the possible cpumask but don't want to be disturbed by
> unbound kthreads or even detached pinned user tasks.
> 
> Make the fallback affinity setting aware of nohz_full. This applies to
> all architectures supporting nohz_full except arm32. However this
> architecture that overrides the task possible mask is unlikely to be
> willing to integrate new development.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Thanks, this makes sense to me. Up to scheduler maitainers whether this
makes sense in general though.

Thanks for looking into this Frederic!

> ---
>  kernel/sched/core.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 43e453ab7e20..d4b759c1cbf1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3421,6 +3421,21 @@ void kick_process(struct task_struct *p)
>  }
>  EXPORT_SYMBOL_GPL(kick_process);
>  
> +static const struct cpumask *task_cpu_fallback_mask(struct task_struct *t)
> +{
> +	const struct cpumask *mask;
> +
> +	mask = task_cpu_possible_mask(p);
> +	/*
> +	 * Architectures that overrides the task possible mask
> +	 * must handle CPU isolation.
> +	 */
> +	if (mask != cpu_possible_mask)
> +		return mask;
> +	else
> +		return housekeeping_cpumask(HK_TYPE_TICK);
> +}
> +
>  /*
>   * ->cpus_ptr is protected by both rq->lock and p->pi_lock
>   *
> @@ -3489,7 +3504,7 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
>  			 *
>  			 * More yuck to audit.
>  			 */
> -			do_set_cpus_allowed(p, task_cpu_possible_mask(p));
> +			do_set_cpus_allowed(p, task_cpu_fallback_mask(p));
>  			state = fail;
>  			break;
>  		case fail:
> -- 
> 2.46.0

-- 
Michal Hocko
SUSE Labs
