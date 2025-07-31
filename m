Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF5029DB61;
	Thu, 31 Jul 2025 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948045; cv=none; b=aDmeB8+5BbaG55UI/nnWjvC+j8varaebbjlsckviPKSQaa48lfX50M3UEbEFnGRWR9hxrfaHTKZ9/EyiJOUXmV+TWzOKWeByfKrZauKnjPgUWC65zs0wtf4Ms++jKyzCLVKbitCnooQtOvtTTZb9+LTZiAzGqjXzzljmTAe5Tcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948045; c=relaxed/simple;
	bh=N4lFgM6enMi7egPgtoDq0LPj8fBAykO6vUSoTiVz3W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlNsSJhD1NsrReM9ZrhECVHCukMuUZZSMgafp9Bs8q890iT4ScJkI+P8M5oHlalVUgRMpiuT1HY0nBLuP25cID1k3ji/puhVt+F+2cQe1ZB2uD8b8p0YuHlFkxn1cKEj0QHcQ6UeMD7XRtW4T7ETUIwKaUf92bdz64D0qHNNvQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZILjyc2Y; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZILjyc2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753948044; x=1785484044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N4lFgM6enMi7egPgtoDq0LPj8fBAykO6vUSoTiVz3W4=;
  b=ZILjyc2YYBuSbZCoWY6rO3msYXWxYE6j+PJtUhWznkjgpm8k8pQNRQzv
   68T0czB9A5zd6lk7+yqP24A2iWQg7t0adqNRUOCNtk43S/buqLN8uGhId
   oweatK/pg//lu88AXF5osXGobna0olDrNXNhbu9cWn8A4rS7e/kbArVc9
   fxxTud5l5+d6rHr8QQC3ahOp1Owf0nVnp7I1lYplA1FyKlRpRy36kToET
   bqB3GWh9cdlUOznn3PcrtFUT+6Xy4syBvezimBv3Zb5c98Xvkpt0DFs5a
   pic+v1+/jJowL7ooRfif3NPFo2zQsSldSmqoMIpFZPnFbLaJ3XmLyqobQ
   A==;
X-CSE-ConnectionGUID: Ti3NgXgtRNiijX8T0h+Hjg==
X-CSE-MsgGUID: uI30O8GfSY2dfiIhZJqwIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="55467154"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="55467154"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 00:47:22 -0700
X-CSE-ConnectionGUID: W6avIq26TRSoDeateIy+rA==
X-CSE-MsgGUID: f7kTM5qYQVqW8c2vUKVuPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="163986194"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 31 Jul 2025 00:47:15 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhO0P-0003WW-1j;
	Thu, 31 Jul 2025 07:47:13 +0000
Date: Thu, 31 Jul 2025 15:47:03 +0800
From: kernel test robot <lkp@intel.com>
To: Yuzhuo Jing <yuzhuo@google.com>, Ian Rogers <irogers@google.com>,
	Yuzhuo Jing <yzj@umich.edu>, Jonathan Corbet <corbet@lwn.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Frank van der Linden <fvdl@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v1 1/4] rcuscale: Create debugfs file for writer durations
Message-ID: <202507311504.ttQGhW04-lkp@intel.com>
References: <20250730022347.71722-2-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730022347.71722-2-yuzhuo@google.com>

Hi Yuzhuo,

kernel test robot noticed the following build errors:

