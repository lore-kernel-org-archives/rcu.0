Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5687E39B959;
	Wed, 13 May 2026 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778668722; cv=none; b=Ow/DKc26LqD0FCep1cZJ9TfcgpaUgj50rwUIyeRrlyny/aBsSSGqi/QYbE1AHA6IyftfXsNypJuSkYWxVuimm9dfDx+YjzGjKGuTqEczbsDa9SgL/oRbMJMLuIwt1WNymWi3cVmcetGXr4KspRrQ5FM7v6NXmPkdj1uAAhxyf7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778668722; c=relaxed/simple;
	bh=F8d0o2jBbypDmaOWTKevelhpQW94i8w3rEv8l+pgKyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=siXBcpzl9gbgWQCnikphri3wXHjggR14KZ9e/952nF/PPDCBhzf97dwI4vOOWLOP7qVdIemrYfvcSSb6gext49UUsWbpPT8bV7yZbwr8zx9dfTgKhINZiUY3DkHge2CN2gGnMbR+nNVDMqECcZFH1Tl05Xagike4Lk/flXj236Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=kW33Td8N; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="kW33Td8N"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gFqgf1xsPz4F3w;
	Wed, 13 May 2026 12:38:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1778668718;
	bh=F8d0o2jBbypDmaOWTKevelhpQW94i8w3rEv8l+pgKyM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kW33Td8Nn2HsWcEY2Ov8i5kg8uqD4F+G+f5whZFe7J+e2fM9f4skbMrjrec0iJr8L
	 V+jPjJL8dTcRj8sAbxNFQSiVBQcU5VtCTRsoUk03YGgkSUakjfhJBECpqAj6gnfSsq
	 gBI184VkOPUBgIcRn6ncZAnFVfCZr/1PJXnQbTbdCcDwGkTM9ZvmqFWjtkIMdETTQ8
	 DOKyyalZZBodoxqlZhm/xhZNhxiQxjzNUjDWJVeFJWIToZxJRwxa8QGJwyq1j8TFVs
	 VRyJNg5l4w+9G2BDS0PDq5J2x+5M2leLQI118BqFlZSZaJQBy/w0gA00u/F8v3NM7R
	 MXnSJT3Dn1HAA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4gFqfz3Cldz7vZg;
	Wed, 13 May 2026 12:38:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gFqfy2TjCz8tbf;
	Wed, 13 May 2026 12:38:02 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 4228A5FAF5;
	Wed, 13 May 2026 12:38:01 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <f669fbc9-c068-489f-bd91-4e81561a6e58@leemhuis.info>
Date: Wed, 13 May 2026 12:38:01 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v1 05/12] srcu: Don't queue workqueue handlers to
 never-online CPUs
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes
 <joelagnelf@nvidia.com>, RCU <rcu@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Frederic Weisbecker <frederic@kernel.org>, Samir <samir@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260511175448.153326-1-urezki@gmail.com>
 <20260511175448.153326-6-urezki@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20260511175448.153326-6-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177866868173.2430481.9489570844207518202@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 4228A5FAF5
X-NC-CID: pjUJteFyj9eMZcmjTYCtCQQ9Qx7G1Rkgoy3vih0aNafkt4E+Glk=

On 5/11/26 19:54, Uladzislau Rezki (Sony) wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> While an srcu_struct structure is in the midst of switching from CPU-0
> to all-CPUs state, it can attempt to invoke callbacks for CPUs that
> have never been online.  Worse yet, it can attempt in invoke callbacks
> for CPUs that never will be online, even including imaginary CPUs not in
> cpu_possible_mask.  This can cause hangs on s390,

Uladzislau, Paul, according to the fixes tag below this change fixes a
change that went into 7.0-rc6 -- and apparently causes a "hang" on some
architectures. So shouldn't this be heading to mainline instead of
-next? Ideally with a stable tag to ensure backporting to 7.0.y, but
that is a separate decision?

I had an eye on this issue after noticing Samir's report:
https://lore.kernel.org/lkml/97a7d011-d573-4754-9e5d-68b562c64089@linux.ibm.com/

And the jury is still out, but Jiri is dealing with some issues that
might or might not be related to the problem this fixes, too:
https://lore.kernel.org/all/f0351414-41af-4f74-899c-87fb5bb45621@kernel.org/

Ciao, Thorsten


> which is not set up to
> deal with workqueue handlers being scheduled on such CPUs.  This commit
> therefore causes Tree SRCU to refrain from queueing workqueue handlers
> on CPUs that have not yet (and might never) come online.
> 
> Because callbacks are not invoked on CPUs that have not been
> online, it is an error to invoke call_srcu(), synchronize_srcu(), or
> synchronize_srcu_expedited() on a CPU that is not yet fully online.
> However, it turns out to be less code to redirect the callbacks
> from too-early invocations of call_srcu() than to warn about such
> invocations.  This commit therefore also redirects callbacks queued on
> not-yet-fully-online CPUs to the boot CPU.
> 
> Reported-by: Vasily Gorbik <gor@linux.ibm.com>
> Fixes: 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when non-preemptible")
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Tested-by: Vasily Gorbik <gor@linux.ibm.com>
> Tested-by: Samir <samir@linux.ibm.com>
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/srcutree.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 0d01cd8c4b4a..7c2f7cc131f7 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -897,11 +897,9 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
>  {
>  	int cpu;
>  
> -	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
> -		if (!(mask & (1UL << (cpu - snp->grplo))))
> -			continue;
> -		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
> -	}
> +	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++)
> +		if ((mask & (1UL << (cpu - snp->grplo))) && rcu_cpu_beenfullyonline(cpu))
> +			srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
>  }
>  
>  /*
> @@ -1322,7 +1320,9 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
>  	 */
>  	idx = __srcu_read_lock_nmisafe(ssp);
>  	ss_state = smp_load_acquire(&ssp->srcu_sup->srcu_size_state);
> -	if (ss_state < SRCU_SIZE_WAIT_CALL)
> +	// If !rcu_cpu_beenfullyonline(), interrupts are still disabled,
> +	// so no migration is possible in either direction from this CPU.
> +	if (ss_state < SRCU_SIZE_WAIT_CALL || !rcu_cpu_beenfullyonline(raw_smp_processor_id()))
>  		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
>  	else
>  		sdp = raw_cpu_ptr(ssp->sda);

