Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1119BC43334
	for <rcu@archiver.kernel.org>; Fri, 24 Jun 2022 12:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiFXMzR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 24 Jun 2022 08:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiFXMzR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 24 Jun 2022 08:55:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6038625A
        for <rcu@vger.kernel.org>; Fri, 24 Jun 2022 05:55:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60896B82805
        for <rcu@vger.kernel.org>; Fri, 24 Jun 2022 12:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9DCC34114;
        Fri, 24 Jun 2022 12:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656075313;
        bh=Y3iMlJuxWiCXSsLFV8QBrj+jyiVqv25vDCHGVVDQDeg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Hk0BH6sRgGKCD/ojJQyhtfLJNEAGFd/BORNeP3KpkAIoaZSWlMmTporziwwoO1dci
         p4rLJ7JdG7RjYRxl2pzSGVKOLxX5HOM92RXDqkPQcbUdxlfxgVK5t87wSrQ5msfdjx
         d8Bf5MadsgvtzSDOE+L/YKeYuN9k6SlX6VkuMCx1vmwIH2vEgg4YXj/VkbjJO34Mqp
         lQcHVzjEy2f9joqtNjTNUsI49H2+YlqwIll3yqNCBFXxuLLzr2JX1xQWJSLoc3lV6i
         K+mvJcT3aNc3HmESyFeoOzpd8iOnJjtqV/tfAioBwiuXRTs/M6qTWCSy5AFERqrEKE
         8E/3PNTr/psRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CAEF45C04B3; Fri, 24 Jun 2022 05:55:12 -0700 (PDT)
Date:   Fri, 24 Jun 2022 05:55:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     yueluck <yueluck@163.com>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: RE: Re:RE: Re:Re: question about rcu and many hung processes
 lead to reboot
Message-ID: <20220624125512.GA1824229@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <9441c66.1e15.1816591cf9d.Coremail.yueluck@163.com>
 <f1de832.1e37.1816593718c.Coremail.yueluck@163.com>
 <20220615050755.GF1790663@paulmck-ThinkPad-P17-Gen-1>
 <6f9fa802.41a5.1816718d276.Coremail.yueluck@163.com>
 <PH0PR11MB5880184DCC0F0EC6798AC5AEDAAD9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB5880370046830F85F3E8DF95DAAD9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <342ba374.42bd.181719c68f5.Coremail.yueluck@163.com>
 <PH0PR11MB5880D00D5BF2D2C40A2734BBDAAF9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <5f8e371e.3e3b.181900adafc.Coremail.yueluck@163.com>
 <20220624034515.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624034515.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 23, 2022 at 08:45:15PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 23, 2022 at 06:10:39PM +0800, yueluck wrote:
> > 
> > 
> > 
> > 1. check “rcu_preempt” kthreads state(R or I ?), though “cat /proc/(rcu_preempt kthread pid)/status”
> > 
> > 
> >     It seems preempt kthread is always in "I" state,  but as long as there is hung process, preempt thread has no context switch (voluntary_ctxt_switches and nonvoluntary_ctxt_switches do not change),  is it dead?  if so  kernel would crash.
> > 
> > 
> >     I have screen-snapshot attached.  
> >     
> > 2. I have not seen any RCU Stall warning messages. 
> > 
> > 
> > 3. I have been testing patched kernel for 3 days, so far so good.
> 
> If I understand correctly, this is very encouranging!  I expect that
> Neeraj would be happy to add your Tested-by.
> 
> And somewhere I recall expressing doubts about the large numbers of spins.
> But further thought led me to recall that it was not all that long ago
> that expedited SRCU grace periods did nothing but spin.  So this might
> be OK despite my initial misgivings.
> 
> Neeraj, your choice!

Apologies, I was confusing this thread about backports of RCU patches
with another thread involving SRCU.

I will let you guys handle the needed backports and sending of patches
to -stable.

							Thanx, Paul

