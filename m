Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18062C433EF
	for <rcu@archiver.kernel.org>; Fri, 22 Apr 2022 16:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379424AbiDVQDS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 22 Apr 2022 12:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449808AbiDVQC7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 22 Apr 2022 12:02:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348476346
        for <rcu@vger.kernel.org>; Fri, 22 Apr 2022 09:00:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A21A4B8307B
        for <rcu@vger.kernel.org>; Fri, 22 Apr 2022 16:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373ABC385A0;
        Fri, 22 Apr 2022 16:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650643201;
        bh=cqchrytV9LIEKE2u4suICI8Nsoz260lUqbRIrcN7ISs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Kl/dnvtVgeJ81iHW/k3PBU/GhhTuVRglqYw1JeNqifmOXL7v9zEhVSzfgK0Jl0Ugj
         RDhx/LOWypJ9VlsKmxmt7rv00jCo8Ho0+MbalHLhrPW6QR2ojsNiUuQYETOrXfTXoK
         emO1njR/0x8yYBqdxEFr0bgiUJGFTjUpxOSZ0lviT7sSLInt2p7PTjvu8YhHtT4TUb
         t8bz8QqncJprnHz3NYzK9V933rHG9bUaCMIN8spwshvt4Rwz0T7Ke2mIiOEdcKR9n0
         LRAGaZ7z7Sr8Cxvk9sKIT16MoFLcOsI6j8IuSeLniikqkg/rE4SZnXr27hqoB2p///
         hyA2n+ZSfoX9g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CE1CF5C08B8; Fri, 22 Apr 2022 09:00:00 -0700 (PDT)
Date:   Fri, 22 Apr 2022 09:00:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     urezki@gmail.com, Paul McKenney <paulmckrcu@fb.com>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: Reproducing call_rcu_tasks self-test bug on a dual sockets Intel
 Xeon machine
Message-ID: <20220422160000.GA4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAABZP2xEtRnbRMGgywc2RSwiOAd1QY5jr0ZxwXd9p_8XwOiqhw@mail.gmail.com>
 <20220419230412.GU4285@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2zBdDxmiFzwB+rg8fzfYHhteAmkRvaYMAXzQ_B12EF16w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABZP2zBdDxmiFzwB+rg8fzfYHhteAmkRvaYMAXzQ_B12EF16w@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 22, 2022 at 01:28:51PM +0800, Zhouyi Zhou wrote:
