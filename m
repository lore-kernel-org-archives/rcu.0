Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2637757D;
	Thu, 10 Sep 2026 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051278; cv=none; b=szHwF8oPQA5SFKs9bDkm1CdkFuCcNHW6n2zd9CfCX8AK8visflOGtRXBALO9QcmKuo3ZD4LDu8n7jx7i3uTAX6dZZsNAeAdOJxJ0OD3mDRnzvmTa8RMN//bsA2xjuQGfDpGW1hwvFeeu8BDnV4uuQ1rN2paJJR2XzszqFGlY9AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051278; c=relaxed/simple;
	bh=QsXB8Xjq9BYSpWgqNkcjm1X1KWzVRNGHi48MteRdoPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhYIcHxX79LffQ06lKP3Z7BKQtO7m74t2SdKOCVBKa5Bh5bQpW88lS/mrTycEri48eXyhphFcfKXk6fs8owY1Z2TA9XMZuKoP8ldEhsvLXevXs404bsyfa/144f7b7QFmyYn+qVZKfmuWnHZ86y2VBR4+CWLSwrThfHAjOiG2Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2PJuokl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2PJuokl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789051276; x=1820587276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QsXB8Xjq9BYSpWgqNkcjm1X1KWzVRNGHi48MteRdoPg=;
  b=Y2PJuokldVmHehVp9gO6DG9IAbKgQSv6GRlYTL1r/PZXn6cCKFlJ/3fU
   T3C8Nj8XJUpgI9sra4la56BXFxnCKRJttE/EVS8FjGtBzk6Nq7YHBO23z
   KoiMujFMQ159OzE+EGfKTzxHhkXSZrzdCM6VPnGTiEqtJzpIIsW7dwj9x
   pi5GMM1bujI5T/ZoKRub7Qr30eWrA5qGyctXlUTZdbDf8ZVSq1yW8uqhh
   akvEOk6VTJv/q1ial2x9W+3M2orhz7QCeVYbw1lNxE5q1R6KDwYgzYz7K
   E0qesWyrEWrKEfJqayJKdXTJ7mdn84JIFT2UoTSQUVPHvUdNZjPZNOw3l
   A==;
X-CSE-ConnectionGUID: M2I78R3DQ+m9f9qAgxC/yA==
X-CSE-MsgGUID: YeDhKrSeQq6OnXIyWkxuVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89266282"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89266282"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 07:41:16 -0700
X-CSE-ConnectionGUID: v0Cn7zqbQNahi46+Iq5wOg==
X-CSE-MsgGUID: qHPrCUcoTSqQuSsa6LhKUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="301554075"
Received: from lkp-server02.sh.intel.com (HELO 0a3643a6ed9d) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 10 Sep 2026 07:41:14 -0700
Received: from kbuild by 0a3643a6ed9d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x4fxR-0000000007X-3cjP;
	Thu, 10 Sep 2026 14:41:02 +0000
Date: Thu, 10 Sep 2026 22:33:30 +0800
From: kernel test robot <lkp@intel.com>
To: Kunwu Chan <kunwu.chan@gmail.com>, jiangshanlai@gmail.com,
	paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Cc: oe-kbuild-all@lists.linux.dev, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH] srcutree: Skip torture to-big transition for atomic SRCU
Message-ID: <202609102229.DO9S18xW-lkp@intel.com>
References: <20260910041427.3579817-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910041427.3579817-1-kunwu.chan@gmail.com>

Hi Kunwu,

kernel test robot noticed the following build errors:

[auto build test ERROR on rcu/rcu/dev]
[also build test ERROR on linus/master v7.3-rc2 next-20260909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kunwu-Chan/srcutree-Skip-torture-to-big-transition-for-atomic-SRCU/20260910-121427
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
patch link:    https://lore.kernel.org/r/20260910041427.3579817-1-kunwu.chan%40gmail.com
patch subject: [PATCH] srcutree: Skip torture to-big transition for atomic SRCU
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20260910/202609102229.DO9S18xW-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260910/202609102229.DO9S18xW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609102229.DO9S18xW-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/rcu/srcutree.c: In function 'srcu_torture_stats_print':
>> kernel/rcu/srcutree.c:2080:68: error: 'SRCU_READ_FLAVOR_ATOMIC' undeclared (first use in this function); did you mean 'SRCU_READ_FLAVOR_NMI'?
    2080 |         if (SRCU_SIZING_IS_TORTURE() && ssp->srcu_reader_flavor != SRCU_READ_FLAVOR_ATOMIC)
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~
         |                                                                    SRCU_READ_FLAVOR_NMI
   kernel/rcu/srcutree.c:2080:68: note: each undeclared identifier is reported only once for each function it appears in


vim +2080 kernel/rcu/srcutree.c

  2031	
  2032	void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
  2033	{
  2034		int cpu;
  2035		int idx;
  2036		unsigned long s0 = 0, s1 = 0;
  2037		int ss_state = READ_ONCE(ssp->srcu_sup->srcu_size_state);
  2038		int ss_state_idx = ss_state;
  2039	
  2040		idx = ssp->srcu_ctrp - &ssp->sda->srcu_ctrs[0];
  2041		if (ss_state < 0 || ss_state >= ARRAY_SIZE(srcu_size_state_name))
  2042			ss_state_idx = ARRAY_SIZE(srcu_size_state_name) - 1;
  2043		pr_alert("%s%s Tree SRCU g%ld state %d (%s)",
  2044			 tt, tf, rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq), ss_state,
  2045			 srcu_size_state_name[ss_state_idx]);
  2046		if (!ssp->sda) {
  2047			// Called after cleanup_srcu_struct(), perhaps.
  2048			pr_cont(" No per-CPU srcu_data structures (->sda == NULL).\n");
  2049		} else {
  2050			pr_cont(" per-CPU(idx=%d):", idx);
  2051			for_each_possible_cpu(cpu) {
  2052				unsigned long l0, l1;
  2053				unsigned long u0, u1;
  2054				long c0, c1;
  2055				struct srcu_data *sdp;
  2056	
  2057				sdp = per_cpu_ptr(ssp->sda, cpu);
  2058				u0 = data_race(atomic_long_read(&sdp->srcu_ctrs[!idx].srcu_unlocks));
  2059				u1 = data_race(atomic_long_read(&sdp->srcu_ctrs[idx].srcu_unlocks));
  2060	
  2061				/*
  2062				 * Make sure that a lock is always counted if the corresponding
  2063				 * unlock is counted.
  2064				 */
  2065				smp_rmb();
  2066	
  2067				l0 = data_race(atomic_long_read(&sdp->srcu_ctrs[!idx].srcu_locks));
  2068				l1 = data_race(atomic_long_read(&sdp->srcu_ctrs[idx].srcu_locks));
  2069	
  2070				c0 = l0 - u0;
  2071				c1 = l1 - u1;
  2072				pr_cont(" %d(%ld,%ld %c)",
  2073					cpu, c0, c1,
  2074					"C."[rcu_segcblist_empty(&sdp->srcu_cblist)]);
  2075				s0 += c0;
  2076				s1 += c1;
  2077			}
  2078			pr_cont(" T(%ld,%ld)\n", s0, s1);
  2079		}
> 2080		if (SRCU_SIZING_IS_TORTURE() && ssp->srcu_reader_flavor != SRCU_READ_FLAVOR_ATOMIC)
  2081			srcu_transition_to_big(ssp);
  2082	}
  2083	EXPORT_SYMBOL_GPL(srcu_torture_stats_print);
  2084	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
