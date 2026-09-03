Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C55C448B8A;
	Thu,  3 Sep 2026 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432982; cv=none; b=p2bhkmoNMIJyt3LO1sbqrwWoixmNUhGYKDn7jGsTVkzsLKmTMIHnY9pouhCj91G5JrLurbdAo2unwLj+k1vQvU6gY+1DBjCYCgJBKRTsNCaNYEK6axvE9DP+TyAMuM9dXTNVlrZpoCv+Pr6rJJsgzeDfQTz7x3SUnIHk2R/TDKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432982; c=relaxed/simple;
	bh=nDEmNmutXLjaZGLlVFqfX7V6NeHabVUP8dqkU7KmXXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJ+n72aI0ggO0zsLumUQP0zHjcFrxVRTAbI/pV4nwOiORTKVvWjhFnV1abDTzMJtsBdTga5V3O5hjSMIoBRR5LvGl+ByLUnCKqvMS6D29KPTqJlIMthYXSS6QsXyMKcVVOLWUeNovWEGlY38s0e/YyC0ugNIUgSjr14fuiXG3o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE25zrDk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE25zrDk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD961F000E9;
	Thu,  3 Sep 2026 10:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788432981;
	bh=JIWveMhOAoHYAD0EUwg0iSZcCXQHKJJVLy7Pa9YbeDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nE25zrDkEckyWuT3vwLQsJeReMmcAf/bRxyofcE5mdga5EtNZHwqWEr/AoIIa4Xfy
	 LB9cJGXOheduuQXaEw1urrWpCwgZpfrHUa0ddVqnae+LblvwVpobWbtmq81NaLg2Q7
	 pIDUG9Tgz6EYEqZYhXEboP9FaigUBaO1KUIv1ZE8e8Oo99fWytzoCliKnnpCeQN9qs
	 P8qjqSHGdCGEAo/TS02CDm4Qg/u+tX6R1H4RMzepfNAnSWt9fTU5hldmygkm60xgHf
	 C2sUBBz7sjUAXtNOePkQO9AuhWwB9uLzPYuc9T6KINyIKLXou5Gekmff1MV2dWpIfA
	 FkCiLVUhC+qsw==
Date: Thu, 3 Sep 2026 11:56:18 +0100
From: Harry Yoo <harry@kernel.org>
To: Longlong Xia <xialonglong2025@163.com>
Cc: vbabka@kernel.org, akpm@linux-foundation.org, hao.li@linux.dev, 
	cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, paulmck@kernel.org, 
	rcu@vger.kernel.org, xialonglong@kylinos.cn
Subject: Re: [PATCH v2] mm/slab_common: fix shrink budget underflow in
 kfree_rcu_shrink_scan
Message-ID: <aplKpZt3r57_7_yX@nixos>
References: <20260826075653.3304251-1-xialonglong2025@163.com>
 <apQsbGJDPPyXcn8R@dev>
 <baa22f03-e553-46cc-8c35-436363546605@163.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <baa22f03-e553-46cc-8c35-436363546605@163.com>

On Thu, Sep 03, 2026 at 05:13:15PM +0800, Longlong Xia wrote:
> Thanks for the reply.
> 
> 在 2026/8/30 22:22, Harry Yoo 写道:
> > On Wed, Aug 26, 2026 at 03:56:53PM +0800, Longlong Xia wrote:
> > > From: Longlong Xia <xialonglong@kylinos.cn>
> > Hi Longlong, I have a few questions.
> > 
> > > The kfree_rcu shrinker decremented sc->nr_to_scan (unsigned long)
> > > and then tested the result with <= 0. When a single CPU's object
> > > count exceeds the remaining budget, the subtraction wraps to a large
> > > positive value and the <= 0 comparison, which is equivalent to == 0
> > > for an unsigned type, never fires again.
> > Since when (which commit) has it been broken?
> > If it has been undiscovered for a very long time, why is that so?
> 
> Since the shrinker was first added: 9154244c1ab6 ("rcu/tree: Add a
> shrinker to prevent OOM due to kfree_rcu() batching", v5.8);
> 

I see.

> > And how did you discover this?
> 
> While reviewing the kvfree_rcu() batching paths with the help of AI
> tooling (hence the Assisted-by: tag in the patch), which flagged the
> unsigned subtraction feeding a "<= 0" test.

Okay.

> > > The scan loop then iterates
> > > through every possible CPU instead of honouring the reclaim budget.
> > Did you confirm this actually does happen? If so, how often does the
> > kernel end up iterating through every possible CPUs, very rarely or
> > almost always?
> 
> Yes, in two ways.
> 
> Experiment 1 -- deterministic, instrumented loop.  Per-CPU pr_info()
> plus a test entry invoking kfree_rcu_shrink_scan() with a controlled
> budget; 4-CPU QEMU guest, 400 objects queued on CPU0, budget 50:
>   buggy:   cpu=0 count=400 nr_to_scan_after_sub=18446744073709551266
>                 visits all 4 CPUs
>   patched: cpu=0 count=400 nr_to_scan=50 BREAK
> 
>                stops at CPU0
> 
> Experiment 2 -- natural trigger, no kernel modification at all
> (kprobes only).  Setup: 1 GiB QEMU guest, 4 possible CPUs, no swap.
> 
>   1. Observation: three kprobes.  Scan entry/exit record nr_to_scan
>      and the return value; each kfree_rcu_monitor() hit inside a
>      scan is one CPU the loop processed.
> 
>   2. Memory pressure: ~650 MiB of anonymous memory.
> 
>   3. krc backlog: loaded the in-tree test_vmalloc module ,
> 
>      which repeatedly vmalloc()s one page and frees it via kvfree_rcu();
> 
>     10 million iterations over ~70s kept the per-CPU queues populated.
> 
> Result within ~70s: 262 natural invocations, all from kswapd0;
> 171 of the 261 scans that found a backlog (66%) overshot the budget
> (nr_to_scan = 128, freed up to 4479) and visited all 4 possible CPUs.

Thanks for confirming with the experiment.

> > Would this affect the kernel's reclamation behavior in some way?
> 
> The break was meant to cap the scan at the reclaim budget; once
> the subtraction wraps, the cap is gone and one scan processes
> every possible CPU, draining the whole backlog instead of a
> budget-sized slice.

The fix logically makes sense to me. But I'm being cautious to
introduce a functional change even when it was unintentional and
'accidentally' worked. Especially when it has been like this from
the beginning.

IIUC it will almost always end up visiting all CPUs
unless sum of objects exactly matches nr_to_scan at some point.

In most cases it will visit all CPUs because either 1) the counter
overflows or 2) the number of objects was smaller than the budget.

While I agree that the code doesn't work as intended, I don't think
you have enough justification to change the behavior. I'd rather fix
the code to match the current behavior rather than changing the
behavior.

-- 
Cheers,
Harry / Hyeonggon
