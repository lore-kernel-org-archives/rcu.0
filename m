Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320AC40801E;
	Mon, 29 Jun 2026 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747347; cv=none; b=IGS3ug7zrEEMnFyEIJaOrcSXzmIy/XeYFI+KML8jOe8H+hbK8H8RN+LYd8IGRn351JGwe+NmEEThhC1ZT90N7V8VRnFs9Cf0FYlTTNnwD84kpQiiNVopljx4s42zLLUYzRWA3qEsGvNdAkC+EYPJmM97vdOUcBqOr/M85LxmqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747347; c=relaxed/simple;
	bh=1nYTX2SSgL5Xoj6/GQC0n113mzO60Sqg0/mwOgzi/l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGC64muFoEcCDNAvCCM4ql8Q5WR3pBoe6/WhGwMIKDkKKSlrVLqZ9SuiGErx130B6ZJHCTmM1HUxrtabQAJUNxDrCYEukkPcB/RBmjA84xRTq4SnvL/ODcMSMb9lAIXyXhUuXDr4gJdgel3VNWE2vPfSMkQszs2bTbujT/w8gZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfwSQQCE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfwSQQCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEAE1F00A3E;
	Mon, 29 Jun 2026 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782747346;
	bh=VQRkgbBLbEtvZUS3wUZtr9Ihzsk3DvhVlV4E01dnKao=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=GfwSQQCE8SqaW3PtsQ43woZ3sZUPyZPtyPFpljbSLaqQrMiGk0ctaZKYRoseYynU/
	 ziCIf53kVjqfoD+5/2uKex4oFQYYAsgRqwF6Eq4EYI1Z2gX7TujajfJP2uBO99u4rw
	 CutOs0rZRUrYrU+YE5keBPzYWuHpobBRNk9H9/XTQ6p7f++fXc2QcnrQFAuQ1uH/K8
	 5uz5DggbpKg4Z+9J0WBB105jTe+4NZhpWTrsfJ0exBPH2EXrplomqUDZW4OkaA7SB0
	 VxCGIf15hv4KKjtZK2XpU22ql6OebAbo4UW9I6LH7YkLMulmXXKdncPkt9HiFYDQk8
	 aADhrMlt48WvA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C8F9BCE04B8; Mon, 29 Jun 2026 08:35:45 -0700 (PDT)
Date: Mon, 29 Jun 2026 08:35:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: lkmm@lists.linux.dev, joelagnelf@nvidia.com,
	linux-kernel@vger.kernel.org, marco.crivellari@suse.com,
	rafael.j.wysocki@intel.com, rdunlap@infradead.org,
	sshegde@linux.ibm.com, tglx@kernel.org, ulfh@kernel.org,
	vineeth@bitbyteword.org, yury.norov@gmail.com, rcu@vger.kernel.org,
	d@ilvokhin.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	kernel-team@meta.com
Subject: Re: [PATCH v3] smp: Use release stores for csd_lock_record() state
Message-ID: <50bec589-1e68-442f-968c-0cc159f2ec69@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260629105745.1696683-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629105745.1696683-1-usama.arif@linux.dev>

On Mon, Jun 29, 2026 at 03:57:45AM -0700, Usama Arif wrote:
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

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

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
> -- 
> 2.53.0-Meta
> 
