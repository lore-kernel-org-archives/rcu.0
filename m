Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243F33A873E;
	Thu, 25 Jun 2026 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398551; cv=none; b=onFBgz0cAPwuzXC0UWJ6ZhOWHKiPd/xOL7Y5bIZrXamT/qShi+WsE0QSrMP/JF5Wuge+8YeJu8/egYHWYUPyHblf3fxcDVvzLGWoQBcqIGtrg+9UTGpdgITfGEUYT4qH/DPmpc5UxC6X7YbN76BuSEtj0+mISvJUrrxWen2vKyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398551; c=relaxed/simple;
	bh=JGVTRb5DqYe0LpDZ1wZvuP+94/ev4LoITOfgIh5CyTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHhvS3McSRqrPuJLP/hvmb1DdaFTDbAg3eCfzRpIcVHp7+V5tVQhz4PNph/JNgLNNiz4nSv6+3DWMLFj/vsgWcUdyJ28ihpcFiGiaLHXUuWJCA12M/lF2/wMW8yTwr1uv4/Vn9o6SKHBJNpvsIn6PKH/VwU6BdJenTZDNRt2JeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=X2SLTx2L; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="X2SLTx2L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1782398541;
	bh=uWaBoqYfbNoWhVcIPdsvXePepaUpdOqRtpnHcvJcJbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X2SLTx2LiaRZ9qppN1ShUfMj+uhI1Os05qSVFcd9vm6Ea1SCyYamf0qO9z5HKUVhh
	 3Rq9uRniaDIQrxqxa/b76AqymMEL2Fkc9wzlMhFat/hGVi3LsQIEFDJM790iOegHOU
	 H4rfRwiWsUEq8xHap0znlhRnZA81JjEeGy0kJnQo=
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 37A1BDAFEA;
	Thu, 25 Jun 2026 14:42:21 +0000 (UTC)
Date: Thu, 25 Jun 2026 14:42:17 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: lkmm@lists.linux.dev, joelagnelf@nvidia.com,
	linux-kernel@vger.kernel.org, marco.crivellari@suse.com,
	paulmck@kernel.org, rafael.j.wysocki@intel.com,
	rdunlap@infradead.org, riel@surriel.com, sshegde@linux.ibm.com,
	tglx@kernel.org, ulfh@kernel.org, yury.norov@gmail.com,
	rcu@vger.kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] smp: Use release stores for csd_lock_record() state
Message-ID: <aj0-SYJJdDzf56Ex@shell.ilvokhin.com>
References: <20260622163807.4187558-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622163807.4187558-1-usama.arif@linux.dev>

On Mon, Jun 22, 2026 at 09:38:07AM -0700, Usama Arif wrote:
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

The changelog only calls out the clear path here, but the publish path
also drops its trailing smp_mb() (plus the smp_wmb()), so on x86 both
paths lose a locked full barrier. Worth describing symmetrically.

> 
> The old code also had smp_mb() calls around cur_csd updates. Those would
> only be needed if cur_csd were treated as an exact live-state marker whose
> publication had to be observed before callback execution or CSD unlock.
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

Since v2 is specifically about documenting the pairing, it would be good
to make it symmetric and add the comment on the acquire side in
csd_lock_wait_toolong().

>  
>  static __always_inline void csd_lock_record(call_single_data_t *csd)
> -- 
> 2.53.0-Meta
> 
