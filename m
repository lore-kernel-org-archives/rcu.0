Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E44B17C9E8;
	Tue,  7 Jan 2025 05:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736229051; cv=none; b=TeUzeeB2QUXiEPnTSJtAopuxrG349v/3BaLWEe2dURPfXv9/UkxSFAWbqlj9dwNPXTXebkUo2lS1QyjtCgB3hlMM6eYIW9ne9rznSbvLM8FjNq5bbwGE5duRny0LAuCMz+LE+iqRW5DjzjHX8iZ6xemvClb5/UcPyuoy0dae4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736229051; c=relaxed/simple;
	bh=mPqkHolay7yXa56tkt6buDJ2oLJOcqqZ3s/yJ3UqDsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+XAWAqqgP9N7++P0ubO9SoBJPUFXvvcfjctCcnuAgciNh6Nc43sSrI1gnYuPbdzPIJufNwv1FBZWvwjNX0vQO1ExkmcVBHOplANLKPYtej6umSGGvRRL9zgTECAlrwX631iBuvdRUjNTsOTrZeXBFwyZmjs8GIbisXBvfT/aiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i17FGAdM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i17FGAdM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2375AC4CED6;
	Tue,  7 Jan 2025 05:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736229051;
	bh=mPqkHolay7yXa56tkt6buDJ2oLJOcqqZ3s/yJ3UqDsk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=i17FGAdM17lGkT5M3UjJfy6IXvW59XK4wxbVE08TgVeyhcM9maSLk74yzlBJ3CFqG
	 lgNO6F0MM6t7UoPtY4tdSmtex97z9gOEuI31UueH+88ngcRjIr9QgoUORmUws9QM+9
	 +ZfXXdA7ZGcy204aJh6GoVgM+W8DGrezTN7UPYpNbLvoLAU9WH2RNeLd0X4dp3NltL
	 DzvAKFHMyi31SNsWV/HCT9nVrMD9Wjd+z1e7OlDvipV0faFXWjbWkKTpKgrlST8WW6
	 uN19i6Uz8TPcXfi2UX4ft6pcAtgt8dzVUmQvY8JRPJVJEBOCLPlC88quX4eZ4+A/5v
	 dKDeS/CSKMwSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9732ACE0C4A; Mon,  6 Jan 2025 21:50:50 -0800 (PST)
Date: Mon, 6 Jan 2025 21:50:50 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, rcu@vger.kernel.org
Subject: Re: [paulmckrcu:dev.2024.12.24a] [srcu] 9216c28c6a:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <8f42f7ac-3d5d-43c7-a646-fe46576397ff@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202412311203.ca7bddba-lkp@intel.com>
 <CALm+0cWOxUm_hrNe4UP4Z-vyr4RCOw+dc=kCBTgsyjHFHiHDsg@mail.gmail.com>
 <949f6251-d411-45ef-9f85-d5d069b90b0e@paulmck-laptop>
 <Z3Ym/DDtGOPamGjZ@xsang-OptiPlex-9020>
 <c8c4c6d6-ad52-4cd2-ba1f-c442da4432af@paulmck-laptop>
 <CALm+0cVbaJuMWMkU4g_6inCKiBVaVD3iixvBrfMJTqZ-3OUCvg@mail.gmail.com>
 <c2561f0c-9bc1-4492-b9dd-655502f101f7@paulmck-laptop>
 <CALm+0cWoK_+xMxZ1xddZGt9KxuUqkW13fqwtOm9NtBEd+LqBFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cWoK_+xMxZ1xddZGt9KxuUqkW13fqwtOm9NtBEd+LqBFQ@mail.gmail.com>

