Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B794139579;
	Wed, 25 Sep 2024 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254668; cv=none; b=sDvC7ulaeYe4Z+1yQ8cmNW8HRCKIUBfgxHhZNw/OsazWDM89itl2UXheXxyKnOIvWqMgmCMFMmobYSR4S23VxHEVSTwvKMYKk4XIMX7svy3pYNooEDNKCH3U87aPBHEYCmH8UVWVtjw+ml5QV+r78DenZTWAJ1k5MQT3CglSOUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254668; c=relaxed/simple;
	bh=TjqXMgitC9Pb+7QWCcSVpW7ReibhPwGxQoiUmqKDXp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DU9hrOvZb5Y5N0cyGh5sdJsdyRV/9cWtCMzAU3+0j/hty4/tTnJPayWR9rgLEPOU1y+F2m760c/5+uy1+kczK2gg3I32ErGszB2EexLpZZXyp5EUddyyU537m/Ng2zJKiYJYhSfNI4RQ7CBMnUz8FpURThEffUvZGdLFa51CGoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHPJJiQ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHPJJiQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58007C4CEC3;
	Wed, 25 Sep 2024 08:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727254667;
	bh=TjqXMgitC9Pb+7QWCcSVpW7ReibhPwGxQoiUmqKDXp0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WHPJJiQ5ZmjK3RzTJ4zqVnbu7vvi1fu1Bfq9YGMsmYyH61cTAijqblvGKEiebqyRv
	 EjdtOyfeCuUbXKzdb+ndFNo0+Ki8J5ghoxG+n0UkL9kgk6Mb4L8uH7XhY3ZT5q0/fi
	 EtifeyNsBw58Pf8AEcrwyRdgBhy1xOequxKlJd1IU6Z2iawADXlO3FVsG0yqdIySHI
	 yc8sxtorckIanzXvRgjwoqtbA8zE5j2RVpQLMSX3YkLd2zccm1fF4caXCbwywvYZVg
	 ijYmuEF0YIlkB1Z78KwQSl0nTaMX3jip55VY9SD7Iulk8kPF97yn/yJDa3fU6dVArP
	 DW7qmvZPGAzfw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2FCCECE0E55; Wed, 25 Sep 2024 01:57:45 -0700 (PDT)
Date: Wed, 25 Sep 2024 01:57:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, rcu@vger.kernel.org
Subject: Re: [paulmckrcu:dev] [srcu]  26cb612c43:
 BUG:using__this_cpu_read()in_preemptible
Message-ID: <ff495e02-dcd4-4310-8806-58fad0dad794@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202409231124.358fed11-lkp@intel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202409231124.358fed11-lkp@intel.com>

On Mon, Sep 23, 2024 at 12:38:31PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:using__this_cpu_read()in_preemptible" on:
> 
> commit: 26cb612c431de5093ae6a3a67ecaa0363f5b8829 ("srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()")
> https://github.com/paulmckrcu/linux dev
> 
> in testcase: rcutorture
> version: 
> with following parameters:
> 
> 	runtime: 300s
> 	test: cpuhotplug
> 	torture_type: srcud
> 
> 
> 
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> in our tests, this issue doesn't always happen, but with a not small rate.
> 
> daf812f27d6bbe4c 26cb612c431de5093ae6a3a67ec
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :50          66%          33:50    dmesg.BUG:using__this_cpu_read()in_preemptible
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202409231124.358fed11-lkp@intel.com
> 
> 
> [  169.560380][   T76] BUG: using __this_cpu_read() in preemptible [00000000] code: kworker/1:2/76
> [ 169.561229][ T76] caller is try_check_zero (kernel/rcu/srcutree.c:485 kernel/rcu/srcutree.c:1149) 

