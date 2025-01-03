Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC531FBCBF;
	Fri,  3 Jan 2025 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735924224; cv=none; b=B0a7t19dCM+yJUrNmx0811zSTBXwrLnnksgqVFaVhYzXeDRrtEQQPCPLVMGb9ag5ZfOpFE4BdeGe1XVwDi19RFVubtj72nHwGWCufJX4buWicPQl398S+TwPEatOXkf79qllMQwls+V777qOCh/BHD1iTseQSjSp0xnoLPyWe+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735924224; c=relaxed/simple;
	bh=barAxKaJ2q8pB/8tLRWSayJ/kjolDBmX/UvAf0Tj5rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcK8DcBme8ZsupDhoAYRStznvEZcomnyHRjll8XgK8G01onA+P1uwdJLpOuP3SqSboes2pvCWGzDO3nSGDhqcdszDsp2HAL7SdmCnMEKWn2UwNugg4lQh7tpmTB8QrgzWQ2R3xjGEHZht/YFC6xV0tSGJNSQHkI/zDYN2izMXFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrBEDgzD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrBEDgzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A6BC4CECE;
	Fri,  3 Jan 2025 17:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735924224;
	bh=barAxKaJ2q8pB/8tLRWSayJ/kjolDBmX/UvAf0Tj5rw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JrBEDgzDolDBN2S4Jf5k/E6VOoDWuhB/YHcXrrrtyai5B5dAS1yAorZWPC7UuuEsZ
	 v4BijLQH8mXHqNFMYNaioJ7CHdRkEjdGUeGhgwlj2CYs32XoFLGOxoIjKLbCW+r3fZ
	 +whn/5GEGrVcfZ1fRWH1laJGAkeurfFTlhX78z4HderMyY8O0vH5DpOGlLT9EeoP77
	 P4exO9MqkavWCPC3Fa6N43c+Ho5DY+zjMR+DE69PniOjpHgikvxd3+L+n3FN+ivDQ+
	 WWJCsgFFJ3z00oe2muXTTbSwle0s2UtGPxuJKwM7CLsTzgK63AgX9VV0INw6bjTWuA
	 46vI9wwiOJb1g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9C2F3CE0E98; Fri,  3 Jan 2025 09:10:23 -0800 (PST)
Date: Fri, 3 Jan 2025 09:10:23 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, rcu@vger.kernel.org
Subject: Re: [paulmckrcu:dev.2024.12.24a] [srcu] 9216c28c6a:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <c2561f0c-9bc1-4492-b9dd-655502f101f7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202412311203.ca7bddba-lkp@intel.com>
 <CALm+0cWOxUm_hrNe4UP4Z-vyr4RCOw+dc=kCBTgsyjHFHiHDsg@mail.gmail.com>
 <949f6251-d411-45ef-9f85-d5d069b90b0e@paulmck-laptop>
 <Z3Ym/DDtGOPamGjZ@xsang-OptiPlex-9020>
 <c8c4c6d6-ad52-4cd2-ba1f-c442da4432af@paulmck-laptop>
 <CALm+0cVbaJuMWMkU4g_6inCKiBVaVD3iixvBrfMJTqZ-3OUCvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cVbaJuMWMkU4g_6inCKiBVaVD3iixvBrfMJTqZ-3OUCvg@mail.gmail.com>

On Fri, Jan 03, 2025 at 01:50:50PM +0800, Z qiang wrote:
> >
> > On Thu, Jan 02, 2025 at 01:41:16PM +0800, Oliver Sang wrote:
> > > hi, Zqiang, hi, Paul,
> > >
> > > On Tue, Dec 31, 2024 at 08:19:44AM -0800, Paul E. McKenney wrote:
> > > > On Tue, Dec 31, 2024 at 03:16:25PM +0800, Z qiang wrote:
> > >
> > > [...]
> > >
> > > > > >
> > > > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > > > the same patch/commit), kindly add following tags
> > > > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > > > | Closes: https://lore.kernel.org/oe-lkp/202412311203.ca7bddba-lkp@intel.com
> > > > > >
> > > > >
> > > > > Please try the following modifications:
> > >
> > > yes, the following modifications fix the issues we found for 9216c28c6a. thanks!
> > >
> > > Tested-by: kernel test robot <oliver.sang@intel.com>
> >
> > Thank you, and I will apply this during my next rebase.
> >
> > Zqiang, unless you tell me otherwise, I will add your Co-developed-by
> > and Signed-off-by.
> >
> > Either way, Happy Square New Year!
> 
> Thank you,  Happy New Year!  :)