[auto build test ERROR on rcu/rcu/dev]
[also build test ERROR on linus/master v6.16 next-20250731]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuzhuo-Jing/rcuscale-Create-debugfs-file-for-writer-durations/20250730-102613
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
patch link:    https://lore.kernel.org/r/20250730022347.71722-2-yuzhuo%40google.com
patch subject: [PATCH v1 1/4] rcuscale: Create debugfs file for writer durations
config: i386-randconfig-002-20250731 (https://download.01.org/0day-ci/archive/20250731/202507311504.ttQGhW04-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250731/202507311504.ttQGhW04-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507311504.ttQGhW04-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   kernel/rcu/rcuscale.c: In function 'rcu_scale_writer':
>> kernel/rcu/rcuscale.c:630:44: error: 'test_complete' undeclared (first use in this function); did you mean 'complete'?
     630 |                                 WRITE_ONCE(test_complete, true);
         |                                            ^~~~~~~~~~~~~
   include/linux/compiler_types.h:548:23: note: in definition of macro '__compiletime_assert'
     548 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:568:9: note: in expansion of macro '_compiletime_assert'
     568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/rcu/rcuscale.c:630:33: note: in expansion of macro 'WRITE_ONCE'
     630 |                                 WRITE_ONCE(test_complete, true);
         |                                 ^~~~~~~~~~
   kernel/rcu/rcuscale.c:630:44: note: each undeclared identifier is reported only once for each function it appears in
     630 |                                 WRITE_ONCE(test_complete, true);
         |                                            ^~~~~~~~~~~~~
   include/linux/compiler_types.h:548:23: note: in definition of macro '__compiletime_assert'
     548 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:568:9: note: in expansion of macro '_compiletime_assert'
     568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/rcu/rcuscale.c:630:33: note: in expansion of macro 'WRITE_ONCE'
     630 |                                 WRITE_ONCE(test_complete, true);
         |                                 ^~~~~~~~~~
   kernel/rcu/rcuscale.c: In function 'writer_durations_start':
   kernel/rcu/rcuscale.c:959:14: error: 'test_complete' undeclared (first use in this function); did you mean 'complete'?
     959 |         if (!test_complete || writer_id < 0 || writer_id >= nrealwriters)
         |              ^~~~~~~~~~~~~
         |              complete


vim +630 kernel/rcu/rcuscale.c

   534	
   535	/*
   536	 * RCU scale writer kthread.  Repeatedly does a grace period.
   537	 */
   538	static int
   539	rcu_scale_writer(void *arg)
   540	{
   541		int i = 0;
   542		int i_max;
   543		unsigned long jdone;
   544		long me = (long)arg;
   545		bool selfreport = false;
   546		bool started = false, done = false, alldone = false;
   547		u64 t;
   548		DEFINE_TORTURE_RANDOM(tr);
   549		u64 *wdp;
   550		u64 *wdpp = writer_durations[me];
   551		struct writer_freelist *wflp = &writer_freelists[me];
   552		struct writer_mblock *wmbp = NULL;
   553	
   554		VERBOSE_SCALEOUT_STRING("rcu_scale_writer task started");
   555		WARN_ON(!wdpp);
   556		set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
   557		current->flags |= PF_NO_SETAFFINITY;
   558		sched_set_fifo_low(current);
   559	
   560		if (holdoff)
   561			schedule_timeout_idle(holdoff * HZ);
   562	
   563		/*
   564		 * Wait until rcu_end_inkernel_boot() is called for normal GP tests
   565		 * so that RCU is not always expedited for normal GP tests.
   566		 * The system_state test is approximate, but works well in practice.
   567		 */
   568		while (!gp_exp && system_state != SYSTEM_RUNNING)
   569			schedule_timeout_uninterruptible(1);
   570	
   571		t = ktime_get_mono_fast_ns();
   572		if (atomic_inc_return(&n_rcu_scale_writer_started) >= nrealwriters) {
   573			t_rcu_scale_writer_started = t;
   574			if (gp_exp) {
   575				b_rcu_gp_test_started =
   576					cur_ops->exp_completed() / 2;
   577			} else {
   578				b_rcu_gp_test_started = cur_ops->get_gp_seq();
   579			}
   580		}
   581	
   582		jdone = jiffies + minruntime * HZ;
   583		do {
   584			bool gp_succeeded = false;
   585	
   586			if (writer_holdoff)
   587				udelay(writer_holdoff);
   588			if (writer_holdoff_jiffies)
   589				schedule_timeout_idle(torture_random(&tr) % writer_holdoff_jiffies + 1);
   590			wdp = &wdpp[i];
   591			*wdp = ktime_get_mono_fast_ns();
   592			if (gp_async && !WARN_ON_ONCE(!cur_ops->async)) {
   593				if (!wmbp)
   594					wmbp = rcu_scale_alloc(me);
   595				if (wmbp && atomic_read(&wflp->ws_inflight) < gp_async_max) {
   596					atomic_inc(&wflp->ws_inflight);
   597					cur_ops->async(&wmbp->wmb_rh, rcu_scale_async_cb);
   598					wmbp = NULL;
   599					gp_succeeded = true;
   600				} else if (!kthread_should_stop()) {
   601					cur_ops->gp_barrier();
   602				} else {
   603					rcu_scale_free(wmbp); /* Because we are stopping. */
   604					wmbp = NULL;
   605				}
   606			} else if (gp_exp) {
   607				cur_ops->exp_sync();
   608				gp_succeeded = true;
   609			} else {
   610				cur_ops->sync();
   611				gp_succeeded = true;
   612			}
   613			t = ktime_get_mono_fast_ns();
   614			*wdp = t - *wdp;
   615			i_max = i;
   616			writer_n_durations[me] = i_max + 1;
   617			if (!started &&
   618			    atomic_read(&n_rcu_scale_writer_started) >= nrealwriters)
   619				started = true;
   620			if (!done && i >= MIN_MEAS && time_after(jiffies, jdone)) {
   621				done = true;
   622				WRITE_ONCE(writer_done[me], true);
   623				sched_set_normal(current, 0);
   624				pr_alert("%s%s rcu_scale_writer %ld has %d measurements\n",
   625					 scale_type, SCALE_FLAG, me, MIN_MEAS);
   626				if (atomic_inc_return(&n_rcu_scale_writer_finished) >=
   627				    nrealwriters) {
   628					schedule_timeout_interruptible(10);
   629					rcu_ftrace_dump(DUMP_ALL);
 > 630					WRITE_ONCE(test_complete, true);
   631					SCALEOUT_STRING("Test complete");
   632					t_rcu_scale_writer_finished = t;
   633					if (gp_exp) {
   634						b_rcu_gp_test_finished =
   635							cur_ops->exp_completed() / 2;
   636					} else {
   637						b_rcu_gp_test_finished =
   638							cur_ops->get_gp_seq();
   639					}
   640					if (shutdown) {
   641						smp_mb(); /* Assign before wake. */
   642						wake_up(&shutdown_wq);
   643					}
   644				}
   645			}
   646			if (done && !alldone &&
   647			    atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters)
   648				alldone = true;
   649			if (done && !alldone && time_after(jiffies, jdone + HZ * 60)) {
   650				static atomic_t dumped;
   651				int i;
   652	
   653				if (!atomic_xchg(&dumped, 1)) {
   654					for (i = 0; i < nrealwriters; i++) {
   655						if (writer_done[i])
   656							continue;
   657						pr_info("%s: Task %ld flags writer %d:\n", __func__, me, i);
   658						sched_show_task(writer_tasks[i]);
   659					}
   660					if (cur_ops->stats)
   661						cur_ops->stats();
   662				}
   663			}
   664			if (!selfreport && time_after(jiffies, jdone + HZ * (70 + me))) {
   665				pr_info("%s: Writer %ld self-report: started %d done %d/%d->%d i %d jdone %lu.\n",
   666					__func__, me, started, done, writer_done[me], atomic_read(&n_rcu_scale_writer_finished), i, jiffies - jdone);
   667				selfreport = true;
   668			}
   669			if (gp_succeeded && started && !alldone && i < MAX_MEAS - 1)
   670				i++;
   671			rcu_scale_wait_shutdown();
   672		} while (!torture_must_stop());
   673		if (gp_async && cur_ops->async) {
   674			rcu_scale_free(wmbp);
   675			cur_ops->gp_barrier();
   676		}
   677		torture_kthread_stopping("rcu_scale_writer");
   678		return 0;
   679	}
   680	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
