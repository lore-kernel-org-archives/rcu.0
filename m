Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AA717C7BD;
	Fri,  1 Nov 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730469593; cv=none; b=Ddr4Chn/EXsXrgHVZLBn4do8VR/pJAXpOaQSgxb5sTTNMISmzXInAveOevuWHoX633IBFFrCd5Fxcdv6dnYwy9PMsEzYanV/54JfQkEP6sZ7QVmpUtYCRdz080URaLERBHWkgIHbyktYVXSZG/7EVL3v59NZu7hjmEZIRiAHlUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730469593; c=relaxed/simple;
	bh=mg+5hEwdTdV8IE0oBNIsJ8IUYJo6J5Xk7iZ8CG8OSk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwtLKjvtTKVBLP0ucT1HcPmvZD8PlYvMQWQczWBo+Atu7m5KSY8WlSDKZCHNoBaP2F8eYaNMH0FCi+B9902SutDlpkGhJbiriWg8dQu5YC1f7QUG1VD63L7t4U1/dLV1GYkocMohXzv6fnmy8GZCW6dbdfcbF/xP1sZJuxa4hZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKvS+R4Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKvS+R4Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB2DC4CECD;
	Fri,  1 Nov 2024 13:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730469593;
	bh=mg+5hEwdTdV8IE0oBNIsJ8IUYJo6J5Xk7iZ8CG8OSk0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eKvS+R4QxwXg6vd4UmQqo0vBwdnnAoeSzqE0HSxSnN/xvFbJ6VlBnKe4pySxPOHdW
	 utKm9PX+Zlqsj9OpbL/CPcYuFYfqgOugQ5uIkjY0bsQmdVNt+yNK3NPegxX6lP645n
	 gGSwhd2mjgt0rXu4eOaqiRkNjm1bUIq2iPOlgwCKEhG61yYDAiiZOwDPrhF+1LU/ex
	 bsTY2yOAggEDQ1MvyCtxIBPPx48v6IahrTrD0Oi12dpy1iCgAwPdNZJPZSWO+ldIdt
	 8OFHxn99xU4Rr8qMOmfdXQwytDSNLbSHrURHOklMChcGvFy+CXHp9YS3pgY/EtxwjY
	 LalejN7FSnBdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C78A9CE0995; Fri,  1 Nov 2024 06:59:52 -0700 (PDT)
Date: Fri, 1 Nov 2024 06:59:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Cheng-Jui Wang =?utf-8?B?KOeOi+ato+edvyk=?= <Cheng-Jui.Wang@mediatek.com>
Cc: "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dianders@chromium.org" <dianders@chromium.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"frederic@kernel.org" <frederic@kernel.org>,
	wsd_upstream <wsd_upstream@mediatek.com>,
	Bobule Chang =?utf-8?B?KOW8teW8mOe+qSk=?= <bobule.chang@mediatek.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	"joel@joelfernandes.org" <joel@joelfernandes.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH v3 rcu 3/3] rcu: Finer-grained grace-period-end checks in
 rcu_dump_cpu_stacks()
Message-ID: <c3635aaf-1fb5-4464-bd58-07f686536d9a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <92193018-8624-495e-a685-320119f78db1@paulmck-laptop>
 <20241016161931.478592-3-paulmck@kernel.org>
 <c3218fbe-7bb1-4fd6-8b00-beee244ffeae@paulmck-laptop>
 <b2b0bceacbd080e13b3aa7ad05569a787df4646d.camel@mediatek.com>
 <adb044e2-8f62-4367-9a22-30515f5647b1@paulmck-laptop>
 <d0adc7d14da0f21909eef68acf19fc5706a4b1af.camel@mediatek.com>
 <9e90d04e-081b-4730-890b-295ed52747de@paulmck-laptop>
 <00ace254f9085aad12684185b77504bd911aed63.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00ace254f9085aad12684185b77504bd911aed63.camel@mediatek.com>

