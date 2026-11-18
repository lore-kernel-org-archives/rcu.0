Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794978558;
	b=2ZhlhBb1GgYkIY7Z+lIb987RiceWLNYY+Ej1OYaf8QcC3Gw07+jnnlMqUF2nAKa1DrAp
	 melf0K2lkoP3FAKFhuyWnPqk7h/PisZhbttOiAhSHk5h5blcH5XZu6fc/UBLRBqp4bqpl
	 jSy6ihHIcKnJ/+7bH6lxN0O62mnUo5nwqv5vyDV3Wh6qnXUZ2aQRGTkPHRKPqrnnVm+tH
	 lKt+gv98fGcXbJNDDPV1YnOKaPsTFe5362t3GK0qvUYOavhpxa4UZLj6QNnhEaCfnGBhH
	 GC3mxrQzS1z6RvgDq0DkNMVXX5Z2z0Mgk6BpQWk4biU8biMtmarlK40Y8XHr5pZ0sBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794978558;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=fpWc9hELHB51C84PlD2yWzhLQPgr2lWImiEogCRjFzI=;
	b=nvFq4+Qr0z95Jwtmb1mxw22fosXCyzc3bicTW/bm6jNepJTiM39Ts1wPI0h4ueyqr1K7
	 DzYqrp3Ab2+CYkVJL0/joXOXbXQgfFNVSCEZSKftGMEBnO43RNhXIThu22Mk9EYCyXG+b
	 WDDabgb5t3j9rOe/iNtfQPnXYTjGAq1WMZRmlkIadR4z/eP+cNTnW6XGnAw7hIRZzVgVn
	 DveX3U0kCRBMTCucGr+SosdVwJzefTv2wt8XeshgHVt0kZVaLGV8W7ifRMIKYY2LFj+r3
	 cATtcTg5G9SBkwf0kf3/t1309Z80N8NLNex/xC3qiglTNXmU9R4Lk2hr085I/DridFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d//ALsih";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A6D606A31C;
	Wed, 18 Nov 2026 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d//ALsih
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B231F000C4;
	Wed, 18 Nov 2026 05:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794978557;
	bh=fpWc9hELHB51C84PlD2yWzhLQPgr2lWImiEogCRjFzI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=d//ALsih2yv4fcWzrqtlL+iWobbYQjq4eCIQtv+BiKEEDPx5KBehqZOhEsXITy1J1
	 mXWN+Zw1ws5Y3d7oDnMIj3dRnCZxMFlV2q26h0ktYLWgfYpXsf/1FChCNDjfd7LZrO
	 DPOUHRt8TJn7fFFUrOOwscfD/hAcuseVBMiqQU8Jbnb0/0RQfhcFUtLjcQ2H2xLz62
	 p5RoVAgDykpfwZ8JQZxw6WJabhbqDE+uK3D1xRDMEQXsh95ldDlNlRp6sSb9HebOI/
	 dqcKvOWSxbp/VE1J3Jz8iyXi5Ww4b/TDiweZJBk1Jlg7QoQDV3FZQmDxHBUocPoFS7
	 v71kvWURDmyNg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ADC9ACE0C35; Tue, 17 Nov 2026 21:09:17 -0800 (PST)
Date: Tue, 17 Nov 2026 21:09:17 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Guikun Yang <yangguikun19@qq.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Validate ___srcu_struct_ptrs entries against the
 module range
Message-ID: <896b4a31-642a-453c-8a35-3dad576bb921@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <srcu-struct-ptrs-wildwrite-20261114@qq.com>
 <tencent_0836A27053A7BED946E49CE04D27A31E7D09@qq.com>
 <tencent_E038DD9BFA4429F88047A5A4367D578DB80A@qq.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E038DD9BFA4429F88047A5A4367D578DB80A@qq.com>

On Tue, Nov 17, 2026 at 10:00:00AM +0800, Guikun Yang wrote:
> As discussed, here is the formal patch. Exactly as you presumed:
> srcu_module_going() needs the same check, because a module whose
> coming() fails the validation still gets a MODULE_STATE_GOING
> notification via the robust call in prepare_coming_module().
> 
> ---

I have pulled this in for review and testing, thank you!  And with
Bradley's Reviewed-by, however, Joel is doing the upcoming merge window,
so its eventual disposition is up to him.

The next time you send a patch, please skip the first paragraph and
the "---".  These cause the automation to keep the above paragraph
and to throw away the real commit log below.

Which I compensated for, so no harm done.  This time.  ;-)

							Thanx, Paul

> The entries of the ___srcu_struct_ptrs section are absolute pointers
> emitted by DEFINE_SRCU() in module .data. load_info() hands the raw
> section to RCU (kernel/module/main.c), and srcu_module_coming()
> dereferences each entry and writes through it:
> 
> 	ssp = *(sspp++);
> 	ssp->sda = alloc_percpu(struct srcu_data);
> 	ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];
> 
> A malicious or corrupted module image can point an entry anywhere in
> the kernel address space; nothing on the load path validates it, so
> this is an arbitrary-address write primitive (an 8-byte percpu
> pointer at offset 8 of the target).
> 
> The static-key loader already handles the same shape of section with
> a range check (kernel/jump_label.c):
> 
> 	if (within_module((unsigned long)key, mod))
> 
> Apply the same check to both module-notification paths. coming()
> rejects the module load outright; going() skips the entry, because
> going() runs even for modules that never passed coming(), and those
> entries never got per-CPU data allocated.
> 
> Signed-off-by: Guikun Yang <yangguikun19@qq.com>
> ---
>  kernel/rcu/srcutree.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 2b0e2b2d2..412265757 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -2498,6 +2498,8 @@ static int srcu_module_coming(struct module *mod)
>  
>  	for (i = 0; i < mod->num_srcu_structs; i++) {
>  		ssp = *(sspp++);
> +		if (WARN_ON_ONCE(!within_module((unsigned long)ssp, mod)))
> +			return -EINVAL;
>  		ssp->sda = alloc_percpu(struct srcu_data);
>  		if (WARN_ON_ONCE(!ssp->sda))
>  			return -ENOMEM;
> @@ -2521,6 +2523,8 @@ static void srcu_module_going(struct module *mod)
>  	srcu_defer_flush();
>  	for (i = 0; i < mod->num_srcu_structs; i++) {
>  		ssp = *(sspp++);
> +		if (WARN_ON_ONCE(!within_module((unsigned long)ssp, mod)))
> +			continue;
>  		if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>  		    !WARN_ON_ONCE(!ssp->srcu_sup->sda_is_static))
>  			cleanup_srcu_struct(ssp);
> 
> -- 
> 2.34.1
> 
