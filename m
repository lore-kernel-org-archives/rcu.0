Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04565C433EF
	for <rcu@archiver.kernel.org>; Tue,  5 Jul 2022 17:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiGERDH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jul 2022 13:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGERDF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jul 2022 13:03:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9096B1C915
        for <rcu@vger.kernel.org>; Tue,  5 Jul 2022 10:03:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B9F9B8182D
        for <rcu@vger.kernel.org>; Tue,  5 Jul 2022 17:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E246FC341C7;
        Tue,  5 Jul 2022 17:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657040580;
        bh=rwqlfG4e495cCp1xkU6j3p/ULJonyILD09zLTa4n1yA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=X2le1vCN+j5TdjJIRZryvU/rnk9JnEn6hNSE0fPvZFMqnvNVLNRiUCpM8RA9z9xKR
         NQQhFCX67nSpPDJ3dsIgExbrHv3stR546kqgxt06HNufwjrdBkjAEpReeoJx6OZPRL
         g0ymDW8QSZKhTM3sc3Ub86Mm+5oYkan4lHn6RaIgcPIQETWGCoSux31u48ELjvtbeA
         YEdNnnpcE/ct1owBKYOK/wtXsWUTHRTylyosAFCX8aPKKP7WehmTje8h+8HNKKEzJ1
         rxAvjsz7xqR/ghrt7doEUX7vKP6iE/8eQE7MglJLCsnDkwM6XCpZiamOolRM/E1+Hg
         Ci8uMJ29TGQBw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7A4005C05ED; Tue,  5 Jul 2022 10:02:58 -0700 (PDT)
Date:   Tue, 5 Jul 2022 10:02:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     yueluck <yueluck@163.com>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: Re: RE: Re:RE: Re:Re: question about rcu and many hung processes
 lead to reboot
Message-ID: <20220705170258.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <f1de832.1e37.1816593718c.Coremail.yueluck@163.com>
 <20220615050755.GF1790663@paulmck-ThinkPad-P17-Gen-1>
 <6f9fa802.41a5.1816718d276.Coremail.yueluck@163.com>
 <PH0PR11MB5880184DCC0F0EC6798AC5AEDAAD9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB5880370046830F85F3E8DF95DAAD9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <342ba374.42bd.181719c68f5.Coremail.yueluck@163.com>
 <PH0PR11MB5880D00D5BF2D2C40A2734BBDAAF9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <5f8e371e.3e3b.181900adafc.Coremail.yueluck@163.com>
 <20220624034515.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <940513c.4219.181ce54378c.Coremail.yueluck@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <940513c.4219.181ce54378c.Coremail.yueluck@163.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 05, 2022 at 08:27:14PM +0800, yueluck wrote:
> ----------
> + * Awaken the grace-period kthread. Don't do a self-awaken (unless in
> + * an interrupt or softirq handler), and don't bother awakening when there
> + * is nothing for the grace-period kthread to do (as in several CPUs raced
> + * to awaken, and we lost), and finally don't try to awaken a kthread that
> + * has not yet been created. If all those checks are passed, track some
> + * debug information and awaken.
> + *
> + * So why do the self-wakeup when in an interrupt or softirq handler
> + * in the grace-period kthread's context? Because the kthread might have
> + * been interrupted just as it was going to sleep, and just after the final
> + * pre-sleep check of the awaken condition. In this case, a wakeup really
> + * is required, and is therefore supplied
> --------------
> Hi, sorry to trouble you again.
> how could I understand this patch?

If you are worried about a specific patch, please identify it with its
SHA-1 and title.  Like this, for a randomly chosen patch:

77de092c78f5 ("rcu: Decrease FQS scan wait time in case of callback overloading")

For the moment, I am assuming that you have questions about the above
comment and the rcu_gp_kthread_wake() function that it goes with.

Please note that I am looking at current -rcu.  Some details will
differ in older kernels.

> 1. synchronize_rcu registers wakeme_after_rcu 100%, at where  callback
> may  lost?

The synchronize_rcu() -often- queues the wakeme_after_rcu() callback
function, but not always.  In some situations it does nothing, for
example, during early boot and in kernels where preemption is disabled
and in which there is only one online CPU.  In other situations, it
ends up being a wrapper around synchronize_rcu_expedited().

But when synchronize_rcu() does enqueue the wakeme_after_rcu() callback
function, that callback should not be lost.  Or, to put it another way,
if that callback was lost, that would be a bug either in RCU itself or in
the use of RCU.  On example bug in use of RCU that can cause callbacks
to be lost is invoking call_rcu() twice with the same data structure,
without waiting for the first callback to be invoked.

