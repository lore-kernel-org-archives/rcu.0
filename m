Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33E43EC813
	for <rcu@vger.kernel.org>; Wed, 16 Sep 2026 07:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542048; cv=none; b=h7yInNJrqC96GwmWKLyRdhbrbB4+/7UNASMEEFJuwRacMCFJ8nvNCDZMsFEh6L6cPbXHATox0KJvm46r9sWyx5+0TkG2Exh8PfZXPBWTxhi+fz7FHpBdFL/+7tKDojHC+TlyC7eknPF5xUMCxrwKlpFvTj2Bg9f2VI95VveE4d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542048; c=relaxed/simple;
	bh=LG6AJIIkRfn7S+iYZV4oKjByyozoP/ADpIP7sRwcgAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lff7RWTbwhBvr6x1HOY3r8oamN9gtpl2F0p2N9dzAoTt1/wW8Et+Pgl7b3FFCiSgeSgL807WG1subScrXA0eGfiXpToEBbhcxekMox/ifGeA8WimqRaKD/b92HOuPkytuJeWR/mOSrkvbbgoPz+Fl0vJ+vhsz36Hz1jKNgLdUsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnP67Ql0; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnP67Ql0"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4ae616175so386834a12.1
        for <rcu@vger.kernel.org>; Wed, 16 Sep 2026 00:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789542036; x=1790146836; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6wrThbUr5h6Qt4cUaRIQYOkzVBKkR93c24dMiK4OIRw=;
        b=mnP67Ql0GE+9AKwtFlD0fj5vjLNexRXDF3RieJz7E9p4oNX/hnKu7oUNiFi6DKzXgY
         +V/L4Z2KAXTK3I8Msjh3teDq29LSHM9BDEslCWzuYRhvzc2BvMtWfnGSgEc6mBxjPbfz
         aVxxxBOhOyOfVCBeN9unCtJlXsy+UCXbPBfrx+mwUswe0GwwNvcDnXsp8fgsUK3LwnSH
         XWSbfvMQJh/Xn10dk+dIhxc+e1ABOPxCSOIJLr8yP/299bkChkT00ZAasiCJqB5PzunB
         lfIwfqIWX37M5WK4G/GcbXSZqgrPsYeLBzRp4UZhH7m4EhdQa3UtRevjvDtgEoWuu7is
         2Fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789542036; x=1790146836;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6wrThbUr5h6Qt4cUaRIQYOkzVBKkR93c24dMiK4OIRw=;
        b=qck0ZD9n1KiQMgAlksnLbqXDP+I6d3w4X4aIg7qWyfXvau9asiv8289avRIaQCrfl6
         7QgEXJSE2n64jCI59Pxtcr4Nt4P4K7ujB4h2wSahq0DLTB6/tPQQfS5wP0BeZax8dmUG
         q1vqGLvlZOOzgIpmRuadPlC0z8WWk24Bp9P4DA1uJ6rEZlPciCTWYe9uZgi6yBIvYhHB
         lnirUABDuDiTfZUrwgUevRQt8t0LRNnvCr9L7fq77x65ITAdgw25Sb+VYuYU1svR1CUx
         a7Qv+uyotFylBRSToOKqPfRYbPYRdWJLXU90nMmf/eVKb21ueiiTauGqnclFgDKGURtd
         1jNQ==
X-Forwarded-Encrypted: i=1; AKwUvBynRd2mWQclObKMXNzA0UBzeYoksU0KRS2/wIaQV5IhTcHXRsaQ26wQSBXbDVfhZCQIi5Q=@vger.kernel.org
X-Gm-Message-State: AFuF++nzCTV8fXUzwT6IgyC5NuPU881X5K1x7rR6jydSQV8CvuYzixRH
	GsMwyvgeDqAegYLaEGHdSLyh8LF9ip/fST/xpz3hvMBqVoUjlWtS372Ud/0y8A==
X-Gm-Gg: AYBFou2G4hIcaO5WRJwWZ7BVEll91jeQ3Zz8zwNxdEjcTX8wqY00Wj0ECh1kB3vkb/L
	J70tZzzG8W0vY0exQZVPtS4f0kQvP21t4l2acQKO/UpJLgAWlTYdanbkvy4y8fNm+oWMYFp8uOt
	Y6FV9yJ8yUaJTiS5Bn41oNwmqh4PypmcK3LjZo5mKU0+QJn9ioaDjn4/mxzltxNrDkEn5mkWT8z
	4ZMtMJwIV4y1bbHt68b+Cja4m0N0oKG5hP2vcCjmnUc2APs0ZIWfiiWRqqMhtVThoFtHYfFVwwx
	ZYYpJNT2NO5AQUbUeGuAjBlcDygzgaGs+xy7aLtJbiXOLHQomFsPKSKRiCACZBnIblkcvIL9zXt
	+I1BN9dPqPsTCpOX0lnn7RtlJsMpwormYOeJn9Cn0GdAEbTPzhpePwbajBav8nAWUF1w/RJSDJx
	0ropcGRZ2vjmETq9XWZtNjFSAb2GtkqJxTgyB5ezyY6iFipzHL4UOpdJFbZnubcLkeuMX7nBpk/
	0Fi0y/Wh301Lmt5Oqe5XvtB8BXUxgDwqQdFeh7RFlgcJaQUQZnLr3hhgg==
