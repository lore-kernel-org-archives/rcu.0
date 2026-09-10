Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB065221D6;
	Thu, 10 Sep 2026 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059302; cv=none; b=d2TQ2w8aHSAoXt9rdoive35NYj1AUFD1+X50fOVdeQfLYrOMpzwKpoKq3k7fsvSpEERbTI8VcLFB4ltked+dXHxcXLpcyxORTb1OAHaYJez09RS+4KEDufRDjnuy8+0pMkixk/8HEe3qnngW1AJq5p+kWekUJiG1ayr64rULxZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059302; c=relaxed/simple;
	bh=l7i/FO1ItoWOLmKL7zTyq4d9VrtQVV2+6x8TR7qImU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRRbmyECCUegtRdoMG+Xz8vFIxb64KPZquY3tzxHWF7k7zYsKtyhApSkqEYm96FzPEyrmk5u/r/YZvoE0WNNFKTnwWurRaIIKDqfvzOpo/iVHFnLAzM3QZDbqMZYUydNkEpyxabjxkTKj56emnuBpQjKeGyiQMLKHlEYLuRWitQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKHpXbcY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKHpXbcY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30F01F000FF;
	Thu, 10 Sep 2026 16:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789059292;
	bh=ZnntZIkyGVTGxk6jStVbEP5g1lkb1af5stHGst1a5AM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=LKHpXbcYWyvQdn8IXrrAPSVPVdOAiSfGtGiq/Ls/lEU5XAl4+K1rU6PwqE2lpVeNX
	 pi8seuTI0UxlQ2PhTW/JuIBrxlNXAACiSCCHda58LFlt2ZI+bSKHa7e6rXwLf6o7jc
	 o/Q9dhQa0evHklHEMKEPyZm/QHZWqdYKz4DgYUCjZNoPyGEDzbyvGxoCvleX+GeBBc
	 rs3DfWdrOVCM8JPStrmtHvzDJ3E0x44Zfy3CURI1/oij2zoVG4qKvYHV43yWsfzimF
	 BmKAGkeltcGDkz52yJmfBWGS+PsvnzeFRhhl5Kn68S+AxqxG/DXZBp3bTqHQwhitCK
	 eJ4QqgRXe1B6g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 73042CE1580; Thu, 10 Sep 2026 09:54:52 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:54:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Kunwu Chan <kunwu.chan@gmail.com>, jiangshanlai@gmail.com,
	josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcutree: Skip torture to-big transition for atomic SRCU
Message-ID: <c3c8e941-93eb-4f1f-ab2b-abc48f4ce146@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260910041427.3579817-1-kunwu.chan@gmail.com>
 <202609102247.8X7GUWSj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202609102247.8X7GUWSj-lkp@intel.com>

On Thu, Sep 10, 2026 at 10:34:21PM +0800, kernel test robot wrote:
> Hi Kunwu,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on rcu/rcu/dev]
> [also build test ERROR on linus/master v7.3-rc2 next-20260909]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]

Indeed, this patch would need to be applied to the "dev" branch of my
-rcu tree.

							Thanx, Paul

> url:    https://github.com/intel-lab-lkp/linux/commits/Kunwu-Chan/srcutree-Skip-torture-to-big-transition-for-atomic-SRCU/20260910-121427
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
> patch link:    https://lore.kernel.org/r/20260910041427.3579817-1-kunwu.chan%40gmail.com
> patch subject: [PATCH] srcutree: Skip torture to-big transition for atomic SRCU
> config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20260910/202609102247.8X7GUWSj-lkp@intel.com/config)
> compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project d3db069999553568848400c84cbf815c03f5470f)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260910/202609102247.8X7GUWSj-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202609102247.8X7GUWSj-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> kernel/rcu/srcutree.c:2080:61: error: use of undeclared identifier 'SRCU_READ_FLAVOR_ATOMIC'
>     2080 |         if (SRCU_SIZING_IS_TORTURE() && ssp->srcu_reader_flavor != SRCU_READ_FLAVOR_ATOMIC)
>          |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~
>    1 error generated.
> 
> 
> vim +/SRCU_READ_FLAVOR_ATOMIC +2080 kernel/rcu/srcutree.c
> 
>   2031	
>   2032	void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
>   2033	{
>   2034		int cpu;
>   2035		int idx;
>   2036		unsigned long s0 = 0, s1 = 0;
>   2037		int ss_state = READ_ONCE(ssp->srcu_sup->srcu_size_state);
>   2038		int ss_state_idx = ss_state;
>   2039	
>   2040		idx = ssp->srcu_ctrp - &ssp->sda->srcu_ctrs[0];
>   2041		if (ss_state < 0 || ss_state >= ARRAY_SIZE(srcu_size_state_name))
>   2042			ss_state_idx = ARRAY_SIZE(srcu_size_state_name) - 1;
>   2043		pr_alert("%s%s Tree SRCU g%ld state %d (%s)",
>   2044			 tt, tf, rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq), ss_state,
>   2045			 srcu_size_state_name[ss_state_idx]);
>   2046		if (!ssp->sda) {
>   2047			// Called after cleanup_srcu_struct(), perhaps.
>   2048			pr_cont(" No per-CPU srcu_data structures (->sda == NULL).\n");
>   2049		} else {
>   2050			pr_cont(" per-CPU(idx=%d):", idx);
>   2051			for_each_possible_cpu(cpu) {
>   2052				unsigned long l0, l1;
>   2053				unsigned long u0, u1;
>   2054				long c0, c1;
>   2055				struct srcu_data *sdp;
>   2056	
>   2057				sdp = per_cpu_ptr(ssp->sda, cpu);
>   2058				u0 = data_race(atomic_long_read(&sdp->srcu_ctrs[!idx].srcu_unlocks));
>   2059				u1 = data_race(atomic_long_read(&sdp->srcu_ctrs[idx].srcu_unlocks));
>   2060	
>   2061				/*
>   2062				 * Make sure that a lock is always counted if the corresponding
>   2063				 * unlock is counted.
>   2064				 */
>   2065				smp_rmb();
>   2066	
>   2067				l0 = data_race(atomic_long_read(&sdp->srcu_ctrs[!idx].srcu_locks));
>   2068				l1 = data_race(atomic_long_read(&sdp->srcu_ctrs[idx].srcu_locks));
>   2069	
>   2070				c0 = l0 - u0;
>   2071				c1 = l1 - u1;
>   2072				pr_cont(" %d(%ld,%ld %c)",
>   2073					cpu, c0, c1,
>   2074					"C."[rcu_segcblist_empty(&sdp->srcu_cblist)]);
>   2075				s0 += c0;
>   2076				s1 += c1;
>   2077			}
>   2078			pr_cont(" T(%ld,%ld)\n", s0, s1);
>   2079		}
> > 2080		if (SRCU_SIZING_IS_TORTURE() && ssp->srcu_reader_flavor != SRCU_READ_FLAVOR_ATOMIC)
>   2081			srcu_transition_to_big(ssp);
>   2082	}
>   2083	EXPORT_SYMBOL_GPL(srcu_torture_stats_print);
>   2084	
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
