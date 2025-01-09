Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F124400;
	Thu,  9 Jan 2025 00:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736383940; cv=none; b=FNbkIjloaVssCsDoNoh6wb+sIuuTrikSpOZhVZbQa5sUZRf9ZRjjzIDamnTPcuxQf0AoHEDwZKgkgFcs5AxiOVnzQimF0zZp2jiFDuD/aKMzavYoSMlk2r4SWILAIy+5Rpl0r/W0IPHZ1ZsTLQUNHLpOOXsuAFvznMZpuYf3dZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736383940; c=relaxed/simple;
	bh=xYMJgqzospJElr/HNEcNQoIzi7g3DfZDcSBbvaqDHk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QU/BrelXUMIGcrvNvh9sSh31KD4JXc67kjpDSrdGP+DBtwlL3dC9COeetyYadrwFuX1trEeZpdGyTsZDFoOr84whHGWJxY2t+g+p58a+T3uyYCEVL1ecwd6Adk3qfWuXMx/G1zem9njOyAYKendXef7cpP0+enS1BxATK+hJiDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqWEGLem; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqWEGLem"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736383938; x=1767919938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xYMJgqzospJElr/HNEcNQoIzi7g3DfZDcSBbvaqDHk8=;
  b=PqWEGLemizUjpiCbn38vt2XK4lWYB4cSSAxc/cwAGyEB0WTWVh9KnLCU
   yQRG+j/0RcvF3iR0pTvRHKhMJJx8UwUStNlHE1K01Z8xT5QvihcIBJXGr
   NjO6LcqEO64XX7O+nBfCZ+3hFFUyEiUKoSHB+K9Ncm8ZGtenkRQCJmSsY
   gKDShI2rGyUUVfkH29tjhp6dmvOqCseue9dCbBxdpwvPo/3xpzO2EkRPb
   NWmpaoD34hbwS7KKZJyZieYrCMPOdfdV7LSJI7rE8hPAUYihFhsjYMTrg
   URcYktUG7lc7TZth6fjbuBpDNu+I4E7rmyyKbhg/2PdAoo8/WXPj0w/au
   Q==;
X-CSE-ConnectionGUID: 2DAZoQKUQ0ymc07FwA4sHw==
X-CSE-MsgGUID: cthxST1xS/O3DPfXQ7UH1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="40311212"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="40311212"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 16:52:18 -0800
X-CSE-ConnectionGUID: 9cpPcIkGTmyEN7YbED7l2w==
X-CSE-MsgGUID: wUEJlf6ATm6Dd+zBPAF0IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="126548450"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Jan 2025 16:52:14 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVgmS-000Grj-22;
	Thu, 09 Jan 2025 00:52:12 +0000
Date: Thu, 9 Jan 2025 08:51:14 +0800
From: kernel test robot <lkp@intel.com>
To: Yongliang Gao <leonylgao@gmail.com>, paulmck@kernel.org,
	frederic@kernel.org, thunder.leizhen@huawei.com
Cc: oe-kbuild-all@lists.linux.dev, frankjpliu@tencent.com,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yongliang Gao <leonylgao@tencent.com>
Subject: Re: [PATCH] rcu/cpu_stall_cputime: fix the hardirq count for x86
 architecture
Message-ID: <202501090842.SfI6QPGS-lkp@intel.com>
References: <20250108065716.2888148-1-leonylgao@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108065716.2888148-1-leonylgao@gmail.com>

Hi Yongliang,

kernel test robot noticed the following build errors:

[auto build test ERROR on paulmck-rcu/dev]
[also build test ERROR on linus/master v6.13-rc6 next-20250108]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yongliang-Gao/rcu-cpu_stall_cputime-fix-the-hardirq-count-for-x86-architecture/20250108-145810
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
patch link:    https://lore.kernel.org/r/20250108065716.2888148-1-leonylgao%40gmail.com
patch subject: [PATCH] rcu/cpu_stall_cputime: fix the hardirq count for x86 architecture
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20250109/202501090842.SfI6QPGS-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250109/202501090842.SfI6QPGS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501090842.SfI6QPGS-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/rcu/tree.c: In function 'rcu_watching_snap_recheck':
>> kernel/rcu/tree.c:960:71: error: implicit declaration of function 'arch_irq_stat_cpu' [-Wimplicit-function-declaration]
     960 |                         rsrp->nr_hardirqs = kstat_cpu_irqs_sum(cpu) + arch_irq_stat_cpu(cpu);
         |                                                                       ^~~~~~~~~~~~~~~~~