> Hi Paul
> 
> On Wed, Apr 20, 2022 at 7:04 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Apr 18, 2022 at 11:16:16AM +0800, Zhouyi Zhou wrote:
> > > 1. Abstract
> > > Previously, Matthew has reported a call_rcu_tasks bug [1]. But it is
> > > hard to reproduce on a dual socket Intel machine. This report
> > > developed a method to reproduce that bug on such a machine.
> > >
> > > 2. Introduction
> > > Matthew has reported a call_rcu_tasks bug [1]. It is easy to reproduce
> > > it on Thinkpad P1 gen4 (Intel i7-11800H) with following steps:
> > > a) cp [2] to .config
> > > b) build the kernel
> > > c) execute  kvm -smp 4 -net none -serial file:/tmp/console.log -m 512
> > > -kernel vmlinux -append "console=ttyS0"
> > >
> > > The bug can even be reproduced on Thinkpad P1 gen4 (i7-11800H) by
> > > stress testing the TASKS01 with the script [3].
> > >
> > > However, the bug can't be reproduced by above methods on a dual socket
> > > Intel Xeon machine (PowerEdge R720, Intel(R) Xeon(R) CPU E5-2660 0 @
> > > 2.20GHz, 2 CPUs, 16 cores, 32 threads).
> > >
> > > 3. Discover the reason behind the bug
> > > On thinkpad P1 gen4, I tried to discover the reason behind the bug.
> > > After some experimentation, I found that removing CONFIG_NFS_V4 from
> > > the kernel config file will greatly increase the probabilities of
> > > triggering the bug.
> > >
> > > I guess maybe the init calls lend the grace period to RCU tasks self
> > > tests, so I add some debug code to a test kernel to see what happens:
> > > root@e0816662e3db:/mnt/linux# git diff
> > > diff --git a/init/main.c b/init/main.c
> > > index 98182c3c2c4b..9731566014cc 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -1356,6 +1356,8 @@ static int __init ignore_unknown_bootoption(char
> > > *param, char *val,
> > >         return 0;
> > >  }
> > >
> > > +extern bool *notrunp;
> > > +unsigned int numofcalls = 0;
> > >  static void __init do_initcall_level(int level, char *command_line)
> > >  {
> > >         initcall_entry_t *fn;
> > > @@ -1367,8 +1369,19 @@ static void __init do_initcall_level(int level,
> > > char *command_line)
> > >                    NULL, ignore_unknown_bootoption);
> > >
> > >         trace_initcall_level(initcall_level_names[level]);
> > > -       for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
> > > +       for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++) {
> > > +               bool before = *notrunp, after;
> > > +               unsigned long jiffies_save = jiffies;
> > > +               numofcalls++;
> > >                 do_one_initcall(initcall_from_entry(fn));
> > > +               after = *notrunp;
> > > +               if (before != after) {
> > > +                 char sym[KSYM_SYMBOL_LEN];
> > > +                 sprint_symbol(sym, (unsigned long )initcall_from_entry(fn));
> > > +                 printk(KERN_INFO "init call level %d: %s changed the
> > > rcu task test %lu\n",
> > > +                        level, sym, jiffies - jiffies_save);
> > > +               }
> > > +       }
> > >  }
> > >
> > >  static void __init do_initcalls(void)
> > > @@ -1376,15 +1389,17 @@ static void __init do_initcalls(void)
> > >         int level;
> > >         size_t len = strlen(saved_command_line) + 1;
> > >         char *command_line;
> > > -
> > > +       unsigned long jiffies_save = jiffies;
> > >         command_line = kzalloc(len, GFP_KERNEL);
> > >         if (!command_line)
> > >                 panic("%s: Failed to allocate %zu bytes\n", __func__, len);
> > > -
> > > +
> > >         for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++) {
> > >                 /* Parser modifies command_line, restore it each time */
> > >                 strcpy(command_line, saved_command_line);
> > >                 do_initcall_level(level, command_line);
> > > +               if (level == 5)
> > > +                 printk(KERN_INFO"init call level 5 costs: %lu
> > > numofcalls %u\n", jiffies - jiffies_save, numofcalls);
> > >         }
> > >
> > >         kfree(command_line);
> > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > index 99cf3a13954c..f4e175eeaec3 100644
> > > --- a/kernel/rcu/tasks.h
> > > +++ b/kernel/rcu/tasks.h
> > > @@ -1660,7 +1660,7 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
> > >
> > >         rttd->notrun = true;
> > >  }
> > > -
> > > +bool *notrunp = &tests[0].notrun;
> > >  static void rcu_tasks_initiate_self_tests(void)
> > >  {
> > >         pr_info("Running RCU-tasks wait API self tests\n");
> > >
> > > The tests on Thinkpad P1 gen4 and Dell PowerEdge R720 show that during
> > > the test, some init call will lend the grace period to the RCU tasks
> > > self tests.
> > >
> > > And of course, I am not using the above modification in Section 5 and
> > > Section 6' tests. Section 5 and Section 6's tests are performed on
> > > unmodified mainline!!
> > >
> > > 4. Reduce the init calls in kernel configuration
> > > Based on above observation, I tried to reduce the kernel configuration
> > > starting from [2] meanwhile keep the qemu bootable. Finally I got
> > > [4].
> > > And [4] will trigger the bug on Dell PowerEdge R720!
> > >
> > > 5. Trigger the bug in a more Linux way.
> > > Why TASKS01 will not trigger the bug? There are two reasons:
> > > a) there are too many init calls that will lend the grace period
> > > b) the debug kernel param will lend the grace period
> > >
> > > Solution to reason a:
> > > I write a C++ program [5] to print the difference between the .config
> > > generated by TASKS01 and [4]. Then I use the difference to create a
> > > TASKS04.
> > >
> > > Solution to reason b:
> > > I add loglevel=7 to qemu boot parameter.
> > >
> > > The result consists of newly created TASKS04 and TASKS04.boot [6].
> > >
> > > Now the bug can trigger every time on Dell PowerEdge R720 by invoking:
> > > ./tools/testing/selftests/rcutorture/bin/kvm.sh --configs "TASKS04"
> > > --duration 10 --trust-make
> > >
> > > 6. Conclusion
> > > I am able to trigger the bug everytime in mainline without modifying
> > > the kernel's functional code on a dual socket Intel Xeon machine.
> > >
> > > 7. Acknowledgement
> > > Thanks Paul for your constant encouragement! Thanks Zhouyi
> >
> > And thank you for digging into this!
> You are very welcome ;-)
> >
> References
> [1] https://lore.kernel.org/rcu/20220322142101.GQ4285@paulmck-ThinkPad-P17-Gen-1/T/#mb696465963393bbc3d38e85ffef0e03cf1e4fa54
> [2] http://154.223.142.244/20220321/config-20220321
> [3] http://154.223.142.244/20220418/test.sh.txt
> [4] http://154.223.142.244/20220418/config
> [5] http://154.223.142.244/20220418/processconfig.cpp
> [6] http://154.223.142.244/20220418/0001-RCU.patch
> > Here is a sneak preview of a lightly tested alleged fix, which may be
> > found on the -rcu tree's "dev" branch:
> >
> > a3b1f9e07d47 rcu-tasks: Split rcu_tasks_one_gp() from rcu_tasks_kthread()
> > 130dd60ddd96 rcu-tasks: Move synchronize_rcu_tasks_generic() down
> > 7e510e661ea5 rcu-tasks: Drive synchronous grace periods from calling task
> >
> > Note that these are in the order that they should be applied rather than
> > in git-log order.
> I have been testing the above patches these days, on my Dell Poweredge
> R720, the bug seems to be gone. But on my Thinkpad P1 gen4, the bug
> seems to be there still.  Sorry to report that bad news.

Hey, there is some improvement, so that counts as good news!  Besides,
it is what it is.  So thank you for testing and for letting me know both
the good and the not-quite-so-good news.  ;-)

> I will study your patches carefully and double check my test
> environment in the coming days.

Could you please trace the series of calls to these functions up to
the faiure?

	synchronize_rcu_tasks()
	call_rcu_tasks()
	synchronize_rcu_tasks_rude()
	call_rcu_tasks_rude()
	synchronize_rcu_tasks_trace()
	call_rcu_tasks_trace()
	synchronize_rcu_tasks_generic()
	rcu_tasks_one_gp()

One possibility is that the RCU tasks GP kthreads are not getting
scheduled during that time on your Thinkpad.  If so, something
like schedule_timeout_uninterruptible(1) at the beginning of
rcu_tasks_verify_self_tests() should avoid the failure.  (Not a proper
fix, of course!  Just for testing.)

> I add Uladzislau, author of bfba7ed084f8a  rcu-tasks: Add RCU-tasks
> self tests to cc list.

Thank you!

Huh.  With my patch, it should be possible to move the
invocation of rcu_tasks_initiate_self_tests() to the beginning of
rcu_init_tasks_generic().

							Thanx, Paul

> Kind Regards
> Sincerely yours
> Zhouyi
> >
> >                                                         Thanx, Paul
