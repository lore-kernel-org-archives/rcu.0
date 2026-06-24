Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0124A3BFE5C;
	Wed, 24 Jun 2026 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310571; cv=none; b=cOkrw8uv6raPPC6+uuh9RlycHGeC+fBng7A+QQlDHmz8aPWXNGbTdimxualC/5frdA0lzayeCxKnl7MOuHRH+44+H4IKsC62NJUP4mMPdbdErcnV6X3+aFfaRHBN3CzHz1T3PhlUqz/J//ShNXjjgolXt5vczzZ/Fx3PyjFOavY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310571; c=relaxed/simple;
	bh=UI2NNA2hb1Ih3IR06qE170SNFF1aFICiLHj70kD4Y2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjYBwawY3ydcttyYgoCnXPGNJM6A9dXflkD2nOk1LBvNrbeoRKoiBGkmU8AY/SwRk3RhfOE8gYJn8ERum+qIsGiTWssZELzt8m0K1aBbNTlOXMM3cpQ6aQoCD4igVR90XxKIrbxmLo/CrgQeqAlGTY3hEkNeb778fgoKwpWFMbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YGeN61UR; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YGeN61UR"
Message-ID: <1030b968-4184-4818-99dc-aeb0956ef6a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782310566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWM7/K0F3C5pxQFwSgsZm5S7ELhGilSGA5hWWaaRFNI=;
	b=YGeN61URMed8FpXNsXYxLJfqOAStpoVJ5VV3vvz8ElP4F+Nbh8QvaWpMTXkba3YhZjdty+
	X+rLtuGt36ajhdUfdgvzVJcQsyEVGssupxitTGSraomwG6NLuh7Nfc6/rolwGtBYJxpzm/
	oQzB1gybTiKUQI+oEnwNtgC27a+bocA=
Date: Wed, 24 Jun 2026 22:15:03 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] smp: Use release stores for csd_lock_record() state
To: Usama Arif <usama.arif@linux.dev>, lkmm@lists.linux.dev,
 joelagnelf@nvidia.com, linux-kernel@vger.kernel.org,
 marco.crivellari@suse.com, paulmck@kernel.org, rafael.j.wysocki@intel.com,
 rdunlap@infradead.org, riel@surriel.com, sshegde@linux.ibm.com,
 tglx@kernel.org, ulfh@kernel.org, yury.norov@gmail.com, rcu@vger.kernel.org
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, kernel-team@meta.com
References: <20260622163807.4187558-1-usama.arif@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <20260622163807.4187558-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/23/26 00:38, Usama Arif wrote:
> __csd_lock_record() publishes per-CPU CSD debug state that is read by
> csd_lock_wait_toolong() on another CPU.  The remote side first reads
> cur_csd with smp_load_acquire() and, when non-NULL, may then read the
> matching cur_csd_func and cur_csd_info fields.
>
> Use smp_store_release() when publishing cur_csd so that the preceding
> cur_csd_func and cur_csd_info stores are ordered before the pointer
> that csd_lock_wait_toolong() acquires.  This replaces the open-coded
> smp_wmb() plus plain cur_csd store with the release operation that
> matches the smp_load_acquire() in csd_lock_wait_toolong().
>
> For the clear path, use smp_store_release(&cur_csd, NULL) so that
> clearing the diagnostic state remains ordered after the preceding
> callback/unlock work, without requiring a full barrier before the
> store.  On x86 this removes the locked full barrier from the clear
> path; on weaker memory models it uses the release operation needed by
> the smp_load_acquire() in csd_lock_wait_toolong().
>
> The old code also had smp_mb() calls around cur_csd updates. Those would
> only be needed if cur_csd were treated as an exact live-state marker whose
> publication had to be observed before callback execution or CSD unlock.
 The original comments around those updates seem to suggest a stronger
relationship:
  /* Update cur_csd before function call. */
  /* NULL cur_csd after unlock. */

The changelog characterizes cur_csd as best-effort diagnostic context. 

Is there prior consensus that cur_csd carries no ordering relationship 
to callback execution / unlock state, 

or is this patch effectively relaxing that historical assumption?


Thanks,  Kunwu

> CSD stall warnings do not currently have RCU-style stall-ended checks, so
> they already allow the stall to end while diagnostics are being assembled.
> The cur_csd record is therefore best-effort diagnostic context, not a
> precise completion/stall boundary.
>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
> v1 -> v2: https://lore.kernel.org/all/01437928-ff79-4d8e-823b-7f20146946f6@linux.dev/
> - Document where the smp_store_release() synchronizes with (Alan Stern,
>   Randy Dunlap and Paul McKenney).
> ---
>  kernel/smp.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/smp.c b/kernel/smp.c
> index a0bb56bd8dda..685829875a3e 100644
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
