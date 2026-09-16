Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1323EDE52
	for <rcu@vger.kernel.org>; Wed, 16 Sep 2026 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541861; cv=none; b=GXuBZxykjhi1k/kfIA5UMhdHP5gBVykr0SyJHdf42Ex9x49m4Q6878rjd38UlKe9iKK5dfpcI+cjbDcGVHrGXv9F9rFhG4KJEHFyuzHUnt+6EC7hUM7MsHlgu7ECFInsZ9XDa4h20R8obttjPliKjOf0gzZiwWdIfrm6coN0oV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541861; c=relaxed/simple;
	bh=9sBlD5izEEfo2pLgZKTdvRxdTeoNasGiiJQXKUcd5j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdxhxQILrucdTjx1y5QHZhJt9RhOXwYAcrOOMgMX6n+q9LvB+BOZJRdLQb/74GnbcCeJSKO3YAUDF7ts7v0N184MgkCACJbLYh69LgXL1Uv8I9vmvqKaskNma93tlVbqc5x7b8/Hi7frlJYfXFtxOgHj5Pv5Ln1lZQgW8/qjHOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h85t53TX; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h85t53TX"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so477839a91.2
        for <rcu@vger.kernel.org>; Tue, 15 Sep 2026 23:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789541859; x=1790146659; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NKzNesC0LhJFIDuZhUW/K+h4UvLvdFAJBHAUljGQgV0=;
        b=h85t53TXJ27egsOFIwLHzlee2qOUF7B9vkogE4k3/7WXdZ81f8pF/i8xEv/o02Invf
         mlgjoxX6gMjpQVNG1EeEhfm/787Oj1SkBnfLy05ZkVp88e+lZwuaap987bubaSh5Pi+G
         fwHMa2LRZlOJRzH+7NUJZt85mjRGX0d8Uf/28z5VW4z4ainZ8kSWlOJTxxSdfdxOyYlK
         aH4KJfng48/vbO6q+JU2VKQI9AvQVsC5l6J1VH6CQkUjKPNk0NDcOJH6H4PtC7Py5vR4
         8IIV8ekNCEL7DKQ533czVGmC+rDieaAbYBsMqSsE3SiyqcHZM4y1x5CycFlfj5X3S+vQ
         ZbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789541859; x=1790146659;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NKzNesC0LhJFIDuZhUW/K+h4UvLvdFAJBHAUljGQgV0=;
        b=Eq99Nl5L+NhyiM1sbojfzFFYqoBQKkELBF/7GrZ18awMrsvKNtpVPtKPLZTCUOBj+y
         Dt1NSESb3ngrFgzz3/wOLdqMadr81fi1/kRUGh59sXdgVgGc8s/aYLoB3cSErcleR6E5
         nswA7lg9xEBKLAvvoZH1Zn1M3yhEgoMxwNJa37LIk/ljwOntiRTLgaIL5fMgyQ1qW/Z+
         TiNxc2M7/W2co4U5su3YhTJVhN/O4gxFlCmH56mpuBKU4iYOredgf/blvardXK31X9dj
         N3jIBjKErY4t+TenLOMlBtIqF3l1Z0Lhlmfg2ofssbSul2fgg/w6cfxipNC/as3esrgZ
         NJ+w==
X-Forwarded-Encrypted: i=1; AKwUvBxh8ORnJ3wmARGtUBS2Lls3cnXcn9xE0N3H32lQ5z8sgY6Nu+NHoIXpumx8c6EID4FbmWM=@vger.kernel.org
X-Gm-Message-State: AFuF++mpI6Ac9/tw2CeJtBHtKbNUFqQuhr+7a0TKkjW+BD1XLxAohiJG
	1s3a7+mMGKeUT1osaDkE/fmS8pXL86BId9UqEHvIy2923eXWT20XZf6c