> > thanks
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > At 2022-06-18 00:44:40, "Zhang, Qiang1" <qiang1.zhang@intel.com> wrote:
> > 
> > >Hi, i saw  some source codes, but for rcu i am still a layman.
> > 
> > > 
> > 
> > >1. we are gonna get core dump.  In my test environment, i can grep "D" processes with the same callstack, but those processes can recover after a while(1-2 seconds).
> > 
> >   synchronize_rcu->__wait_rcu_gp->wait_for_completion->schedule_timeout, at this  point , process goes to sleep.
> > 
> >   could you explain:
> > 
> >    1) how/where is  this process waken up normally.
> > 
> >    2) how to know GP is end. 
> > 
> >    3) what is your ideals to solve so touch issue, i will follow your instruction.
> > 
> >  
> > 
> > First, I find the 4.18 kernel is not support output “rcu_preempt” kthreads info though ‘echo y > /proc/sysrq-trigger’.
> > 
> > So when hang appear, you can check “rcu_preempt” kthreads state(R or I ?), though “cat /proc/(rcu_preempt kthread pid)/status”
> > 
> > and “cat /proc/(rcu_preempt kthread pid)/stack”, you also can “echo t > /proc/sysrq-trigger”.
> > 
> >  
> > 
> > You need use crash tools load coredump to check it, and enable rcu trace event,
> > 
> > “cd /sys/kernel/debug/tracing/events/rcu” to enable trace.
> > 
> >  
> > 
> > Please try this patch first to test:
> > 
> >  
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1d1f898df6586c5ea9aeaf349f13089c6fa37903
> > 
> >  
> > 
> > >2. It is PREEMPTION kernel .   grub boot params  have rcu-related configuration.
> > 
> >   crashkernel=auto iommu=pt nmi_watchdog=panic,1 softlockup_panic=1 intel_iommu=on user_namespace.enable=1 hugepagesz=2M hugepages=0 default_hugepagesz=2M irqaffinity=0,36 rcu_nocbs=1-35,37-71 kthread_cpus=0,36 nopti nospectre_v2
> > 
> >  
> > 
> > >3. "rcu_cpu_stall_suppress=0    rcu_cpu_stall_timeout=60    rcu_task_stall_timeout=600000" are fetched via 'cat /sys/module/rcupdate/parameters/rcu_*'
> > 
> >  
> > 
> > Did you find RCU Stall warning messages?
> > 
> >  
> > 
> > Thanks
> > 
> > Zqiang
> > 
> >  
> > 
> > > 
> > 
> > > 
> > 
> > >Thanks for all your help.
> > 
> >  
> > 
> >  
> > 
> >  
> > 
> >  
> > 
> >  
> > 
> >  
> > 
> >  
> > 
> >  
> > 
> > At 2022-06-15 21:31:59, "Zhang, Qiang1" <qiang1.zhang@intel.com> wrote:
> > 
> >  
> > 
> > > 
> > 
> > >1. I attach the webpage https://access.redhat.com/solutions/5224631
> > 
> > > 
> > 
> >  
> > 
> > I read the analysis in the attachment
> > 
> >  
> > 
> >                         swait_event_idle(rcu_state.gp_wq,
> > 
> >                                          READ_ONCE(rcu_state.gp_flags) &
> > 
> >                                          RCU_GP_FLAG_INIT);
> > 
> >  
> > 
> > Hang here on CPU0 ,the RCU_GP_FLAG_INIT have been set,  under normal circumstances,
> > 
> > rcu_sched kthreads  should be awakened to continue execution, actually not so.
> > 
> > yours analysis concluded that the missed awakening.
> > 
> >  
> > 
> > I find the analysis does not give the status of  rcu_sched  kthreads at this time,  
> > 
> > Is it possible to see the status of the rcu_state kthread when this event occurred?
> > 
> > maybe it has been woken up and the state is runnable.
> > 
> > There may be a higher priority operation is  preventing it from running on CPU0
> > 
> >  
> > 
> > >2. refer to stallwarn.txt, The default value are "rcu_cpu_stall_suppress=0    rcu_cpu_stall_timeout=60    rcu_task_stall_timeout=600000"
> > 
> >   There are  no stall warnings infomations before.
> > 
> >  
> > 
> > I think you should first clarify the configuration of these parameters in your actual system,
> > 
> > instead of the default configuration that the documentation says.
> > 
> >  
> > 
> > You can “cat /sys/module/rcupdate/parameters/rcu_cpu_stall_suppress”
> > 
> >  
> > 
> >  
> > 
> > Thanks
> > 
> > Zqiang
> > 
> >  
> > 
> > >   
> > 
> > >  Does it need to enable other config like  rcu_kick_kthreads, CONFIG_TASKS_RCU_GENERIC CONFIG_TASKS_TRACE_RCU CONFIG_RCU_TRACE? 
> > 
> > > 
> > 
> > >3. I have not test that patch, that is production-environment.   firstly we try to reproduce this week.
> > 
> > >If reproduce fails, we have to test in that cluster.
> > 
> >  
> > 
> > May be you can also take a look at the analysis of this.
> > 
> >  
> > 
> > https://lore.kernel.org/all/CD6925E8781EFD4D8E11882D20FC406D52A11F61@SHSMSX104.ccr.corp.intel.com/T/#u
> > 
> >  
> > 
> > > 
> > 
> > >thanks
> > 
> >  
> > 
> >  
> > 
> >  
> > 
> >  
> > 
> >  
> > 
> > 
> > 在 2022-06-15 13:07:55，"Paul E. McKenney" <paulmck@kernel.org> 写道：
> > >On Wed, Jun 15, 2022 at 12:16:10PM +0800, yueluck wrote:
> > >> add a detailed attachment
> > >> 
> > >> 
> > >> 
> > >> 
> > >> 
> > >> 
> > >> 
> > >> 
> > >> 
> > >> At 2022-06-15 12:14:23, "yueluck" <yueluck@163.com> wrote:
> > >> 
> > >> Hi, both of you：
> > >>    Sorry to trouble you, because rcu is too complicated.  
> > >>    I encounter many hung processes which are normal container-runc, the number of which  increases continuely and system load becomes higher and os reboots.
> > >>    There is a related link  https://access.redhat.com/solutions/5224631，
> > > 
> > >I do not have access to this document, so I cannot say anything about
> > >their offered solution.  They do claim to have a solution, though, so I
> > >strongly suggest you follow their suggestions.  Me, I work with mainline,
> > >and the 4.18 kernel that you are running was almost four years ago.
> > > 
> > >> the call stack and scene are similar.  patch https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1d1f898df6586c5ea9aeaf349f13089c6fa37903
> > > 
> > >What happens when you apply this patch?
> > > 
> > >>    process is never waken up after synchronize_rcu. 
> > > 
> > > 
> > >> Could you pleae have a look at the call stack(attachment) and give me some idea?     
> > >> source code :  https://github.com/bigclouds/linux-4.18.0-147.3.1.el8
> > > 
> > >Do you see RCU CPU stall warnings?  Please see the Linux-kernel file
> > >named Documentation/RCU/stallwarn.* for more information.  (The "*" might
> > >be "txt" or "rst" depending on how old your kernel source tree is.)
> > >In particular, this file describes various things that can prevent
> > >synchronize_rcu() from returning, ranging from CPUs spinning with
> > >interrupts disabled to malfunctioning timer hardware.
> > > 
> > >If you do not see stall warnings, have they been disabled?  The values
> > >of the RCU_CPU_STALL_TIMEOUT Kconfig option and the kernel boot
> > >parameter rcupdate.rcu_cpu_stall_suppress control this, as does the
> > >rcupdate.rcu_cpu_stall_suppress_at_boot kernel parameter.
> > > 
> > >So if the RCU CPU stall warnings have been disabled, please re-enable
> > >them.  They give much more information on these sorts of problems.
> > > 
> > >Plus there is the usual debugging advice, for example, if this is a new
> > >problem, look at what has changed at about the time that the problem
> > >appeared.  For example, things like this can happen when backporting
> > >fixes or when bringing up new hardware.
> > > 
> > >Also, please apply whatever debugging tools you have to check the health
> > >of the CPUs, for example, to see if any are spinning with preeemption or
> > >interrupts disabled.  Or even if any are in a tight loop in the kernel.
> > >(No, this will not be visible from the stack trace of the task blocked
> > >in synchronize_rcu().)
> > > 
> > >And again, please read Documentation/RCU/stallwarn.* carefully, preferably
> > >getting the version from a recent kernel such as v5.18.  This document
> > >contains lots of information on causes of this sort of problem.
> > > 
> > >                                                    Thanx, Paul
> > > 
> > >> Thanks,
> > >> 
> > >> 
> > >> 
> > >> 
> > >> 
> > >> 
> > >> ------env-----------------------
> > >> centos 4.18.0-147.3.1.el8_1.3
> > >> -------ps------------------------
> > >> $ ps -aux| grep 156623
> > >> root      156623  0.0  0.0  24012  9044 ?        D    May31   0:00 runc init
> > >> ------stack----------------------
> > >> sudo cat /proc/156623/stack
> > >> Password: 
> > >> [<0>] __wait_rcu_gp+0x117/0x140
> > >> [<0>] synchronize_rcu+0x6f/0x80
> > >> [<0>] namespace_unlock+0x67/0x80
> > >> [<0>] ksys_umount+0x231/0x450
> > >> [<0>] __x64_sys_umount+0x12/0x20
> > >> [<0>] do_syscall_64+0x5b/0x1c0
> > >> [<0>] entry_SYSCALL_64_after_hwframe+0x65/0xca
> > >> [<0>] 0xffffffffffffffff
> > >> test:/var/log$ sudo cat /proc/156623/stat
> > >> ----------------------------------
> > > 
> 
> 
