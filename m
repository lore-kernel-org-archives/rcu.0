Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14962F50;
	Wed,  8 Jan 2025 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348741; cv=none; b=hqpsr3lhFibxGzRLrgvtR3cG8+7g+yTdKR+zK84SkzciMY/CRA6pviUOuxZL9Onc2ehdai+CIqPcYZcYF/wVNeCXhJ1AvQq8NrSBoYfZA3jWsMvtiGo5yphjjt6I84qPs2jTExn9drWunh5BytUgtYBMMKpTt7BT0wGvmiV7i+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348741; c=relaxed/simple;
	bh=9I7j5XkfhIUxIttw5b7/rEsDD6rjQVLZlm5IYO/+k5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQPK2Cc/I+yijWtgVfJfsOiWtw7EXqZDFWaCraMljm+l76JDm3NlDLW+utyTmGqdOl9UKcW+F/JWBcd3H0Kb2M3H11kzYsg6aWP1mfCRHdIRCelUwvVvQzO43xCgJVon1y5tgQ1MXWH4D+Of6Pt07KfZEN+KJyT4XkYhhLt09Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFe+oPmr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFe+oPmr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C252C4CED3;
	Wed,  8 Jan 2025 15:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736348740;
	bh=9I7j5XkfhIUxIttw5b7/rEsDD6rjQVLZlm5IYO/+k5M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cFe+oPmr7EAgkcFv1SSzL2iDfGv4IElm7vs4gw4yDHnHdcqmpUDan+3aXsjV/9KIA
	 Beqy5MXrHwnsK5aMKUDPRfrtiZhN8v9kwM3AJMz0qsxwMHxw9IMhB9DipFLPlrm1co
	 yZpUwaS+W+z/gnZ3cauUa0FiMScy9IvDomLgPZRWb3SzUheiP9zbnLQGQyjukbERhn
	 NVPe19dhVzfkQPrFPCnTIXmRtNPqVnpUnQi+JHOZ294l4fnE25II5nhbNfIOfXDtQR
	 SN8bTNwoHFT/9pLth6M7W8Y1E1paxC6A7cHdAfb4rpXPJIKd33NpuXzC2GjuaWx/0x
	 7I0pI7iq9RB6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1111BCE0B74; Wed,  8 Jan 2025 07:05:40 -0800 (PST)
Date: Wed, 8 Jan 2025 07:05:40 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, rcu@vger.kernel.org
Subject: Re: [paulmckrcu:dev.2024.12.24a] [srcu] 9216c28c6a:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <11d7148e-91d7-4f47-a191-666dbb81b0c2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <949f6251-d411-45ef-9f85-d5d069b90b0e@paulmck-laptop>
 <Z3Ym/DDtGOPamGjZ@xsang-OptiPlex-9020>
 <c8c4c6d6-ad52-4cd2-ba1f-c442da4432af@paulmck-laptop>
 <CALm+0cVbaJuMWMkU4g_6inCKiBVaVD3iixvBrfMJTqZ-3OUCvg@mail.gmail.com>
 <c2561f0c-9bc1-4492-b9dd-655502f101f7@paulmck-laptop>
 <CALm+0cWoK_+xMxZ1xddZGt9KxuUqkW13fqwtOm9NtBEd+LqBFQ@mail.gmail.com>
 <8f42f7ac-3d5d-43c7-a646-fe46576397ff@paulmck-laptop>
 <CALm+0cXXe86aAeyBYnb6z3xBFvLeGxD+yjg_uzBB5PHCG9f3QQ@mail.gmail.com>
 <6fbe434b-f08f-48b1-b536-5ee788603e76@paulmck-laptop>
 <CALm+0cXhttGGKR46h5QtZkvo_p166+R74O+BEr_uVou-RFV=1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cXhttGGKR46h5QtZkvo_p166+R74O+BEr_uVou-RFV=1Q@mail.gmail.com>