X-Gm-Gg: AYBFou27iXOuNubZzS5AQvVQ8JCgQkhnzhsxfvtNVppJ2L39jJR521PcKGt+AIJx4bM
	ir8H/DQlDrRT8nOiJQ2H3a8Afvg70nt0x8lZusP4neofOOAuNPJz/4pyxkEwOnbi14Er41qONPj
	zzkYwldFBBLS0m+tUYwcpJyuD+NFGNgPsbZ8igP0AIA6H6m4ZF6pIWJo9bdtcV+lu1SRq2wQReN
	FbnWtDnhATre+0EA3H+bBp4W8PciYtKEEMmlv824RotS3pgU95F9VRSxDVcdQayBxvbcFkuueFE
	nnC511nVOHFdaugL+SC8IX6W6Wzl8yJSzphQdurn/eI8z1lZSTwS8/vHYUofMC0sAHbYvIVEXpb
	S9SiqZGJiUXIafe3nGPu3+n8txDCSlxz7+y5RrENpTgnmp2A3Jv41nF5aM7+x+WE3o0uNwjwOgv
	SwXx/GkZx//LZKbrPeuWa2ViUVJfMSgfEKH7lr03Y1N4oq08fSu/CVoimpXvX6iJuLCzzQ427Fh
	XK0b98Jw0RqSu+re835OspOObAjJodqtC4klTnFTgrojvPhAkIheDBj
X-Received: by 2002:a17:90a:d407:b0:39d:fcbe:fe00 with SMTP id 98e67ed59e1d1-39e1e52242amr4313163a91.22.1789541858729;
        Tue, 15 Sep 2026 23:57:38 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d771e5sm4209554c88.15.2026.09.15.23.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:57:38 -0700 (PDT)
Date: Wed, 16 Sep 2026 12:27:31 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: paulmck@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, boqun@kernel.org, urezki@gmail.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Guard deferred QS on kernel exit behind
 need_deferred_qs() check
Message-ID: <aqo9k7ajQr6LRZHl@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260915102241.1344738-1-mkchauras@gmail.com>
 <aqkzzeXsVd91X4mZ@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqkzzeXsVd91X4mZ@localhost.localdomain>

On Tue, Sep 15, 2026 at 02:02:21PM +0200, Frederic Weisbecker wrote:
> Le Tue, Sep 15, 2026 at 03:52:41PM +0530, Mukesh Kumar Chaurasiya (IBM) a écrit :
> > ct_kernel_exit() unconditionally calls rcu_preempt_deferred_qs(current)
> > on every return to userspace.
> 
> When nohz_full is active, right?
> 
Yes, correct. I should have been more precise — this is only reached
on nohz_full CPUs under CONFIG_CONTEXT_TRACKING_IDLE.
> > On the common fast path nothing is
> > actually deferred, so this is a needless write to
> > current->rcu_read_unlock_special
> 
> When nothing is to be deferred, rcu_preempt_deferred_qs() does nothing, right?
> 
> And if some nohz_full workloads involve rare syscalls, they usually run a single
> task, so no preemption that would trigger a deferred qs.
> 
> 
You are right, I missed that. rcu_preempt_deferred_qs() already
bails out at line 619 of tree_plugin.h via the same
!rcu_preempt_need_deferred_qs() check, so the outer guard in
rcu_ct_kernel_exit_qs() is entirely redundant.

The overhead I was seeing on ppc64le with SELinux-heavy workloads is
real, but I clearly haven't identified the right call site yet. I'll
drop this patch and profile more carefully before sending a v2.

Thanks for catching this.

