Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC4188714;
	Fri, 24 Jan 2025 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737747245; cv=none; b=Sv153sLpAniueKBrLNNpInf9ZR+XgUJ4jILDds3XWgdQWoK+a8jgRLkNkdu2DxBkhSE+uANuTKF3EcS5o2dbiGknbOqncheVzmAqw2uy0msis3XCmdLrF+4x4ON+oN7G1bbWetyLle03JzHTpsZXuZUDArEkYxR7AEMIn7/TKYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737747245; c=relaxed/simple;
	bh=ns7pLeWTk4eF1PCoXqcGeCUXijpXuyFkPjKl2iIgD5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtf7ZikZRn1dp3srHucqFFC8ObAXxfKmoSRsAGI01ODfUxAbOAIP0JGaOrjbR0XU0Xj4OW8zTGym2e5lk8lBhV9gKajILCYuJWWmmFzSMSO3IvZx+MTWX+Sj9748Np72ifme0Qy9/frLzDDP+NW4pZ0rcgCdUIZT6d2CjY464Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU0j/idS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU0j/idS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7D1C4CED2;
	Fri, 24 Jan 2025 19:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737747244;
	bh=ns7pLeWTk4eF1PCoXqcGeCUXijpXuyFkPjKl2iIgD5k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BU0j/idSPCvxV/U/O5onAneBiRLCKMMQGqihNrUwRuAWsBs4HWMD8cow1ym3KqfsF
	 k0tU4qPegXXNl7aZxS50nZYh7zRqOBMXNhC5COoYzSMUHspCgVjmxyPFJ5ISo4c4vD
	 X7Xyhll9n95G+GXSzTHWdWsFEQnKKbISHVynlWyhwxd0ep4s5K2IYp26PY3pyPy1t/
	 VB7feHdO0fOdSN1stT6wjt5EWjPatzjycdmaq3jmpPE3ZFTion1+ns/RJQ3TN/k6Dq
	 V3QeU8jwJ0rKXuT6p6gaJrePt4CJgWVORHi9TkPFcqTfly47GcuvTrDVKmEZG9E7zO
	 H1rnU0P5fj4uw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E74EECE0A32; Fri, 24 Jan 2025 11:34:03 -0800 (PST)
Date: Fri, 24 Jan 2025 11:34:03 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/4] torture: Remove CONFIG_NR_CPUS configuration
Message-ID: <06b6c9f2-c668-4c7d-8555-69a23cc8b4e7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250123185828.460836-1-urezki@gmail.com>
 <20250123185828.460836-2-urezki@gmail.com>
 <6f2969e3-344d-4f2d-a71c-ed999ac35324@paulmck-laptop>
 <Z5N8cmpD-HmTYQQJ@pc636>
 <d410ab83-515a-4454-8420-1ada8cf86efd@paulmck-laptop>
 <Z5PMGlDb489VEZ7S@pc636>
 <c57daf05-1018-40b5-9684-22dfd94cc8d9@paulmck-laptop>
 <Z5PSeEn_ceFuqbnz@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5PSeEn_ceFuqbnz@pc636>