vim +/arch_irq_stat_cpu +960 kernel/rcu/tree.c

   824	
   825	/*
   826	 * Returns positive if the specified CPU has passed through a quiescent state
   827	 * by virtue of being in or having passed through an dynticks idle state since
   828	 * the last call to rcu_watching_snap_save() for this same CPU, or by
   829	 * virtue of having been offline.
   830	 *
   831	 * Returns negative if the specified CPU needs a force resched.
   832	 *
   833	 * Returns zero otherwise.
   834	 */
   835	static int rcu_watching_snap_recheck(struct rcu_data *rdp)
   836	{
   837		unsigned long jtsq;
   838		int ret = 0;
   839		struct rcu_node *rnp = rdp->mynode;
   840	
   841		/*
   842		 * If the CPU passed through or entered a dynticks idle phase with
   843		 * no active irq/NMI handlers, then we can safely pretend that the CPU
   844		 * already acknowledged the request to pass through a quiescent
   845		 * state.  Either way, that CPU cannot possibly be in an RCU
   846		 * read-side critical section that started before the beginning
   847		 * of the current RCU grace period.
   848		 */
   849		if (rcu_watching_snap_stopped_since(rdp, rdp->watching_snap)) {
   850			trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
   851			rcu_gpnum_ovf(rnp, rdp);
   852			return 1;
   853		}
   854	
   855		/*
   856		 * Complain if a CPU that is considered to be offline from RCU's
   857		 * perspective has not yet reported a quiescent state.  After all,
   858		 * the offline CPU should have reported a quiescent state during
   859		 * the CPU-offline process, or, failing that, by rcu_gp_init()
   860		 * if it ran concurrently with either the CPU going offline or the
   861		 * last task on a leaf rcu_node structure exiting its RCU read-side
   862		 * critical section while all CPUs corresponding to that structure
   863		 * are offline.  This added warning detects bugs in any of these
   864		 * code paths.
   865		 *
   866		 * The rcu_node structure's ->lock is held here, which excludes
   867		 * the relevant portions the CPU-hotplug code, the grace-period
   868		 * initialization code, and the rcu_read_unlock() code paths.
   869		 *
   870		 * For more detail, please refer to the "Hotplug CPU" section
   871		 * of RCU's Requirements documentation.
   872		 */
   873		if (WARN_ON_ONCE(!rcu_rdp_cpu_online(rdp))) {
   874			struct rcu_node *rnp1;
   875	
   876			pr_info("%s: grp: %d-%d level: %d ->gp_seq %ld ->completedqs %ld\n",
   877				__func__, rnp->grplo, rnp->grphi, rnp->level,
   878				(long)rnp->gp_seq, (long)rnp->completedqs);
   879			for (rnp1 = rnp; rnp1; rnp1 = rnp1->parent)
   880				pr_info("%s: %d:%d ->qsmask %#lx ->qsmaskinit %#lx ->qsmaskinitnext %#lx ->rcu_gp_init_mask %#lx\n",
   881					__func__, rnp1->grplo, rnp1->grphi, rnp1->qsmask, rnp1->qsmaskinit, rnp1->qsmaskinitnext, rnp1->rcu_gp_init_mask);
   882			pr_info("%s %d: %c online: %ld(%d) offline: %ld(%d)\n",
   883				__func__, rdp->cpu, ".o"[rcu_rdp_cpu_online(rdp)],
   884				(long)rdp->rcu_onl_gp_seq, rdp->rcu_onl_gp_state,
   885				(long)rdp->rcu_ofl_gp_seq, rdp->rcu_ofl_gp_state);
   886			return 1; /* Break things loose after complaining. */
   887		}
   888	
   889		/*
   890		 * A CPU running for an extended time within the kernel can
   891		 * delay RCU grace periods: (1) At age jiffies_to_sched_qs,
   892		 * set .rcu_urgent_qs, (2) At age 2*jiffies_to_sched_qs, set
   893		 * both .rcu_need_heavy_qs and .rcu_urgent_qs.  Note that the
   894		 * unsynchronized assignments to the per-CPU rcu_need_heavy_qs
   895		 * variable are safe because the assignments are repeated if this
   896		 * CPU failed to pass through a quiescent state.  This code
   897		 * also checks .jiffies_resched in case jiffies_to_sched_qs
   898		 * is set way high.
   899		 */
   900		jtsq = READ_ONCE(jiffies_to_sched_qs);
   901		if (!READ_ONCE(rdp->rcu_need_heavy_qs) &&
   902		    (time_after(jiffies, rcu_state.gp_start + jtsq * 2) ||
   903		     time_after(jiffies, rcu_state.jiffies_resched) ||
   904		     rcu_state.cbovld)) {
   905			WRITE_ONCE(rdp->rcu_need_heavy_qs, true);
   906			/* Store rcu_need_heavy_qs before rcu_urgent_qs. */
   907			smp_store_release(&rdp->rcu_urgent_qs, true);
   908		} else if (time_after(jiffies, rcu_state.gp_start + jtsq)) {
   909			WRITE_ONCE(rdp->rcu_urgent_qs, true);
   910		}
   911	
   912		/*
   913		 * NO_HZ_FULL CPUs can run in-kernel without rcu_sched_clock_irq!
   914		 * The above code handles this, but only for straight cond_resched().
   915		 * And some in-kernel loops check need_resched() before calling
   916		 * cond_resched(), which defeats the above code for CPUs that are
   917		 * running in-kernel with scheduling-clock interrupts disabled.
   918		 * So hit them over the head with the resched_cpu() hammer!
   919		 */
   920		if (tick_nohz_full_cpu(rdp->cpu) &&
   921		    (time_after(jiffies, READ_ONCE(rdp->last_fqs_resched) + jtsq * 3) ||
   922		     rcu_state.cbovld)) {
   923			WRITE_ONCE(rdp->rcu_urgent_qs, true);
   924			WRITE_ONCE(rdp->last_fqs_resched, jiffies);
   925			ret = -1;
   926		}
   927	
   928		/*
   929		 * If more than halfway to RCU CPU stall-warning time, invoke
   930		 * resched_cpu() more frequently to try to loosen things up a bit.
   931		 * Also check to see if the CPU is getting hammered with interrupts,
   932		 * but only once per grace period, just to keep the IPIs down to
   933		 * a dull roar.
   934		 */
   935		if (time_after(jiffies, rcu_state.jiffies_resched)) {
   936			if (time_after(jiffies,
   937				       READ_ONCE(rdp->last_fqs_resched) + jtsq)) {
   938				WRITE_ONCE(rdp->last_fqs_resched, jiffies);
   939				ret = -1;
   940			}
   941			if (IS_ENABLED(CONFIG_IRQ_WORK) &&
   942			    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
   943			    (rnp->ffmask & rdp->grpmask)) {
   944				rdp->rcu_iw_pending = true;
   945				rdp->rcu_iw_gp_seq = rnp->gp_seq;
   946				irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
   947			}
   948	
   949			if (rcu_cpu_stall_cputime && rdp->snap_record.gp_seq != rdp->gp_seq) {
   950				int cpu = rdp->cpu;
   951				struct rcu_snap_record *rsrp;
   952				struct kernel_cpustat *kcsp;
   953	
   954				kcsp = &kcpustat_cpu(cpu);
   955	
   956				rsrp = &rdp->snap_record;
   957				rsrp->cputime_irq     = kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
   958				rsrp->cputime_softirq = kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu);
   959				rsrp->cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
 > 960				rsrp->nr_hardirqs = kstat_cpu_irqs_sum(cpu) + arch_irq_stat_cpu(cpu);
   961				rsrp->nr_softirqs = kstat_cpu_softirqs_sum(cpu);
   962				rsrp->nr_csw = nr_context_switches_cpu(cpu);
   963				rsrp->jiffies = jiffies;
   964				rsrp->gp_seq = rdp->gp_seq;
   965			}
   966		}
   967	
   968		return ret;
   969	}
   970	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