Regards
Mukesh
> > -- a word that lives on the task_struct
> > and is therefore subject to cross-CPU cache-line traffic.
> > 
> > On weakly-ordered architectures such as ppc64le, rcu_read_lock() and
> > rcu_read_unlock() already issue lwsync/isync barriers and touch that
> > same cache line in the syscall body.  Bouncing it again at syscall exit
> > adds measurable overhead, particularly on workloads with a high syscall
> > rate (e.g. SELinux-heavy workloads where every AVC check issues a
> > system call).
> > 
> > Introduce rcu_ct_kernel_exit_qs() which wraps the deferred-QS call with
> > a rcu_preempt_need_deferred_qs() guard, matching the pattern already
> > used in rcu_flavor_sched_clock_irq():
> > 
> >   notrace void rcu_ct_kernel_exit_qs(void)
> >   {
> >           if (rcu_preempt_need_deferred_qs(current))
> >                   rcu_preempt_deferred_qs(current);
> >   }
> > 
> > The declaration is added to <linux/rcutree.h> and a stub no-op is added
> > to <linux/rcutiny.h> so that TINY_RCU builds are unaffected.
> > 
> > ct_kernel_exit() is updated to call rcu_ct_kernel_exit_qs() in place of
> > the direct rcu_preempt_deferred_qs() call.  Semantics are identical when
> > a deferred QS is actually pending; only the unnecessary write on the
> > fast path is eliminated.
> > 
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > ---
> >  include/linux/rcutiny.h   |  1 +
> >  include/linux/rcutree.h   |  1 +
> >  kernel/context_tracking.c |  2 +-
> >  kernel/rcu/tree.c         | 19 +++++++++++++++++++
> >  4 files changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> > index e56ded733b1b..dcad641eb2c2 100644
> > --- a/include/linux/rcutiny.h
> > +++ b/include/linux/rcutiny.h
> > @@ -120,6 +120,7 @@ static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
> >  	return false;
> >  }
> >  static inline void rcu_preempt_deferred_qs(struct task_struct *t) { }
> > +static inline void rcu_ct_kernel_exit_qs(void) { }
> >  void rcu_scheduler_starting(void);
> >  static inline void rcu_end_inkernel_boot(void) { }
> >  static inline bool rcu_inkernel_boot_has_ended(void) { return true; }
> > diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> > index 16a04202888b..d623f2a7d3fc 100644
> > --- a/include/linux/rcutree.h
> > +++ b/include/linux/rcutree.h
> > @@ -87,6 +87,7 @@ static inline void rcu_irq_exit_check_preempt(void) { }
> >  
> >  struct task_struct;
> >  void rcu_preempt_deferred_qs(struct task_struct *t);
> > +void rcu_ct_kernel_exit_qs(void);
> >  
> >  void exit_rcu(void);
> >  
> > diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> > index a743e7ffa6c0..011018214c6d 100644
> > --- a/kernel/context_tracking.c
> > +++ b/kernel/context_tracking.c
> > @@ -118,7 +118,7 @@ static void noinstr ct_kernel_exit(bool user, int offset)
> >  	lockdep_assert_irqs_disabled();
> >  	trace_rcu_watching(TPS("End"), ct_nesting(), 0, ct_rcu_watching());
> >  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
> > -	rcu_preempt_deferred_qs(current);
> > +	rcu_ct_kernel_exit_qs();
> >  
> >  	// instrumentation for the noinstr ct_kernel_exit_state()
> >  	instrument_atomic_write(&ct->state, sizeof(ct->state));
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 96848fc1f02b..c23478f70c17 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -368,6 +368,25 @@ notrace void rcu_momentary_eqs(void)
> >  }
> >  EXPORT_SYMBOL_GPL(rcu_momentary_eqs);
> >  
> > +/**
> > + * rcu_ct_kernel_exit_qs - report deferred QS on syscall/exception exit if needed
> > + *
> > + * Called from ct_kernel_exit() on every return to userspace.  Guards the
> > + * rcu_preempt_deferred_qs() call with rcu_preempt_need_deferred_qs() so that
> > + * on the common fast path -- where nothing is deferred -- we avoid the
> > + * cache-line traffic on current->rcu_read_unlock_special that the unconditional
> > + * call causes.  This is particularly significant on weakly-ordered architectures
> > + * (e.g. ppc64le) where rcu_read_lock/unlock issue lwsync/isync barriers and
> > + * already touch that cache line in the syscall body.
> > + *
> > + * Follows the same pattern used by rcu_flavor_sched_clock_irq().
> > + */
> > +notrace void rcu_ct_kernel_exit_qs(void)
> > +{
> > +	if (rcu_preempt_need_deferred_qs(current))
> > +		rcu_preempt_deferred_qs(current);
> > +}
> > +
> 
> rcu_preempt_deferred_qs() already has a rcu_preempt_need_deferred_qs() fast
> path. Am I missing something?
> 
> Thanks.
> 
> 
> >  /**
> >   * rcu_is_cpu_rrupt_from_idle - see if 'interrupted' from idle
> >   *
> > -- 
> > 2.55.0
> > 
> 
> -- 
> Frederic Weisbecker
> SUSE Labs
