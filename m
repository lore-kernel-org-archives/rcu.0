Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C86137E300
	for <rcu@vger.kernel.org>; Mon, 29 Jun 2026 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751413; cv=none; b=T/7BboR7GA6tbX/J95CntWFRp/27E0CT8cxNYeSIKcEJSNa3ewMG20R2U/hg1Jdp8z6NYrvZQf5fgSRonj0g//gnvqaDhwVE9RJk2k+bKA3dUhCq3ptNlPhbg0W+nY6vEWClvmGFWiCytg/XrOyoeR5+DXt48QYGf1Crg77M/Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751413; c=relaxed/simple;
	bh=c7t5t9ehvd9AT/whmAS1K6P26pUwc41TyNJ7edSDo2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fdFRVXoqU/d74V8yyN1TqjgSzr9jXT3scZayI71dvfTFB+RxPik83YYJP59/Db06+WLO0mqlbCOgMAYdVOMp3WbfTHVhfDedA6My8AnQdyyRwoasw+/kOw3IsLdhdFtGA55q+icaqvq9PEWtf8Gi1qU1/XTKo2lQh2wMfNezm6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oEp7tRnq; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oEp7tRnq"
Message-ID: <e3d91c52-7a3c-41eb-834b-a253d2900839@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782751399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qAERY6YYlDjCgjdc5pFThzfIpUUE8ygA/6rL1jL9C8k=;
	b=oEp7tRnq7oeJ/T1VhGQ6L28gv3We+VqBERgQvkNIqk+0rBIQmS52nFRjFOt91ev77mR/zZ
	N2bCDqN5iyQ9E/J4C32NEfUTndjzD/+IDsRu17ugGBE/kd43HiRJR+qRoThrMKX08rogwD
	U3iQFnsWUd8truWQI0dv1HNGDzyTZkY=
Date: Tue, 30 Jun 2026 00:42:37 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] smp: Use release stores for csd_lock_record() state
To: Usama Arif <usama.arif@linux.dev>, lkmm@lists.linux.dev,
 joelagnelf@nvidia.com, linux-kernel@vger.kernel.org,
 marco.crivellari@suse.com, paulmck@kernel.org, rafael.j.wysocki@intel.com,
 rdunlap@infradead.org, sshegde@linux.ibm.com, tglx@kernel.org,
 ulfh@kernel.org, vineeth@bitbyteword.org, yury.norov@gmail.com,
 rcu@vger.kernel.org, d@ilvokhin.com
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, kernel-team@meta.com
References: <20260629105745.1696683-1-usama.arif@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <20260629105745.1696683-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/29/26 18:57, Usama Arif wrote:
> __csd_lock_record() publishes per-CPU diagnostic state (cur_csd,
> cur_csd_func, cur_csd_info) that is consumed from a remote CPU by
> csd_lock_wait_toolong() via smp_load_acquire(&cur_csd). To order the
> matching cur_csd_func/cur_csd_info stores before the cur_csd
> publication, the producer issues smp_wmb() before writing cur_csd;
> to order the publication before the subsequent callback execution or
> CSD unlock, it issues smp_mb() after the write. The clear path
> mirrors this with smp_mb() before storing NULL into cur_csd so the
> preceding callback/unlock is observed first.
>
> The smp_mb() pair is heavier than what the consumer actually
> requires (on x86 each emits a locked full barrier). The consumer
> only needs to observe the matching cur_csd_func/cur_csd_info when it
> sees a non-NULL cur_csd, and to observe the preceding callback/unlock
> when it sees NULL -- both of which a release/acquire pair provides.
> The extra two-way ordering enforced by smp_mb() -- that cur_csd
> publication be observed before callback execution or unlock becomes
> visible -- would only matter if cur_csd were an exact live-state
> marker. csd_lock_wait_toolong() does not treat it that way: it
> snapshots cur_csd via smp_load_acquire() and then prints / dumps /
> re-IPIs without an RCU-style stall-ended recheck, so the diagnostic
> already tolerates the remote CPU completing its work between snapshot
> and report. cur_csd is best-effort context, not a precise stall
> boundary.
>
> Replace the smp_wmb() + plain store + smp_mb() in the publish path,
> and the smp_mb() + plain store in the clear path, with
> smp_store_release(). This pairs with the smp_load_acquire() in
> csd_lock_wait_toolong(): preceding cur_csd_func/cur_csd_info stores
> become visible before a remote reader observes the non-NULL
> publication, and any preceding callback/unlock becomes visible before
> a reader observes the NULL clear.
>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
> v2 -> v3: https://lore.kernel.org/all/20260622163807.4187558-1-usama.arif@linux.dev/
> - Restructure changelog into context/problem/solution form (Thomas
>   Gleixner).
> - Add reciprocal pairing comment on the smp_load_acquire() in
>   csd_lock_wait_toolong() (Dmitry).
>
> v1 -> v2: https://lore.kernel.org/all/01437928-ff79-4d8e-823b-7f20146946f6@linux.dev/
> - Document where the smp_store_release() synchronizes with (Alan
>   Stern, Randy Dunlap and Paul McKenney).
> ---
>  kernel/smp.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/smp.c b/kernel/smp.c
> index a0bb56bd8dda..8a847a34f132 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -182,16 +182,22 @@ static atomic_t csd_bug_count = ATOMIC_INIT(0);
>  static void __csd_lock_record(call_single_data_t *csd)
>  {
>  	if (!csd) {
> -		smp_mb(); /* NULL cur_csd after unlock. */
> -		__this_cpu_write(cur_csd, NULL);
> +		/*
> +		 * Pairs with smp_load_acquire() of cur_csd in
> +		 * csd_lock_wait_toolong(): orders any preceding CSD
> +		 * callback/unlock before a remote reader observes NULL.
> +		 */
> +		smp_store_release(this_cpu_ptr(&cur_csd), NULL);
>  		return;
>  	}
>  	__this_cpu_write(cur_csd_func, csd->func);
>  	__this_cpu_write(cur_csd_info, csd->info);
> -	smp_wmb(); /* func and info before csd. */
> -	__this_cpu_write(cur_csd, csd);
> -	smp_mb(); /* Update cur_csd before function call. */
> -		  /* Or before unlock, as the case may be. */
> +	/*
> +	 * Pairs with smp_load_acquire() of cur_csd in
> +	 * csd_lock_wait_toolong(): publishes cur_csd_func and
> +	 * cur_csd_info before the non-NULL pointer becomes visible.
> +	 */
> +	smp_store_release(this_cpu_ptr(&cur_csd), csd);
>  }
>  
>  static __always_inline void csd_lock_record(call_single_data_t *csd)
> @@ -272,7 +278,13 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
>  		cpux = 0;
>  	else
>  		cpux = cpu;
> -	cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux)); /* Before func and info. */
> +	/*
> +	 * Pairs with smp_store_release() of cur_csd in __csd_lock_record():
> +	 * a non-NULL cur_csd here implies cur_csd_func and cur_csd_info
> +	 * are the matching publication; a NULL value is ordered after any
> +	 * preceding CSD callback/unlock on the remote CPU.
> +	 */
> +	cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux));
>  	/* How long since this CSD lock was stuck. */
>  	ts_delta = ts2 - ts0;
>  	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %lld ns for CPU#%02d %pS(%ps).\n",
Reviewed-by: Kunwu Chan <kunwu.chan@linux.dev>

-- 
Thanx, Kunwu