X-Received: by 2002:a05:6a21:6b10:b0:3da:3bdb:b22a with SMTP id adf61e73a8af0-3dd5f71a912mr3967045637.20.1789542035671;
        Wed, 16 Sep 2026 00:00:35 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395cacce6sm4225845c88.1.2026.09.16.00.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 00:00:35 -0700 (PDT)
Date: Wed, 16 Sep 2026 12:30:28 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, boqun@kernel.org, urezki@gmail.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, qiang.zhang@linux.dev, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Guard deferred QS on kernel exit behind
 need_deferred_qs() check
Message-ID: <aqo-KIDk0Z5gRM5u@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260915102241.1344738-1-mkchauras@gmail.com>
 <dc328ed5-12fd-4e52-b340-d4a5adb575d2@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc328ed5-12fd-4e52-b340-d4a5adb575d2@paulmck-laptop>

On Tue, Sep 15, 2026 at 05:06:39PM -0700, Paul E. McKenney wrote:
> On Tue, Sep 15, 2026 at 03:52:41PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > ct_kernel_exit() unconditionally calls rcu_preempt_deferred_qs(current)
> > on every return to userspace.  On the common fast path nothing is
> > actually deferred, so this is a needless write to
> > current->rcu_read_unlock_special -- a word that lives on the task_struct
> > and is therefore subject to cross-CPU cache-line traffic.
> > 
> > On weakly-ordered architectures such as ppc64le, rcu_read_lock() and
> > rcu_read_unlock() already issue lwsync/isync barriers and touch that
> > same cache line in the syscall body.
> 
> You lost me on this one.  The non-debugging operations in preemptible
> rcu_read_lock() are:
> 
> 	WRITE_ONCE(current->rcu_read_lock_nesting, READ_ONCE(current->rcu_read_lock_nesting) + 1);
> 	barrier(); // Empty as with the "memory" clobber.
> 
> I don't see how this emits lwsync or isync instructions.
> 
> Now I do agree that rcu_read_unlock() will emit all sorts of heavyweight
> instructions in the case where there are deferred quiescent states,
> which is the only case where rcu_preempt_need_deferred_qs() is important.
> But I don't see how rcu_read_unlock() emits isync or lwsync in the normal
> case where the preceding RCU read-side critical section was not preempted.
> 
> But on rcu_read_lock(), what am I missing?
> 
Hey Paul,
You are correct.  Looking at __rcu_read_lock() in tree_plugin.h, it is
just a WRITE_ONCE on ->rcu_read_lock_nesting and a compiler barrier().
No lwsync, no isync.  That claim in the commit message was wrong.

> >                                       Bouncing it again at syscall exit
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
> 
> You also lost me here.  The rcu_preempt_deferred_qs() function is as
> follows:
> 
> notrace void rcu_preempt_deferred_qs(struct task_struct *t)
> {
> 	unsigned long flags;
> 
> 	if (!rcu_preempt_need_deferred_qs(t))
> 		return;
> 	local_irq_save(flags);
> 	rcu_preempt_deferred_qs_irqrestore(t, flags);
> }
> 
> So the only savings is the local_irq_save(), and even then only in the
> uncommon case where rcu_preempt_need_deferred_qs() returns true.
> 
> So again, what am I missing here?
> 
> 							Thanx, Paul
> 
Nothing you are not missing anything.  Looking at
rcu_preempt_deferred_qs() again, the fast path (need_deferred_qs
returns false) already returns immediately with no writes and no
irq save. My wrapper adds an outer check that is redundant with
the one already inside.  In the case where need_deferred_qs() *is*
true, my patch saves a local_irq_save() only to then call
rcu_preempt_deferred_qs() which immediately does local_irq_save()
again — so it saves nothing even there.

I will drop this patch and properly profile the regression before
sending anything further.

Sorry for the noise.

Regards,
Mukesh

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
> >  /**
> >   * rcu_is_cpu_rrupt_from_idle - see if 'interrupted' from idle
> >   *
> > -- 
> > 2.55.0
> > 