And here you go!  Please let me know of anything I missed.

And thank you for saving me the time it would have taken to track
this one down.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

commit 71c893e6d1857d1e4ea37aec557d734a560fdb39
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Dec 19 16:08:54 2024 -0800

    srcu: Make SRCU readers use ->srcu_ctrs for counter selection
    
    This commit causes SRCU readers to use ->srcu_ctrs for counter
    selection instead of ->srcu_idx.  This takes another step towards
    array-indexing-free SRCU readers.
    
    [ paulmck: Apply kernel test robot feedback. ]
    
    Co-developed-by: Z qiang <qiang.zhang1211@gmail.com>
    Signed-off-by: Z qiang <qiang.zhang1211@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Tested-by: kernel test robot <oliver.sang@intel.com>

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index c794d599db5c1..1b01ced61a45b 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -101,6 +101,7 @@ struct srcu_usage {
  */
 struct srcu_struct {
 	unsigned int srcu_idx;			/* Current rdr array element. */
+	struct srcu_ctr __percpu *srcu_ctrp;
 	struct srcu_data __percpu *sda;		/* Per-CPU srcu_data array. */
 	struct lockdep_map dep_map;
 	struct srcu_usage *srcu_sup;		/* Update-side data. */
@@ -167,6 +168,7 @@ struct srcu_struct {
 #define __SRCU_STRUCT_INIT(name, usage_name, pcpu_name)						\
 {												\
 	.sda = &pcpu_name,									\
+	.srcu_ctrp = &pcpu_name.srcu_ctrs[0],							\
 	__SRCU_STRUCT_INIT_COMMON(name, usage_name)						\
 }
 
@@ -222,13 +224,12 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
  */
 static inline int __srcu_read_lock_lite(struct srcu_struct *ssp)
 {
-	int idx;
+	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_lite().");
-	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_locks.counter); /* Y */
+	this_cpu_inc(scp->srcu_locks.counter); /* Y */
 	barrier(); /* Avoid leaking the critical section. */
-	return idx;
+	return scp - &ssp->sda->srcu_ctrs[0];
 }
 
 /*
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d7ee2f345e192..3bf7f41ad72b8 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -253,8 +253,10 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
 	INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
 	ssp->srcu_sup->sda_is_static = is_static;
-	if (!is_static)
+	if (!is_static) {
 		ssp->sda = alloc_percpu(struct srcu_data);
+		ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];
+	}
 	if (!ssp->sda)
 		goto err_free_sup;
 	init_srcu_struct_data(ssp);
@@ -742,12 +744,11 @@ EXPORT_SYMBOL_GPL(__srcu_check_read_flavor);
  */
 int __srcu_read_lock(struct srcu_struct *ssp)
 {
-	int idx;
+	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
 
-	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	this_cpu_inc(ssp->sda->srcu_ctrs[idx].srcu_locks.counter);
+	this_cpu_inc(scp->srcu_locks.counter);
 	smp_mb(); /* B */  /* Avoid leaking the critical section. */
-	return idx;
+	return scp - &ssp->sda->srcu_ctrs[0];
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock);
 
@@ -772,13 +773,11 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
  */
 int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
 {
-	int idx;
-	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
+	struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
 
-	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
-	atomic_long_inc(&sdp->srcu_ctrs[idx].srcu_locks);
+	atomic_long_inc(&scp->srcu_locks);
 	smp_mb__after_atomic(); /* B */  /* Avoid leaking the critical section. */
-	return idx;
+	return scp - &ssp->sda->srcu_ctrs[0];
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock_nmisafe);
 
@@ -1152,6 +1151,8 @@ static void srcu_flip(struct srcu_struct *ssp)
 	smp_mb(); /* E */  /* Pairs with B and C. */
 
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1); // Flip the counter.
+	WRITE_ONCE(ssp->srcu_ctrp,
+		   &ssp->sda->srcu_ctrs[!(ssp->srcu_ctrp - &ssp->sda->srcu_ctrs[0])]);
 
 	/*
 	 * Ensure that if the updater misses an __srcu_read_unlock()
@@ -1998,6 +1999,7 @@ static int srcu_module_coming(struct module *mod)
 	for (i = 0; i < mod->num_srcu_structs; i++) {
 		ssp = *(sspp++);
 		ssp->sda = alloc_percpu(struct srcu_data);
+		ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];
 		if (WARN_ON_ONCE(!ssp->sda))
 			return -ENOMEM;
 	}