On Fri, Nov 01, 2024 at 07:41:27AM +0000, Cheng-Jui Wang (王正睿) wrote:
> On Wed, 2024-10-30 at 06:54 -0700, Paul E. McKenney wrote:
> > > > Alternatively, arm64 could continue using nmi_trigger_cpumask_backtrace()
> > > > with normal interrupts (for example, on SoCs not implementing true NMIs),
> > > > but have a short timeout (maybe a few jiffies?) after which its returns
> > > > false (and presumably also cancels the backtrace request so that when
> > > > the non-NMI interrupt eventually does happen, its handler simply returns
> > > > without backtracing).  This should be implemented using atomics to avoid
> > > > deadlock issues.  This alternative approach would provide accurate arm64
> > > > backtraces in the common case where interrupts are enabled, but allow
> > > > a graceful fallback to remote tracing otherwise.
> > > > 
> > > > Would you be interested in working this issue, whatever solution the
> > > > arm64 maintainers end up preferring?
> > > 
> > > The 10-second timeout is hard-coded in nmi_trigger_cpumask_backtrace().
> > > It is shared code and not architecture-specific. Currently, I haven't
> > > thought of a feasible solution. I have also CC'd the authors of the
> > > aforementioned patch to see if they have any other ideas.
> > 
> > It should be possible for arm64 to have an architecture-specific hook
> > that enables them to use a much shorter timeout.  Or, to eventually
> > switch to real NMIs.
> 
> There is already another thread discussing the timeout issue, but I
> still have some questions about RCU. To avoid mixing the discussions, I
> start this separate thread to discuss RCU.
> 
> > > Regarding the rcu stall warning, I think the purpose of acquiring `rnp-
> > > > lock` is to protect the rnp->qsmask variable rather than to protect
> > > 
> > > the `dump_cpu_task()` operation, right?
> > 
> > As noted below, it is also to prevent false-positive stack dumps.
> > 
> > > Therefore, there is no need to call dump_cpu_task() while holding the
> > > lock.
> > > When holding the spinlock, we can store the CPUs that need to be dumped
> > > into a cpumask, and then dump them all at once after releasing the
> > > lock.
> > > Here is my temporary solution used locally based on kernel-6.11.
> > > 
> > > +     cpumask_var_t mask;
> > > +     bool mask_ok;
> > > 
> > > +     mask_ok = zalloc_cpumask_var(&mask, GFP_ATOMIC);
> > >       rcu_for_each_leaf_node(rnp) {
> > >               raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > >               for_each_leaf_node_possible_cpu(rnp, cpu)
> > >                       if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu))
> > > {
> > >                               if (cpu_is_offline(cpu))
> > >                                       pr_err("Offline CPU %d blocking
> > > current GP.\n", cpu);
> > > +                             else if (mask_ok)
> > > +                                     cpumask_set_cpu(cpu, mask);
> > >                               else
> > >                                       dump_cpu_task(cpu);
> > >                       }
> > >               raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > >       }
> > > +     if (mask_ok) {
> > > +             if (!trigger_cpumask_backtrace(mask)) {
> > > +                     for_each_cpu(cpu, mask)
> > > +                             dump_cpu_task(cpu);
> > > +             }
> > > +             free_cpumask_var(mask);
> > > +     }
> > > 
> > > After applying this, I haven't encountered the lockup issue for five
> > > days, whereas it used to occur about once a day.
> > 
> > We used to do it this way, and the reason that we changed was to avoid
> > false-positive (and very confusing) stack dumps in the surprisingly
> > common case where the act of dumping the first stack caused the stalled
> > grace period to end.
> > 
> > So sorry, but we really cannot go back to doing it that way.
> > 
> >                                                         Thanx, Paul
> 
> Let me clarify, the reason for the issue mentioned above is that it
> pre-determines all the CPUs to be dumped before starting the dump
> process. Then, dumping the first stack caused the stalled grace period
> to end. Subsequently, many CPUs that do not need to be dumped (false
> positives) are dumped.
> 
> So,to prevent false positives, it should be about excluding those CPUs
> that do not to be dumped, right? Therefore, the action that trully help
> is actually "releasing the lock after each dump (allowing other CPUs to
> update qsmask) and rechecking (gp_seq and qsmask) to confirm whether to
> continue dumping".
> 
> I think holding the lock while dumping CPUs does not help prevent false
> positives; it only blocks those CPUs waiting for the lock (e.g., CPUs
> aboult to report qs). For CPUs that do not interact with this lock,
> holding it should not have any impact. Did I miss anything?

Yes.

The stalled CPU could unstall itself just after the lock was released,
so that the stack dump would be from some random irrelevant and confusing
point in the code.  This would not be a good thing.  In contrast, with the
lock held, the stalled CPU cannot fully exit its RCU read-side critical
section, so that the dump has at least some relevance.

Let's please instead confine the change to architecture-specific code
that chooses to use interrupts instead of NMIs, as suggested in my
previous email.  If there is more than one such architecture (arm64 and
arm32?), they can of course share code, if appropriate.

							Thanx, Paul