However, that callback -can- be delayed indefinitely, for example, if
there is an infinite loop in an RCU read-side critical section.  This
situation should result in an RCU CPU stall warning, which should in
turn help you locate the buggy RCU read-side critical section.

> 2. there is only one gp_kthread(rcu_gp_kthread) thread , which can
> be waken up at seveval places. if gp_kthread does not work , should not
> the system crash immediately?  actually ths system continues running.

Yes, there is only one rcu_gp_kthread() kthreads, at least in recent
kernels.  In 3.x and early 4.x kernels, there can be up to three
rcu_gp_kthread() kthreads, one for call_rcu(), one for call_rcu_sched(),
and one for call_rcu_bh().  In non-preemptible kernels, there are
only two, because call_rcu() and call_rcu_sched() share the same
rcu_gp_kthread() kthread in that configuration.

But in late 4.x kernels and all 5.x kernels, there is only the one
rcu_gp_kthread() kthread.

> 3. 'pre-sleep check' is where?

The "if (!READ_ONCE(rcu_state.gp_flags)) {" in rcu_gp_init().  There are
similar checks in rcu_gp_fqs_loop(), but these involve timeouts and are
thus less critical in the common case.

							Thanx, Paul

> Thanks all of you.
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> At 2022-06-24 11:45:15, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >On Thu, Jun 23, 2022 at 06:10:39PM +0800, yueluck wrote:
> >> 
> >> 
> >> 
> >> 1. check “rcu_preempt” kthreads state(R or I ?), though “cat /proc/(rcu_preempt kthread pid)/status”
> >> 
> >> 
> >>     It seems preempt kthread is always in "I" state,  but as long as there is hung process, preempt thread has no context switch (voluntary_ctxt_switches and nonvoluntary_ctxt_switches do not change),  is it dead?  if so  kernel would crash.
> >> 
> >> 
> >>     I have screen-snapshot attached.  
> >>     
> >> 2. I have not seen any RCU Stall warning messages. 
> >> 
> >> 
> >> 3. I have been testing patched kernel for 3 days, so far so good.
> >
> >If I understand correctly, this is very encouranging!  I expect that
> >Neeraj would be happy to add your Tested-by.
> >
> >And somewhere I recall expressing doubts about the large numbers of spins.
> >But further thought led me to recall that it was not all that long ago
> >that expedited SRCU grace periods did nothing but spin.  So this might
> >be OK despite my initial misgivings.
> >
> >Neeraj, your choice!
> >
> >							Thanx, Paul
> >
> >> thanks
> >> 
> >> 
> >> 
> >> 
> >> 
> >> 
> >> 
> >> 
> >> 
> >> 
> >> At 2022-06-18 00:44:40, "Zhang, Qiang1" <qiang1.zhang@intel.com> wrote:
> >> 
> >> >Hi, i saw  some source codes, but for rcu i am still a layman.
> >> 
> >> > 
> >> 
> >> >1. we are gonna get core dump.  In my test environment, i can grep "D" processes with the same callstack, but those processes can recover after a while(1-2 seconds).
> >> 
> >>   synchronize_rcu->__wait_rcu_gp->wait_for_completion->schedule_timeout, at this  point , process goes to sleep.
> >> 
> >>   could you explain:
> >> 
> >>    1) how/where is  this process waken up normally.
> >> 
> >>    2) how to know GP is end. 
> >> 
> >>    3) what is your ideals to solve so touch issue, i will follow your instruction.
> >> 
> >>  
> >> 
> >> First, I find the 4.18 kernel is not support output “rcu_preempt” kthreads info though ‘echo y > /proc/sysrq-trigger’.
> >> 
> >> So when hang appear, you can check “rcu_preempt” kthreads state(R or I ?), though “cat /proc/(rcu_preempt kthread pid)/status”
> >> 
> >> and “cat /proc/(rcu_preempt kthread pid)/stack”, you also can “echo t > /proc/sysrq-trigger”.
> >> 
> >>  
> >> 
> >> You need use crash tools load coredump to check it, and enable rcu trace event,
> >> 
> >> “cd /sys/kernel/debug/tracing/events/rcu” to enable trace.
> >> 
> >>  
> >> 
> >> Please try this patch first to test:
> >> 
> >>  
> >> 
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1d1f898df6586c5ea9aeaf349f13089c6fa37903
> >> 
> >>  
> >> 
> >> >2. It is PREEMPTION kernel .   grub boot params  have rcu-related configuration.
> >> 
> >>   crashkernel=auto iommu=pt nmi_watchdog=panic,1 softlockup_panic=1 intel_iommu=on user_namespace.enable=1 hugepagesz=2M hugepages=0 default_hugepagesz=2M irqaffinity=0,36 rcu_nocbs=1-35,37-71 kthread_cpus=0,36 nopti nospectre_v2
> >> 
> >>  
> >> 
> >> >3. "rcu_cpu_stall_suppress=0    rcu_cpu_stall_timeout=60    rcu_task_stall_timeout=600000" are fetched via 'cat /sys/module/rcupdate/parameters/rcu_*'
> >> 
> >>  
> >> 
> >> Did you find RCU Stall warning messages?
> >> 
> >>  
> >> 
> >> Thanks
> >> 
> >> Zqiang
> >> 
> >>  
> >> 
> >> > 
> >> 
> >> > 
> >> 
> >> >Thanks for all your help.
> >> 
> >>  
> >> 
> >>  
> >> 
> >>  
> >> 
> >>  
> >> 
> >>  
> >> 
> >>  
> >> 
> >>  
> >> 
> >>  
> >> 
> >> At 2022-06-15 21:31:59, "Zhang, Qiang1" <qiang1.zhang@intel.com> wrote:
> >> 
> >>  
> >> 
> >> > 
> >> 
> >> >1. I attach the webpage https://access.redhat.com/solutions/5224631
> >> 
> >> > 
> >> 
> >>  
> >> 
> >> I read the analysis in the attachment
> >> 
> >>  
> >> 
> >>                         swait_event_idle(rcu_state.gp_wq,
> >> 
> >>                                          READ_ONCE(rcu_state.gp_flags) &
> >> 
> >>                                          RCU_GP_FLAG_INIT);
> >> 
> >>  
> >> 
> >> Hang here on CPU0 ,the RCU_GP_FLAG_INIT have been set,  under normal circumstances,
> >> 
> >> rcu_sched kthreads  should be awakened to continue execution, actually not so.
> >> 
> >> yours analysis concluded that the missed awakening.
> >> 
> >>  
> >> 
> >> I find the analysis does not give the status of  rcu_sched  kthreads at this time,  
> >> 
> >> Is it possible to see the status of the rcu_state kthread when this event occurred?
> >> 
> >> maybe it has been woken up and the state is runnable.
> >> 
> >> There may be a higher priority operation is  preventing it from running on CPU0
> >> 
> >>  
> >> 
> >> >2. refer to stallwarn.txt, The default value are "rcu_cpu_stall_suppress=0    rcu_cpu_stall_timeout=60    rcu_task_stall_timeout=600000"
> >> 
> >>   There are  no stall warnings infomations before.
> >> 
> >>  
> >> 
> >> I think you should first clarify the configuration of these parameters in your actual system,
> >> 
> >> instead of the default configuration that the documentation says.
> >> 
> >>  
> >> 
> >> You can “cat /sys/module/rcupdate/parameters/rcu_cpu_stall_suppress”
> >> 
> >>  
> >> 
> >>  
> >> 
> >> Thanks
> >> 
> >> Zqiang
> >> 
> >>  
> >> 
> >> >   
> >> 
> >> >  Does it need to enable other config like  rcu_kick_kthreads, CONFIG_TASKS_RCU_GENERIC CONFIG_TASKS_TRACE_RCU CONFIG_RCU_TRACE? 
> >> 
> >> > 
> >> 
> >> >3. I have not test that patch, that is production-environment.   firstly we try to reproduce this week.
> >> 
> >> >If reproduce fails, we have to test in that cluster.
> >> 
> >>  
> >> 
> >> May be you can also take a look at the analysis of this.
> >> 
> >>  
> >> 
> >> https://lore.kernel.org/all/CD6925E8781EFD4D8E11882D20FC406D52A11F61@SHSMSX104.ccr.corp.intel.com/T/#u
> >> 
> >>  
> >> 
> >> > 
> >> 
> >> >thanks
> >> 
> >>  
> >> 
> >>  
> >> 
> >>  
> >> 
> >>  
> >> 
> >>  
> >> 
> >> 
> >> 在 2022-06-15 13:07:55，"Paul E. McKenney" <paulmck@kernel.org> 写道：
> >> >On Wed, Jun 15, 2022 at 12:16:10PM +0800, yueluck wrote:
> >> >> add a detailed attachment
> >> >> 
> >> >> 
> >> >> 
> >> >> 
> >> >> 
> >> >> 
> >> >> 
> >> >> 
> >> >> 
> >> >> At 2022-06-15 12:14:23, "yueluck" <yueluck@163.com> wrote:
> >> >> 
> >> >> Hi, both of you：
> >> >>    Sorry to trouble you, because rcu is too complicated.  
> >> >>    I encounter many hung processes which are normal container-runc, the number of which  increases continuely and system load becomes higher and os reboots.
> >> >>    There is a related link  https://access.redhat.com/solutions/5224631，
> >> > 
> >> >I do not have access to this document, so I cannot say anything about
> >> >their offered solution.  They do claim to have a solution, though, so I
> >> >strongly suggest you follow their suggestions.  Me, I work with mainline,
> >> >and the 4.18 kernel that you are running was almost four years ago.
> >> > 
> >> >> the call stack and scene are similar.  patch https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1d1f898df6586c5ea9aeaf349f13089c6fa37903
> >> > 
> >> >What happens when you apply this patch?
> >> > 
> >> >>    process is never waken up after synchronize_rcu. 
> >> > 
> >> > 
> >> >> Could you pleae have a look at the call stack(attachment) and give me some idea?     
> >> >> source code :  https://github.com/bigclouds/linux-4.18.0-147.3.1.el8
> >> > 
> >> >Do you see RCU CPU stall warnings?  Please see the Linux-kernel file
> >> >named Documentation/RCU/stallwarn.* for more information.  (The "*" might
> >> >be "txt" or "rst" depending on how old your kernel source tree is.)
> >> >In particular, this file describes various things that can prevent
> >> >synchronize_rcu() from returning, ranging from CPUs spinning with
> >> >interrupts disabled to malfunctioning timer hardware.
> >> > 
> >> >If you do not see stall warnings, have they been disabled?  The values
> >> >of the RCU_CPU_STALL_TIMEOUT Kconfig option and the kernel boot
> >> >parameter rcupdate.rcu_cpu_stall_suppress control this, as does the
> >> >rcupdate.rcu_cpu_stall_suppress_at_boot kernel parameter.
> >> > 
> >> >So if the RCU CPU stall warnings have been disabled, please re-enable
> >> >them.  They give much more information on these sorts of problems.
> >> > 
> >> >Plus there is the usual debugging advice, for example, if this is a new
> >> >problem, look at what has changed at about the time that the problem
> >> >appeared.  For example, things like this can happen when backporting
> >> >fixes or when bringing up new hardware.
> >> > 
> >> >Also, please apply whatever debugging tools you have to check the health
> >> >of the CPUs, for example, to see if any are spinning with preeemption or
> >> >interrupts disabled.  Or even if any are in a tight loop in the kernel.
> >> >(No, this will not be visible from the stack trace of the task blocked
> >> >in synchronize_rcu().)
> >> > 
> >> >And again, please read Documentation/RCU/stallwarn.* carefully, preferably
> >> >getting the version from a recent kernel such as v5.18.  This document
> >> >contains lots of information on causes of this sort of problem.
> >> > 
> >> >                                                    Thanx, Paul
> >> > 
> >> >> Thanks,
> >> >> 
> >> >> 
> >> >> 
> >> >> 
> >> >> 
> >> >> 
> >> >> ------env-----------------------
> >> >> centos 4.18.0-147.3.1.el8_1.3
> >> >> -------ps------------------------
> >> >> $ ps -aux| grep 156623
> >> >> root      156623  0.0  0.0  24012  9044 ?        D    May31   0:00 runc init
> >> >> ------stack----------------------
> >> >> sudo cat /proc/156623/stack
> >> >> Password: 
> >> >> [<0>] __wait_rcu_gp+0x117/0x140
> >> >> [<0>] synchronize_rcu+0x6f/0x80
> >> >> [<0>] namespace_unlock+0x67/0x80
> >> >> [<0>] ksys_umount+0x231/0x450
> >> >> [<0>] __x64_sys_umount+0x12/0x20
> >> >> [<0>] do_syscall_64+0x5b/0x1c0
> >> >> [<0>] entry_SYSCALL_64_after_hwframe+0x65/0xca
> >> >> [<0>] 0xffffffffffffffff
> >> >> test:/var/log$ sudo cat /proc/156623/stat
> >> >> ----------------------------------
> >> > 
> >
