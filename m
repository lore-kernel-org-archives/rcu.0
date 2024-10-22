Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A639ECF;
	Tue, 22 Oct 2024 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580843; cv=none; b=Tv+6DH12nzoes7piW4uQY/7NtYgh9FohxjxDTEoiOcH+BOakp6HcgkEEAnKNfKZYmiEFbZeOiInmkw7APjX3XqVj9fOSGTIUgSIqQ/33Kppu6ePEheiV3ApjSbNNBrhyQWMdeL7q1bBWUMQNkeq3yZLGMEyFSjTrd/K8VEHnHEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580843; c=relaxed/simple;
	bh=NlmEZ7uijWkrtaVBuwTepm2SuoXildFQM1qy4WX+7bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1x4G1uVJ4bR1Ch5kMYWHH0F6L5OviJydUTCZ9bYsPhpSRZ0MIFExShoMMkkyUEvHGlvTnrUtZMgToQdWZ4dBrKglCrwWdkK8egPJybSjx3/VG/hnqbLKuQnDQcTKMfjjVoVYpmfqRBCrbYAJa8jUXn42vKyggTKwLrgCBuT0H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mKOtuduF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mKOtuduF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rTrxhf0FxXgnF3vI4lgvl1cUpIxgDs8pdPPsH5xe4uM=; b=mKOtuduFDRSNFKRuV2zbjdupor
	RBX7cVRYLh7ToJ3ciiewl5maztdtGmOVrpaMgFvMxAdmKdku96lrXEYXTi6YzhXaIrCN31lm3A/H3
	b7ZnUP5RriN+lpCqKsy1aP3t5WPXVM2lH1j+x11Nb1K3Bn5fgSsy0SvJG45oYsNkrhFgTd1jblinf
	PKnLsUvOz6i9WLzj+7sAIYLbVSJPV8ADT2yq0Ck7/dDzBFBd/LundEVAgQcDXTpyh0ekiMZFA842G
	t26oXNlg7Ljz7mcyhAfzBLXE8bmcJWZv1EV3UXErZnBX1gWPIC/wJ8GSxQy02aGnB9bz88nDBFPEu
	7jXp86Wg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t38z7-0000000HUj4-2oKD;
	Tue, 22 Oct 2024 07:07:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E3DC030073F; Tue, 22 Oct 2024 09:07:17 +0200 (CEST)
Date: Tue, 22 Oct 2024 09:07:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, andrii@kernel.org
Subject: Re: [PATCH rcu] srcu: Guarantee non-negative return value from
 srcu_read_lock()
Message-ID: <20241022070717.GZ16066@noisy.programming.kicks-ass.net>
References: <97594073-e296-4876-9d6a-1e4a4f33d857@paulmck-laptop>
 <CAEf4BzZU4ysQznVEctzijCUyuwN0TQXsxg_C16v3mmhUOzspjQ@mail.gmail.com>
 <5fbd5ff1-8cb8-425f-be5f-7ed9fe4edf1c@paulmck-laptop>
 <CAEf4BzbX5UtS=+Np5t68n8oRE2O2qGg5iDcikNFpvCTPBZU8kg@mail.gmail.com>
 <22a02204-8d14-41ae-af40-dfea79dec09d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22a02204-8d14-41ae-af40-dfea79dec09d@paulmck-laptop>

On Mon, Oct 21, 2024 at 08:30:43PM -0700, Paul E. McKenney wrote:
> Thoughts?

Thanks Paul!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ------------------------------------------------------------------------
> 
> commit 4433b7d3785d8d2a700f5ed5ca234c64bc63180e
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Mon Oct 21 15:09:39 2024 -0700
> 
>     srcu: Guarantee non-negative return value from srcu_read_lock()
>     
>     For almost 20 years, the int return value from srcu_read_lock() has
>     been always either zero or one.  This commit therefore documents the
>     fact that it will be non-negative, and does the same for the underlying
>     __srcu_read_lock().
>     
>     [ paulmck: Apply Andrii Nakryiko feedback. ]
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index bab1dae3f69e6..512a8c54ba5ba 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -238,13 +238,14 @@ void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor);
>   * a mutex that is held elsewhere while calling synchronize_srcu() or
>   * synchronize_srcu_expedited().
>   *
> - * The return value from srcu_read_lock() must be passed unaltered
> - * to the matching srcu_read_unlock().  Note that srcu_read_lock() and
> - * the matching srcu_read_unlock() must occur in the same context, for
> - * example, it is illegal to invoke srcu_read_unlock() in an irq handler
> - * if the matching srcu_read_lock() was invoked in process context.  Or,
> - * for that matter to invoke srcu_read_unlock() from one task and the
> - * matching srcu_read_lock() from another.
> + * The return value from srcu_read_lock() is guaranteed to be
> + * non-negative.  This value must be passed unaltered to the matching
> + * srcu_read_unlock().  Note that srcu_read_lock() and the matching
> + * srcu_read_unlock() must occur in the same context, for example, it is
> + * illegal to invoke srcu_read_unlock() in an irq handler if the matching
> + * srcu_read_lock() was invoked in process context.  Or, for that matter to
> + * invoke srcu_read_unlock() from one task and the matching srcu_read_lock()
> + * from another.
>   */
>  static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
>  {
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 07147efcb64d3..ae17c214e0de5 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -738,7 +738,8 @@ EXPORT_SYMBOL_GPL(srcu_check_read_flavor);
>  /*
>   * Counts the new reader in the appropriate per-CPU element of the
>   * srcu_struct.
> - * Returns an index that must be passed to the matching srcu_read_unlock().
> + * Returns a guaranteed non-negative index that must be passed to the
> + * matching __srcu_read_unlock().
>   */
>  int __srcu_read_lock(struct srcu_struct *ssp)
>  {