On Mon, Jan 06, 2025 at 11:24:54AM +0800, Z qiang wrote:
> >
> > On Fri, Jan 03, 2025 at 01:50:50PM +0800, Z qiang wrote:
> > > >
> > > > On Thu, Jan 02, 2025 at 01:41:16PM +0800, Oliver Sang wrote:
> > > > > hi, Zqiang, hi, Paul,
> > > > >
> > > > > On Tue, Dec 31, 2024 at 08:19:44AM -0800, Paul E. McKenney wrote:
> > > > > > On Tue, Dec 31, 2024 at 03:16:25PM +0800, Z qiang wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > > >
> > > > > > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > > > > > the same patch/commit), kindly add following tags
> > > > > > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > > > > > | Closes: https://lore.kernel.org/oe-lkp/202412311203.ca7bddba-lkp@intel.com
> > > > > > > >
> > > > > > >
> > > > > > > Please try the following modifications:
> > > > >
> > > > > yes, the following modifications fix the issues we found for 9216c28c6a. thanks!
> > > > >
> > > > > Tested-by: kernel test robot <oliver.sang@intel.com>
> > > >
> > > > Thank you, and I will apply this during my next rebase.
> > > >
> > > > Zqiang, unless you tell me otherwise, I will add your Co-developed-by
> > > > and Signed-off-by.
> > > >
> > > > Either way, Happy Square New Year!
> > >
> > > Thank you,  Happy New Year!  :)
> >
> > And here you go!  Please let me know of anything I missed.
> >
> > And thank you for saving me the time it would have taken to track
> > this one down.  ;-)
> >
> >                                                         Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > commit 71c893e6d1857d1e4ea37aec557d734a560fdb39
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
> > index d7ee2f345e192..3bf7f41ad72b8 100644
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
> 
> ssp->srcu_ctrp should be assigned a value under the condition that
> ssp->sda is  allocated successfully.
> 
> -       if (!is_static) {
> +       if (!is_static)
>                 ssp->sda = alloc_percpu(struct srcu_data);
> -               ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];
> -       }
>         if (!ssp->sda)
>                 goto err_free_sup;
> +       if (!is_static)
> +               ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];

It doesn't hurt to assign NULL to ssp->srcu_ctrp on allocation failure.

Or am I missing something here?

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
> > @@ -772,13 +773,11 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
> >   */
> >  int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
> >  {
> > -       int idx;
> > -       struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
> > +       struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
> 
> Should this be the case?
> 
> struct srcu_ctr  *scp = raw_cpu_ptr(ssp->srcu_ctrp);

Good catch!  This is messed up.  I am now thinking in terms of something
like this:

	struct srcu_ctr *scp = this_cpu_ptr(READ_ONCE(ssp->srcu_ctrp));

Except that I broke the CONFIG_NEED_SRCU_NMI_SAFE=y case at some point,
and need to fix that first.  This commit works:

c10edfa489eb ("srcu: Pull ->srcu_{un,}lock_count into a new srcu_ctr structure")

I am now trying:

71c893e6d185 ("srcu: Make SRCU readers use ->srcu_ctrs for counter selection")

The trick is to apply this patch:

------------------------------------------------------------------------
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 26ae869865a12..74809a083e2b5 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -66,7 +66,7 @@ config TREE_SRCU
 	  This option selects the full-fledged version of SRCU.
 
 config NEED_SRCU_NMI_SAFE
-	def_bool HAVE_NMI && !ARCH_HAS_NMI_SAFE_THIS_CPU_OPS && !TINY_SRCU
+	def_bool HAVE_NMI && !TINY_SRCU
 
 config TASKS_RCU_GENERIC
 	def_bool TASKS_RCU || TASKS_RUDE_RCU || TASKS_TRACE_RCU
------------------------------------------------------------------------

Or run some system with CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=n.

> > -       idx = READ_ONCE(ssp->srcu_idx) & 0x1;
> > -       atomic_long_inc(&sdp->srcu_ctrs[idx].srcu_locks);
> > +       atomic_long_inc(&scp->srcu_locks);
> >         smp_mb__after_atomic(); /* B */  /* Avoid leaking the critical section. */
> > -       return idx;
> > +       return scp - &ssp->sda->srcu_ctrs[0];
> >  }
> >  EXPORT_SYMBOL_GPL(__srcu_read_lock_nmisafe);
> >
> > @@ -1152,6 +1151,8 @@ static void srcu_flip(struct srcu_struct *ssp)
> >         smp_mb(); /* E */  /* Pairs with B and C. */
> >
> >         WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1); // Flip the counter.
> > +       WRITE_ONCE(ssp->srcu_ctrp,
> > +                  &ssp->sda->srcu_ctrs[!(ssp->srcu_ctrp - &ssp->sda->srcu_ctrs[0])]);
> >
> >         /*
> >          * Ensure that if the updater misses an __srcu_read_unlock()
> > @@ -1998,6 +1999,7 @@ static int srcu_module_coming(struct module *mod)
> >         for (i = 0; i < mod->num_srcu_structs; i++) {
> >                 ssp = *(sspp++);
> >                 ssp->sda = alloc_percpu(struct srcu_data);
> > +               ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];
> >                 if (WARN_ON_ONCE(!ssp->sda))
> >                         return -ENOMEM;
> 
> 
> -               ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];
>                 if (WARN_ON_ONCE(!ssp->sda))
>                         return -ENOMEM;
> +               ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];

Again, the assigment does not hurt anything, but in this case I agree
that your way is more clear, so I will use that.

							Thanx, Paul