On Wed, Jan 08, 2025 at 01:55:12PM +0800, Z qiang wrote:
> >
> > On Tue, Jan 07, 2025 at 05:49:42PM +0800, Z qiang wrote:
> > > >
> > > > On Mon, Jan 06, 2025 at 11:24:54AM +0800, Z qiang wrote:
> > > > > >
> > > > > > On Fri, Jan 03, 2025 at 01:50:50PM +0800, Z qiang wrote:
> > > > > > > >
> > > > > > > > On Thu, Jan 02, 2025 at 01:41:16PM +0800, Oliver Sang wrote:
> > > > > > > > > hi, Zqiang, hi, Paul,
> > > > > > > > >
> > > > > > > > > On Tue, Dec 31, 2024 at 08:19:44AM -0800, Paul E. McKenney wrote:
> > > > > > > > > > On Tue, Dec 31, 2024 at 03:16:25PM +0800, Z qiang wrote:
> > > > > > > > >
> > > > > > > > > [...]
> > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > > > > > > > > > the same patch/commit), kindly add following tags
> > > > > > > > > > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > > > > > > > > > | Closes: https://lore.kernel.org/oe-lkp/202412311203.ca7bddba-lkp@intel.com
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Please try the following modifications:
> > > > > > > > >
> > > > > > > > > yes, the following modifications fix the issues we found for 9216c28c6a. thanks!
> > > > > > > > >
> > > > > > > > > Tested-by: kernel test robot <oliver.sang@intel.com>
> > > > > > > >
> > > > > > > > Thank you, and I will apply this during my next rebase.
> > > > > > > >
> > > > > > > > Zqiang, unless you tell me otherwise, I will add your Co-developed-by
> > > > > > > > and Signed-off-by.
> > > > > > > >
> > > > > > > > Either way, Happy Square New Year!
> > > > > > >
> > > > > > > Thank you,  Happy New Year!  :)
> > > > > >
> > > > > > And here you go!  Please let me know of anything I missed.
> > > > > >
> > > > > > And thank you for saving me the time it would have taken to track
> > > > > > this one down.  ;-)
> > > > > >
> > > > > >                                                         Thanx, Paul
> > > > > >
> > > > > > ------------------------------------------------------------------------
> > > > > >
> > > > > > commit 71c893e6d1857d1e4ea37aec557d734a560fdb39
> > > > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > > > Date:   Thu Dec 19 16:08:54 2024 -0800
> > > > > >
> > > > > >     srcu: Make SRCU readers use ->srcu_ctrs for counter selection
> > > > > >
> > > > > >     This commit causes SRCU readers to use ->srcu_ctrs for counter
> > > > > >     selection instead of ->srcu_idx.  This takes another step towards
> > > > > >     array-indexing-free SRCU readers.
> > > > > >
> > > > > >     [ paulmck: Apply kernel test robot feedback. ]
> > > > > >
> > > > > >     Co-developed-by: Z qiang <qiang.zhang1211@gmail.com>
> > > > > >     Signed-off-by: Z qiang <qiang.zhang1211@gmail.com>
> > > > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > >     Tested-by: kernel test robot <oliver.sang@intel.com>
> > > > > >
> > > > > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > > > > index c794d599db5c1..1b01ced61a45b 100644
> > > > > > --- a/include/linux/srcutree.h
> > > > > > +++ b/include/linux/srcutree.h
> > > > > > @@ -101,6 +101,7 @@ struct srcu_usage {
> > > > > >   */
> > > > > >  struct srcu_struct {
> > > > > >         unsigned int srcu_idx;                  /* Current rdr array element. */
> > > > > > +       struct srcu_ctr __percpu *srcu_ctrp;
> > > > > >         struct srcu_data __percpu *sda;         /* Per-CPU srcu_data array. */
> > > > > >         struct lockdep_map dep_map;
> > > > > >         struct srcu_usage *srcu_sup;            /* Update-side data. */
> > > > > > @@ -167,6 +168,7 @@ struct srcu_struct {
> > > > > >  #define __SRCU_STRUCT_INIT(name, usage_name, pcpu_name)                                                \
> > > > > >  {                                                                                              \
> > > > > >         .sda = &pcpu_name,                                                                      \
> > > > > > +       .srcu_ctrp = &pcpu_name.srcu_ctrs[0],                                                   \
> > > > > >         __SRCU_STRUCT_INIT_COMMON(name, usage_name)                                             \
> > > > > >  }
> > > > > >
> > > > > > @@ -222,13 +224,12 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
> > > > > >   */
> > > > > >  static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
> > > > > >  {
> > > > > > -       int idx;
> > > > > > +       struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
> > > > > >
> > > > > >         RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
> > > > > > -       idx = READ_ONCE(ssp->srcu_idx) & 0x1;
> > > > > > -       this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_locks.counter); /* Y */
> > > > > > +       this_cpu_inc(scp->srcu_locks.counter); /* Y */
> > > > > >         barrier(); /* Avoid leaking the critical section. */
> > > > > > -       return idx;
> > > > > > +       return scp - &ssp->sda->srcu_ctrs[0];
> > > > > >  }
> > > > > >
> > > > > >  /*
> > > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > > index d7ee2f345e192..3bf7f41ad72b8 100644
> > > > > > --- a/kernel/rcu/srcutree.c
> > > > > > +++ b/kernel/rcu/srcutree.c
> > > > > > @@ -253,8 +253,10 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
> > > > > >         atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
> > > > > >         INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
> > > > > >         ssp->srcu_sup->sda_is_static = is_static;
> > > > > > -       if (!is_static)
> > > > > > +       if (!is_static) {
> > > > > >                 ssp->sda = alloc_percpu(struct srcu_data);
> > > > > > +               ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];
> > > > > > +       }
> > > > > >         if (!ssp->sda)
> > > > > >                 goto err_free_sup;
> > > > >
> > > > > ssp->srcu_ctrp should be assigned a value under the condition that
> > > > > ssp->sda is  allocated successfully.
> > > > >
> > > > > -       if (!is_static) {
> > > > > +       if (!is_static)
> > > > >                 ssp->sda = alloc_percpu(struct srcu_data);
> > > > > -               ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];
> > > > > -       }
> > > > >         if (!ssp->sda)
> > > > >                 goto err_free_sup;
> > > > > +       if (!is_static)
> > > > > +               ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];
> > > >
> > > > It doesn't hurt to assign NULL to ssp->srcu_ctrp on allocation failure.
> > > >
> > > > Or am I missing something here?
> > >
> > > No, I just think in case of failed allocation, there is no need to set
> > > srcu_ctrp. :)
> >
> > True enough, but you are adding an extra "if", which is not free
> > from either an execution-time viewpoint (not an issue here) or from a
> > complexity viewpoint.  I am not ruling your change out, but neither am
> > I convinced.
> >
> > Please see below for the current state, which passes light testing even
> > given proper testing of _nmisafe().  Which I was failing to do before.
> >
> > Thoughts?
> >
> >                                                         Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > commit e8964cf2179673adc54aae38b62361fd0fdf89ff
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Thu Dec 19 16:08:54 2024 -0800
> >
> >     srcu: Make SRCU readers use ->srcu_ctrs for counter selection
> >
> >     This commit causes SRCU readers to use ->srcu_ctrs for counter
> >     selection instead of ->srcu_idx.  This takes another step towards
> >     array-indexing-free SRCU readers.
> >
> >     [ paulmck: Apply kernel test robot feedback. ]
> >
> >     Co-developed-by: Z qiang <qiang.zhang1211@gmail.com>
> >     Signed-off-by: Z qiang <qiang.zhang1211@gmail.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >     Tested-by: kernel test robot <oliver.sang@intel.com>
> >
> > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > index c794d599db5c1..1b01ced61a45b 100644
> > --- a/include/linux/srcutree.h
> > +++ b/include/linux/srcutree.h
> > @@ -101,6 +101,7 @@ struct srcu_usage {
> >   */
> >  struct srcu_struct {
> >         unsigned int srcu_idx;                  /* Current rdr array element. */
> > +       struct srcu_ctr __percpu *srcu_ctrp;
> >         struct srcu_data __percpu *sda;         /* Per-CPU srcu_data array. */
> >         struct lockdep_map dep_map;
> >         struct srcu_usage *srcu_sup;            /* Update-side data. */
> > @@ -167,6 +168,7 @@ struct srcu_struct {
> >  #define __SRCU_STRUCT_INIT(name, usage_name, pcpu_name)                                                \
> >  {                                                                                              \
> >         .sda = &pcpu_name,                                                                      \
> > +       .srcu_ctrp = &pcpu_name.srcu_ctrs[0],                                                   \
> >         __SRCU_STRUCT_INIT_COMMON(name, usage_name)                                             \
> >  }
> >
> > @@ -222,13 +224,12 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
> >   */
> >  static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
> >  {
> > -       int idx;
> > +       struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
> >
> >         RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
> > -       idx = READ_ONCE(ssp->srcu_idx) & 0x1;
> > -       this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_locks.counter); /* Y */
> > +       this_cpu_inc(scp->srcu_locks.counter); /* Y */
> >         barrier(); /* Avoid leaking the critical section. */
> > -       return idx;
> > +       return scp - &ssp->sda->srcu_ctrs[0];
> >  }
> >
> >  /*
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index d7ee2f345e192..308cc7b5098c5 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -253,8 +253,10 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
> >         atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
> >         INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
> >         ssp->srcu_sup->sda_is_static = is_static;
> > -       if (!is_static)
> > +       if (!is_static) {
> >                 ssp->sda = alloc_percpu(struct srcu_data);
> > +               ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];
> > +       }
> >         if (!ssp->sda)
> >                 goto err_free_sup;
> >         init_srcu_struct_data(ssp);
> > @@ -742,12 +744,11 @@ EXPORT_SYMBOL_GPL(__srcu_check_read_flavor);
> >   */
> >  int __srcu_read_lock(struct srcu_struct *ssp)
> >  {
> > -       int idx;
> > +       struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
> >
> > -       idx = READ_ONCE(ssp->srcu_idx) & 0x1;
> > -       this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_locks.counter);
> > +       this_cpu_inc(scp->srcu_locks.counter);
> >         smp_mb(); /* B */  /* Avoid leaking the critical section. */
> > -       return idx;
> > +       return scp - &ssp->sda->srcu_ctrs[0];
> >  }
> >  EXPORT_SYMBOL_GPL(__srcu_read_lock);
> >
> > @@ -772,13 +773,12 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
> >   */
> >  int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
> >  {
> > -       int idx;
> > -       struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
> > +       struct srcu_ctr __percpu *scpp = READ_ONCE(ssp->srcu_ctrp);
> > +       struct srcu_ctr *scp = this_cpu_ptr(scpp);
> 
> Whether raw_cpu_ptr() should be used, otherwise it will appear:
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: init/1
> [    7.324304][    T1] caller is debug_smp_processor_id+0x1b/0x30
> [    7.324308][    T1] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted
> 6.13.0-rc2-yoctodev-standard+ #99
> 10b660623b999b402f7cd2198fe7d4ebd36ef1d0
> [    7.324311][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9,
> 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [    7.324314][    T1] Call Trace:
> [    7.324315][    T1]  <TASK>
> [    7.324319][    T1]  dump_stack_lvl+0xbb/0xd0
> [    7.324326][    T1]  dump_stack+0x14/0x20
> [    7.324330][    T1]  check_preemption_disabled+0xc7/0xf0
> [    7.324340][    T1]  debug_smp_processor_id+0x1b/0x30
> [    7.324343][    T1]  __srcu_read_lock_nmisafe+0x39/0xd0
> [    7.324353][    T1]  console_flush_all+0x18c/0xbf0
> ........

You are quite right!  Fixing, thank you!

Ah, and the reason that the SRCU-P scenario did not catch this is that
I didn't force CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y.

							Thanx, Paul

> Thanks
> Zqiang
> 
> >
> > -       idx = READ_ONCE(ssp->srcu_idx) & 0x1;
> > -       atomic_long_inc(&sdp->srcu_ctrs[idx].srcu_locks);
> > +       atomic_long_inc(&scp->srcu_locks);
> >         smp_mb__after_atomic(); /* B */  /* Avoid leaking the critical section. */
> > -       return idx;
> > +       return scpp - &ssp->sda->srcu_ctrs[0];
> >  }
> >  EXPORT_SYMBOL_GPL(__srcu_read_lock_nmisafe);
> >
> > @@ -1152,6 +1152,8 @@ static void srcu_flip(struct srcu_struct *ssp)
> >         smp_mb(); /* E */  /* Pairs with B and C. */
> >
> >         WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1); // Flip the counter.
> > +       WRITE_ONCE(ssp->srcu_ctrp,
> > +                  &ssp->sda->srcu_ctrs[!(ssp->srcu_ctrp - &ssp->sda->srcu_ctrs[0])]);
> >
> >         /*
> >          * Ensure that if the updater misses an __srcu_read_unlock()
> > @@ -2000,6 +2002,7 @@ static int srcu_module_coming(struct module *mod)
> >                 ssp->sda = alloc_percpu(struct srcu_data);
> >                 if (WARN_ON_ONCE(!ssp->sda))
> >                         return -ENOMEM;
> > +               ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];
> >         }
> >         return 0;
> >  }