On Fri, Jan 24, 2025 at 06:48:40PM +0100, Uladzislau Rezki wrote:
> On Fri, Jan 24, 2025 at 09:36:07AM -0800, Paul E. McKenney wrote:
> > On Fri, Jan 24, 2025 at 06:21:30PM +0100, Uladzislau Rezki wrote:
> > > On Fri, Jan 24, 2025 at 07:45:23AM -0800, Paul E. McKenney wrote:
> > > > On Fri, Jan 24, 2025 at 12:41:38PM +0100, Uladzislau Rezki wrote:
> > > > > On Thu, Jan 23, 2025 at 12:29:45PM -0800, Paul E. McKenney wrote:
> > > > > > On Thu, Jan 23, 2025 at 07:58:26PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > > > This configuration specifies the maximum number of CPUs which
> > > > > > > is set to 8. The problem is that it can not be overwritten for
> > > > > > > something higher.
> > > > > > > 
> > > > > > > Remove that configuration for TREE05, so it is possible to run
> > > > > > > the torture test on as many CPUs as many system has.
> > > > > > > 
> > > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > 
> > > > > > You should be able to override this on the kvm.sh command line by
> > > > > > specifying "--kconfig CONFIG_NR_CPUS=128" or whatever number you wish.
> > > > > > For example, see the torture.sh querying the system's number of CPUs
> > > > > > and then specifying it to a number of tests.
> > > > > > 
> > > > > > Or am I missing something here?
> > > > > > 
> > > > > It took me a while to understand what happens. Apparently there is this
> > > > > 8 CPUs limitation. Yes, i can do it manually by passing --kconfig but
> > > > > you need to know about that. I have not expected that.
> > > > > 
> > > > > Therefore i removed it from the configuration because i have not found
> > > > > a good explanation why we need. It is confusing instead :)
> > > > 
> > > > Right now, if I do a run with --configs "TREE10 14*CFLIST", this will
> > > > make use of 20 systems with 80 CPUs each.  If you remove that line from
> > > > TREE05, won't each instance of TREE05 consume a full system, for a total
> > > > of 33 systems?  Yes, I could use "--kconfig CONFIG_NR_CPUS=8" on the
> > > > command line, but that would affect all the scenarios, not just TREE05.
> > > > Including (say) TINY01, where I believe that it would cause kvm.sh
> > > > to complain about a Kconfig conflict.
> > > > 
> > > > Hence me not being in favor of this change.  ;-)
> > > > 
> > > > Is there another way to make things work for both situations?
> > > > 
> > > OK, i see. Well. I will just go with --kconfig CONFIG_NR_CPUS=foo if i
> > > need more CPUs for TREE05.
> > > 
> > > I will not resist, we just drop this patch :)
> > 
> > Thank you!
> > 
> > The bug you are chasing happens when a given synchonize_rcu() interacts
> > with RCU readers, correct?
> > 
> Below one:
> 
> <snip>
> /*
>  * RCU torture fake writer kthread.  Repeatedly calls sync, with a random
>  * delay between calls.
>  */
> static int
> rcu_torture_fakewriter(void *arg)
> {
> ...
> <snip>
> 
> > In rcutorture, only the rcu_torture_writer() call to synchronize_rcu()
> > interacts with rcu_torture_reader().  So my guess is that running
> > many small TREE05 guest OSes would reproduce this bug more quickly.
> > So instead of this:
> > 
> > 	--kconfig CONFIG_NR_CPUS=128
> > 
> > Do this:
> > 
> > 	--configs "16*TREE05"
> > 
> > Or maybe even this:
> > 
> > 	--configs "16*TREE05" --kconfig CONFIG_NR_CPUS=4
> Thanks for input.
> 
> > 
> > Thoughts?
> > 
> If you mean below splat:

No, instead the one reported by cheung wall <zzqq0103.hey@gmail.com>.

> <snip>
> [   32.107748] =============================
> [   32.108512] WARNING: suspicious RCU usage
> [   32.109232] 6.12.0-rc4-dirty #66 Not tainted
> [   32.110058] -----------------------------
> [   32.110817] kernel/events/core.c:13962 RCU-list traversed in non-reader section!!
> [   32.111221] kworker/u34:2 (251) used greatest stack depth: 12112 bytes left
> [   32.112125]
> [   32.112125] other info that might help us debug this:
> [   32.112125]
> [   32.112130]
> [   32.112130] rcu_scheduler_active = 2, debug_locks = 1
> [   32.116039] 3 locks held by cpuhp/1/20:
> [   32.116758]  #0: ffffffff93a6a750 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x50/0x220
> [   32.118410]  #1: ffffffff93a6ce00 (cpuhp_state-down){+.+.}-{0:0}, at: cpuhp_thread_fun+0x50/0x220
> [   32.120091]  #2: ffffffff93b7eb68 (pmus_lock){+.+.}-{3:3}, at: perf_event_exit_cpu_context+0x32/0x2d0
> [   32.121723]
> [   32.121723] stack backtrace:
> [   32.122413] CPU: 1 UID: 0 PID: 20 Comm: cpuhp/1 Not tainted 6.12.0-rc4-dirty #66
> [   32.123666] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [   32.125302] Call Trace:
> [   32.125769]  <TASK>
> [   32.126148]  dump_stack_lvl+0x83/0xa0
> [   32.126823]  lockdep_rcu_suspicious+0x113/0x180
> [   32.127652]  perf_event_exit_cpu_context+0x2c4/0x2d0
> [   32.128593]  ? __pfx_perf_event_exit_cpu+0x10/0x10
> [   32.129489]  perf_event_exit_cpu+0x9/0x10
> [   32.130243]  cpuhp_invoke_callback+0x187/0x6e0
> [   32.131065]  ? cpuhp_thread_fun+0x50/0x220
> [   32.131800]  cpuhp_thread_fun+0x185/0x220
> [   32.132560]  ? __pfx_smpboot_thread_fn+0x10/0x10                                                                                                                           [   32.133394]  smpboot_thread_fn+0xd8/0x1d0
> [   32.134050]  kthread+0xd0/0x100
> [   32.134592]  ? __pfx_kthread+0x10/0x10
> [   32.135270]  ret_from_fork+0x2f/0x50
> [   32.135896]  ? __pfx_kthread+0x10/0x10
> [   32.136610]  ret_from_fork_asm+0x1a/0x30
> [   32.137356]  </TASK>
> [   32.140997] smpboot: CPU 1 is now offline
> <snip>
> 
> I reproduced that using:
> 
> +rcutorture.nfakewriters=128
> +rcutorture.gp_sync=1
> +rcupdate.rcu_expedited=0
> +rcupdate.rcu_normal=1
> +rcutree.rcu_normal_wake_from_gp=1
> <snip>
> 
> The test script:
> 
> for (( i=0; i<$LOOPS; i++ )); do
>         tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 64 --configs \
>         '100*TREE05' --memory 20G --bootargs 'rcutorture.fwd_progress=1'
>         echo "Done $i"
> done
> 
> i.e. with more nfakewriters.

Right, and large nfakewriters would help push the synchronize_rcu()
wakeups off of the grace-period kthread.

> If you mean the one that has recently reported, i am not able to
> reproduce it anyhow :)

Using larger numbers of smaller rcutorture guest OSes might help to
reproduce it.  Maybe as small as three CPUs each.  ;-)

							Thanx, Paul