Does this diff fix things for you?  Here the per-CPU access is a
heuristic that reduces overhead once the bulk of the CPUs have done
srcu_read_lock_lite().  So it is OK to get migrated just after the check.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index f3db4d42e70ab..07147efcb64d3 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -482,7 +482,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
  */
 static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
 {
-	bool did_gp = !!(__this_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE);
+	bool did_gp = !!(raw_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE);
 	unsigned long unlocks;
 
 	unlocks = srcu_readers_unlock_idx(ssp, idx);

------------------------------------------------------------------------

> [  169.561657][   T76] CPU: 0 UID: 0 PID: 76 Comm: kworker/1:2 Not tainted 6.11.0-rc1-00125-g26cb612c431d #1
> [  169.562369][   T76] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  169.563120][   T76] Workqueue: rcu_gp process_srcu
> [  169.563518][   T76] Call Trace:
> [  169.563789][   T76]  <TASK>
> [ 169.564031][ T76] dump_stack_lvl (lib/dump_stack.c:122) 
> [ 169.564418][ T76] check_preemption_disabled (lib/smp_processor_id.c:52) 
> [ 169.564842][ T76] ? try_check_zero (kernel/rcu/srcutree.c:485 kernel/rcu/srcutree.c:1149) 
> [ 169.565219][ T76] ? process_one_work (kernel/workqueue.c:3206) 
> [ 169.565592][ T76] ? srcu_advance_state (kernel/rcu/srcutree.c:1784) 
> [ 169.565994][ T76] ? process_srcu (kernel/rcu/srcutree.c:1893) 
> [ 169.566373][ T76] ? process_one_work (kernel/workqueue.c:3236) 
> [ 169.566790][ T76] ? __pfx_process_one_work (kernel/workqueue.c:3133) 
> [ 169.567199][ T76] ? __list_add (include/linux/list.h:83 include/linux/list.h:150) 
> [ 169.567559][ T76] ? process_scheduled_works (kernel/workqueue.c:3312) 
> [ 169.567990][ T76] ? worker_thread (include/linux/list.h:373 kernel/workqueue.c:948 kernel/workqueue.c:3391) 
> [ 169.568361][ T76] ? __kthread_parkme (arch/x86/include/asm/current.h:49 kernel/kthread.c:293) 
> [ 169.568761][ T76] ? __pfx_worker_thread (kernel/workqueue.c:3339) 
> [ 169.569156][ T76] ? kthread (kernel/kthread.c:389) 
> [ 169.569474][ T76] ? __pfx_kthread (kernel/kthread.c:342) 
> [ 169.569848][ T76] ? ret_from_fork (arch/x86/kernel/process.c:153) 
> [ 169.570212][ T76] ? __pfx_kthread (kernel/kthread.c:342) 
> [ 169.570563][ T76] ? ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
> [  169.570954][   T76]  </TASK>
> [  169.652036][   T76] BUG: using __this_cpu_read() in preemptible [00000000] code: kworker/1:2/76
> [ 169.652785][ T76] caller is try_check_zero (kernel/rcu/srcutree.c:485 kernel/rcu/srcutree.c:1149) 
> [  169.653204][   T76] CPU: 0 UID: 0 PID: 76 Comm: kworker/1:2 Not tainted 6.11.0-rc1-00125-g26cb612c431d #1
> [  169.653945][   T76] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  169.654710][   T76] Workqueue: rcu_gp process_srcu
> [  169.655095][   T76] Call Trace:
> [  169.655357][   T76]  <TASK>
> [ 169.655591][ T76] dump_stack_lvl (lib/dump_stack.c:122) 
> [ 169.655958][ T76] check_preemption_disabled (lib/smp_processor_id.c:52) 
> [ 169.656392][ T76] ? try_check_zero (kernel/rcu/srcutree.c:485 kernel/rcu/srcutree.c:1149) 
> [ 169.656771][ T76] ? process_one_work (kernel/workqueue.c:3206) 
> [ 169.657162][ T76] ? srcu_advance_state (kernel/rcu/srcutree.c:1765) 
> [ 169.657559][ T76] ? process_srcu (kernel/rcu/srcutree.c:1893) 
> [ 169.657909][ T76] ? process_one_work (kernel/workqueue.c:3236) 
> [ 169.658263][ T76] ? __pfx_process_one_work (kernel/workqueue.c:3133) 
> [ 169.658623][ T76] ? __list_add (include/linux/list.h:83 include/linux/list.h:150) 
> [ 169.658911][ T76] ? process_scheduled_works (kernel/workqueue.c:3312) 
> [ 169.659254][ T76] ? worker_thread (include/linux/list.h:373 kernel/workqueue.c:948 kernel/workqueue.c:3391) 
> [ 169.659554][ T76] ? __kthread_parkme (arch/x86/include/asm/current.h:49 kernel/kthread.c:293) 
> [ 169.659885][ T76] ? __pfx_worker_thread (kernel/workqueue.c:3339) 
> [ 169.660211][ T76] ? kthread (kernel/kthread.c:389) 
> [ 169.660480][ T76] ? __pfx_kthread (kernel/kthread.c:342) 
> [ 169.660773][ T76] ? ret_from_fork (arch/x86/kernel/process.c:153) 
> [ 169.661069][ T76] ? __pfx_kthread (kernel/kthread.c:342) 
> [ 169.661363][ T76] ? ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
> [  169.661693][   T76]  </TASK>
> [  169.662140][   T76] BUG: using __this_cpu_read() in preemptible [00000000] code: kworker/1:2/76
> [ 169.662810][ T76] caller is try_check_zero (kernel/rcu/srcutree.c:485 kernel/rcu/srcutree.c:1149) 
> [  169.663222][   T76] CPU: 0 UID: 0 PID: 76 Comm: kworker/1:2 Not tainted 6.11.0-rc1-00125-g26cb612c431d #1
> [  169.663934][   T76] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  169.664696][   T76] Workqueue: rcu_gp process_srcu
> [  169.665091][   T76] Call Trace:
> [  169.665353][   T76]  <TASK>
> [ 169.665586][ T76] dump_stack_lvl (lib/dump_stack.c:122) 
> [ 169.665959][ T76] check_preemption_disabled (lib/smp_processor_id.c:52) 
> [ 169.666369][ T76] ? try_check_zero (kernel/rcu/srcutree.c:485 kernel/rcu/srcutree.c:1149) 
> [ 169.666727][ T76] ? preempt_count_sub (kernel/sched/core.c:5685) 
> [ 169.667127][ T76] ? process_one_work (kernel/workqueue.c:3206) 
> [ 169.667519][ T76] ? srcu_advance_state (kernel/rcu/srcutree.c:1784) 
> [ 169.667938][ T76] ? process_srcu (kernel/rcu/srcutree.c:1893) 
> [ 169.668310][ T76] ? process_one_work (kernel/workqueue.c:3236) 
> [ 169.668719][ T76] ? __pfx_process_one_work (kernel/workqueue.c:3133) 
> [ 169.669150][ T76] ? __list_add (include/linux/list.h:83 include/linux/list.h:150) 
> [ 169.669517][ T76] ? process_scheduled_works (kernel/workqueue.c:3312) 
> [ 169.669954][ T76] ? worker_thread (include/linux/list.h:373 kernel/workqueue.c:948 kernel/workqueue.c:3391) 
> [ 169.670303][ T76] ? __kthread_parkme (arch/x86/include/asm/current.h:49 kernel/kthread.c:293) 
> [ 169.670692][ T76] ? __pfx_worker_thread (kernel/workqueue.c:3339) 
> [ 169.671077][ T76] ? kthread (kernel/kthread.c:389) 
> [ 169.671412][ T76] ? __pfx_kthread (kernel/kthread.c:342) 
> [ 169.671761][ T76] ? ret_from_fork (arch/x86/kernel/process.c:153) 
> [ 169.672114][ T76] ? __pfx_kthread (kernel/kthread.c:342) 
> [ 169.672463][ T76] ? ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
> [  169.672861][   T76]  </TASK>
> [  169.690595][   T75] smpboot: CPU 1 is now offline
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240923/202409231124.358fed11-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
