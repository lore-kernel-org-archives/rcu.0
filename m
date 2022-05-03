Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D997C433F5
	for <rcu@archiver.kernel.org>; Tue,  3 May 2022 22:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbiECWwk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 May 2022 18:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbiECWwk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 May 2022 18:52:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5516532066
        for <rcu@vger.kernel.org>; Tue,  3 May 2022 15:49:05 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k23so36092721ejd.3
        for <rcu@vger.kernel.org>; Tue, 03 May 2022 15:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/ue9szFyPlQ9w/mHdcjUq+oJR8Z1ia+EfHxcRE2LM0=;
        b=JfqMU2NmqRGMq6cM3yFE6b+UYXqHwMSBMHdWFbeJsnJcCGyrz53eHPZ5QYL72izKq6
         sS65OSkOMk2JzEUEDxnNDfWV3FEMrMTpwOCOMJd97XIKWe7xmU/HczG3OPOtYA6X2n1s
         tLP7xr/QSbFrISMH7Fqo4Bm3lCOZ+YPH7iynCt7jijem6jfgO27OQ7NFX7gQuNdAjEvU
         5vnfLAmZ6o259ywjG1B0LC4lj6u6swGblBasxz0dHFmiliS+ns4pwFxBwYvRU6CGGN2x
         3sLE1atjeUDzBvCpvlbEgA1TS6wC06OGuGVEtf9PDnkpIgSFhnGWfQynDSM3wAO/RJVV
         cUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/ue9szFyPlQ9w/mHdcjUq+oJR8Z1ia+EfHxcRE2LM0=;
        b=0Ef+OyUUdTfNykqPVFfA23bZ8crQLtcJqrpv7Io+RvII/3Rqfa+OFmrFGlux7WPk6w
         jBeUkkdZDIBxvFZmXJvH3wOrEtNYF1Onecx7A3593nSOJykUMgj0U9gussU+Jn/K4xVo
         g+T915+WfC3ZwGX3N6lw3LINOLGTa9Imcuo1iNL2nEAw77BfgVpcDNbyFUWbAyu362dt
         +GdnAeqOGjy+4LRaEXjwA+qC/yodBQ02xKBVPdWCzKBNkx3xEDRocvQoEDe2ZEq1Z9OQ
         2jH0Wv48bWCbWYV1eCNc32MqkrkcPUCGyoOrnbEBcclUyEAD1Yz+Sh1fgrrxQGL5GIvZ
         GAyw==
X-Gm-Message-State: AOAM530HFCEnOPCvOFkdQgOEwUttrnipuARGiOcO01hL6l5njyBkqqC9
        Xwm4Yq9KxOwqyj+kPoj+6/Tjz0NT9whOhVhgg9Q8+n4F
X-Google-Smtp-Source: ABdhPJzHA4K6u37G2wwWkHDxoIcQ06MrJcNoYAd5lmj1ERs3+5rzwA3xUykE99LN5xcoxTplOhh09rfJ48iJiqlJXlU=
X-Received: by 2002:a17:906:7746:b0:6ce:a12e:489f with SMTP id
 o6-20020a170906774600b006cea12e489fmr17241718ejn.551.1651618143709; Tue, 03
 May 2022 15:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2xEtRnbRMGgywc2RSwiOAd1QY5jr0ZxwXd9p_8XwOiqhw@mail.gmail.com>
 <20220419230412.GU4285@paulmck-ThinkPad-P17-Gen-1> <CAABZP2zBdDxmiFzwB+rg8fzfYHhteAmkRvaYMAXzQ_B12EF16w@mail.gmail.com>
 <20220422160000.GA4285@paulmck-ThinkPad-P17-Gen-1> <CAABZP2ytjGo5hfEftBQL-kpKvN-bo-mP_L3Wy0H=PWv2YeGYcQ@mail.gmail.com>
 <CAABZP2xcPH5WAzrFEogH1Xs5=ZYkW3+RT0ocZs16=F+nw9_UAQ@mail.gmail.com> <20220503144024.GK1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220503144024.GK1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Wed, 4 May 2022 06:48:51 +0800
Message-ID: <CAABZP2xPRZs7wKKebMJwM595HHw1ktEJBnMNpKZk9tMrUcf=dw@mail.gmail.com>
Subject: Re: Reproducing call_rcu_tasks self-test bug on a dual sockets Intel
 Xeon machine
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     urezki@gmail.com, Paul McKenney <paulmckrcu@fb.com>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, May 3, 2022 at 10:40 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, May 03, 2022 at 08:53:47AM +0800, Zhouyi Zhou wrote:
> > Hi Paul
> > Thanks for your guidance!
>
> And thank you for persisting on this!
You are very welcome! And this is the best learning experience for me!
And the work may benefit  the world!
>
> > On Sat, Apr 23, 2022 at 1:35 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> > >
> > > On Sat, Apr 23, 2022 at 12:00 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Fri, Apr 22, 2022 at 01:28:51PM +0800, Zhouyi Zhou wrote:
> > > > > Hi Paul
> > > > >
> > > > > On Wed, Apr 20, 2022 at 7:04 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, Apr 18, 2022 at 11:16:16AM +0800, Zhouyi Zhou wrote:
> > > > > > > 1. Abstract
> > > > > > > Previously, Matthew has reported a call_rcu_tasks bug [1]. But it is
> > > > > > > hard to reproduce on a dual socket Intel machine. This report
> > > > > > > developed a method to reproduce that bug on such a machine.
> > > > > > >
> > > > > > > 2. Introduction
> > > > > > > Matthew has reported a call_rcu_tasks bug [1]. It is easy to reproduce
> > > > > > > it on Thinkpad P1 gen4 (Intel i7-11800H) with following steps:
> > > > > > > a) cp [2] to .config
> > > > > > > b) build the kernel
> > > > > > > c) execute  kvm -smp 4 -net none -serial file:/tmp/console.log -m 512
> > > > > > > -kernel vmlinux -append "console=ttyS0"
> > > > > > >
> > > > > > > The bug can even be reproduced on Thinkpad P1 gen4 (i7-11800H) by
> > > > > > > stress testing the TASKS01 with the script [3].
> > > > > > >
> > > > > > > However, the bug can't be reproduced by above methods on a dual socket
> > > > > > > Intel Xeon machine (PowerEdge R720, Intel(R) Xeon(R) CPU E5-2660 0 @
> > > > > > > 2.20GHz, 2 CPUs, 16 cores, 32 threads).
> > > > > > >
> > > > > > > 3. Discover the reason behind the bug
> > > > > > > On thinkpad P1 gen4, I tried to discover the reason behind the bug.
> > > > > > > After some experimentation, I found that removing CONFIG_NFS_V4 from
> > > > > > > the kernel config file will greatly increase the probabilities of
> > > > > > > triggering the bug.
> > > > > > >
> > > > > > > I guess maybe the init calls lend the grace period to RCU tasks self
> > > > > > > tests, so I add some debug code to a test kernel to see what happens:
> > > > > > > root@e0816662e3db:/mnt/linux# git diff
> > > > > > > diff --git a/init/main.c b/init/main.c
> > > > > > > index 98182c3c2c4b..9731566014cc 100644
> > > > > > > --- a/init/main.c
> > > > > > > +++ b/init/main.c
> > > > > > > @@ -1356,6 +1356,8 @@ static int __init ignore_unknown_bootoption(char
> > > > > > > *param, char *val,
> > > > > > >         return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > +extern bool *notrunp;
> > > > > > > +unsigned int numofcalls = 0;
> > > > > > >  static void __init do_initcall_level(int level, char *command_line)
> > > > > > >  {
> > > > > > >         initcall_entry_t *fn;
> > > > > > > @@ -1367,8 +1369,19 @@ static void __init do_initcall_level(int level,
> > > > > > > char *command_line)
> > > > > > >                    NULL, ignore_unknown_bootoption);
> > > > > > >
> > > > > > >         trace_initcall_level(initcall_level_names[level]);
> > > > > > > -       for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
> > > > > > > +       for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++) {
> > > > > > > +               bool before = *notrunp, after;
> > > > > > > +               unsigned long jiffies_save = jiffies;
> > > > > > > +               numofcalls++;
> > > > > > >                 do_one_initcall(initcall_from_entry(fn));
> > > > > > > +               after = *notrunp;
> > > > > > > +               if (before != after) {
> > > > > > > +                 char sym[KSYM_SYMBOL_LEN];
> > > > > > > +                 sprint_symbol(sym, (unsigned long )initcall_from_entry(fn));
> > > > > > > +                 printk(KERN_INFO "init call level %d: %s changed the
> > > > > > > rcu task test %lu\n",
> > > > > > > +                        level, sym, jiffies - jiffies_save);
> > > > > > > +               }
> > > > > > > +       }
> > > > > > >  }
> > > > > > >
> > > > > > >  static void __init do_initcalls(void)
> > > > > > > @@ -1376,15 +1389,17 @@ static void __init do_initcalls(void)
> > > > > > >         int level;
> > > > > > >         size_t len = strlen(saved_command_line) + 1;
> > > > > > >         char *command_line;
> > > > > > > -
> > > > > > > +       unsigned long jiffies_save = jiffies;
> > > > > > >         command_line = kzalloc(len, GFP_KERNEL);
> > > > > > >         if (!command_line)
> > > > > > >                 panic("%s: Failed to allocate %zu bytes\n", __func__, len);
> > > > > > > -
> > > > > > > +
> > > > > > >         for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++) {
> > > > > > >                 /* Parser modifies command_line, restore it each time */
> > > > > > >                 strcpy(command_line, saved_command_line);
> > > > > > >                 do_initcall_level(level, command_line);
> > > > > > > +               if (level == 5)
> > > > > > > +                 printk(KERN_INFO"init call level 5 costs: %lu
> > > > > > > numofcalls %u\n", jiffies - jiffies_save, numofcalls);
> > > > > > >         }
> > > > > > >
> > > > > > >         kfree(command_line);
> > > > > > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > > > > > index 99cf3a13954c..f4e175eeaec3 100644
> > > > > > > --- a/kernel/rcu/tasks.h
> > > > > > > +++ b/kernel/rcu/tasks.h
> > > > > > > @@ -1660,7 +1660,7 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
> > > > > > >
> > > > > > >         rttd->notrun = true;
> > > > > > >  }
> > > > > > > -
> > > > > > > +bool *notrunp = &tests[0].notrun;
> > > > > > >  static void rcu_tasks_initiate_self_tests(void)
> > > > > > >  {
> > > > > > >         pr_info("Running RCU-tasks wait API self tests\n");
> > > > > > >
> > > > > > > The tests on Thinkpad P1 gen4 and Dell PowerEdge R720 show that during
> > > > > > > the test, some init call will lend the grace period to the RCU tasks
> > > > > > > self tests.
> > > > > > >
> > > > > > > And of course, I am not using the above modification in Section 5 and
> > > > > > > Section 6' tests. Section 5 and Section 6's tests are performed on
> > > > > > > unmodified mainline!!
> > > > > > >
> > > > > > > 4. Reduce the init calls in kernel configuration
> > > > > > > Based on above observation, I tried to reduce the kernel configuration
> > > > > > > starting from [2] meanwhile keep the qemu bootable. Finally I got
> > > > > > > [4].
> > > > > > > And [4] will trigger the bug on Dell PowerEdge R720!
> > > > > > >
> > > > > > > 5. Trigger the bug in a more Linux way.
> > > > > > > Why TASKS01 will not trigger the bug? There are two reasons:
> > > > > > > a) there are too many init calls that will lend the grace period
> > > > > > > b) the debug kernel param will lend the grace period
> > > > > > >
> > > > > > > Solution to reason a:
> > > > > > > I write a C++ program [5] to print the difference between the .config
> > > > > > > generated by TASKS01 and [4]. Then I use the difference to create a
> > > > > > > TASKS04.
> > > > > > >
> > > > > > > Solution to reason b:
> > > > > > > I add loglevel=7 to qemu boot parameter.
> > > > > > >
> > > > > > > The result consists of newly created TASKS04 and TASKS04.boot [6].
> > > > > > >
> > > > > > > Now the bug can trigger every time on Dell PowerEdge R720 by invoking:
> > > > > > > ./tools/testing/selftests/rcutorture/bin/kvm.sh --configs "TASKS04"
> > > > > > > --duration 10 --trust-make
> > > > > > >
> > > > > > > 6. Conclusion
> > > > > > > I am able to trigger the bug everytime in mainline without modifying
> > > > > > > the kernel's functional code on a dual socket Intel Xeon machine.
> > > > > > >
> > > > > > > 7. Acknowledgement
> > > > > > > Thanks Paul for your constant encouragement! Thanks Zhouyi
> > > > > >
> > > > > > And thank you for digging into this!
> > > > > You are very welcome ;-)
> > > > > >
> > > > > References
> > > > > [1] https://lore.kernel.org/rcu/20220322142101.GQ4285@paulmck-ThinkPad-P17-Gen-1/T/#mb696465963393bbc3d38e85ffef0e03cf1e4fa54
> > > > > [2] http://154.223.142.244/20220321/config-20220321
> > > > > [3] http://154.223.142.244/20220418/test.sh.txt
> > > > > [4] http://154.223.142.244/20220418/config
> > > > > [5] http://154.223.142.244/20220418/processconfig.cpp
> > > > > [6] http://154.223.142.244/20220418/0001-RCU.patch
> > > > > > Here is a sneak preview of a lightly tested alleged fix, which may be
> > > > > > found on the -rcu tree's "dev" branch:
> > > > > >
> > > > > > a3b1f9e07d47 rcu-tasks: Split rcu_tasks_one_gp() from rcu_tasks_kthread()
> > > > > > 130dd60ddd96 rcu-tasks: Move synchronize_rcu_tasks_generic() down
> > > > > > 7e510e661ea5 rcu-tasks: Drive synchronous grace periods from calling task
> > > > > >
> > > > > > Note that these are in the order that they should be applied rather than
> > > > > > in git-log order.
> > > > > I have been testing the above patches these days, on my Dell Poweredge
> > > > > R720, the bug seems to be gone. But on my Thinkpad P1 gen4, the bug
> > > > > seems to be there still.  Sorry to report that bad news.
> > > >
> > > > Hey, there is some improvement, so that counts as good news!  Besides,
> > > > it is what it is.  So thank you for testing and for letting me know both
> > > > the good and the not-quite-so-good news.  ;-)
> > > Yes, there is improvement, without your patch, the guest OS in my Dell
> > > R720 server will certainly issue the warnings at the first boot, with
> > > your patch, the guest OS booted a thousand times without warning ;-) I
> > > am very glad to be of some help ;-) You are very welcome, and thank
> > > Paul for your encouragement !
> > > >
> > > > > I will study your patches carefully and double check my test
> > > > > environment in the coming days.
> > > >
> > > > Could you please trace the series of calls to these functions up to
> > > > the faiure?
> > > >
> > > >         synchronize_rcu_tasks()
> > > >         call_rcu_tasks()
> > > >         synchronize_rcu_tasks_rude()
> > > >         call_rcu_tasks_rude()
> > > >         synchronize_rcu_tasks_trace()
> > > >         call_rcu_tasks_trace()
> > > >         synchronize_rcu_tasks_generic()
> > > >         rcu_tasks_one_gp()
> > I added printk statement at the beginning of these functions, and
> > print the holdout tasks in rcu_tasks_verify_self_tests, and print the
> > backtrace of rcu task kthread at moment of fail:
> > http://154.220.3.115/May022022/hook.diff
> >
> > Then I run kvm test on my Thinkpad P1 gen 4 (Intel i7-11800H):
> > http://154.220.3.115/May022022/console.log
> >
> > >From above log, I see
> > [    0.439296]  <TASK>
> > [    0.439420]  __schedule+0x246/0x7b0
> > [    0.439625]  ? mark_held_locks+0x49/0x70
> > [    0.439852]  schedule+0x53/0xc0
> > [    0.440035]  schedule_timeout+0x1a5/0x310
> > [    0.440268]  ? internal_add_timer+0x30/0x30
> > [    0.440516]  rcu_tasks_wait_gp+0x22e/0x340
> > [    0.440896]  rcu_tasks_one_gp+0x336/0x3b6
> > [    0.441209]  ? rcu_tasks_postscan+0x10/0x10
> > [    0.441447]  rcu_tasks_kthread.cold+0xa/0x18
> > [    0.441699]  kthread+0xe0/0x110
> > [    0.441883]  ? kthread_exit+0x30/0x30
> > [    0.442098]  ret_from_fork+0x1f/0x30
> > [    0.442307]  </TASK>
> >
> > So, it is rcu task kthread's sleeping (schedule_timeout_idle(fract))
> > that prevents the holdout tasks being harvested.
>
> Nice!
>
> So the machine hitting this was doing so because it was booting too
> fast.  ;-)
Yes, the fewer kernel options, the faster the kernel boots ;-)
>
> > Then I tried to reduce value of rtp->init_fract before
> > rcu_tasks_verify_self_tests and recover the original value after
> > rcu_tasks_verify_self_tests:
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index bd9f2e24f5c7..29c4a4a8fb51 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -963,7 +963,11 @@ static int __init rcu_spawn_tasks_kthread(void)
> >  {
> >         cblist_init_generic(&rcu_tasks);
> >         rcu_tasks.gp_sleep = HZ / 10;
> > +#ifdef CONFIG_PROVE_RCU
> > +       rcu_tasks.init_fract = HZ / 100;
> > +#else
> >         rcu_tasks.init_fract = HZ / 10;
> > +#endif
>
> You could save a few lines as follows:
>
>         rcu_tasks.init_fract = HZ / (IS_ENABLED(CONFIG_PROVE_RCU) ? 100 : 10)
thank you for your guidance ;-)
>
> >         rcu_tasks.pregp_func = rcu_tasks_pregp_step;
> >         rcu_tasks.pertask_func = rcu_tasks_pertask;
> >         rcu_tasks.postscan_func = rcu_tasks_postscan;
> > @@ -1777,6 +1781,7 @@ static int rcu_tasks_verify_self_tests(void)
> >         if (ret)
> >                 WARN_ON(1);
> >
> > +       rcu_tasks.init_fract = HZ / 10;
>
> Another way of handling this would be to leave rcu_spawn_tasks_kthread()
> alone and add this to the top of rcu_tasks_verify_self_tests():
>
>         if (IS_ENABLED(CONFIG_PROVE_RCU))
>                 schedule_timeout_uninterruptible(2 * rcu_tasks.init_fract);
>
> Then you would not need this assignment to rcu_tasks.init_fract.
I will also take this into consideration, I am a little worried about
slowing down the kernel boot process here ;-), I will perform the
tests.
>
> But you would also need something to handle the case of kernels built
> with CONFIG_TASKS_RCU=n.  For example and accessor function that
> returned the value of rcu_tasks.init_fract when CONFIG_TASKS_RCU=y and
> zero otherwise.  (And add this to the "if" condition if a zero argument
> to the schedule_timeout_uninterruptible() function still sleeps.)
I will also take this into consideration.
>
> Or am I missing something in your diagnosis of this problem?
You perceive my diagnosis clearly and accurately.
>
> >         return ret;
> >  }
> >  late_initcall(rcu_tasks_verify_self_tests);
> >
> > After patching above, the warning didn't reappear when booting the
> > kernel for 1000 times on my Thinkpad P1 gen4 (without the patch, the
> > warning will show at the first boot).
> >
> > Do my above discovery worth of a formal patch ;-) because I am afraid
> > adding above operations may slow the kernel boot process a little bit
> > (I have not tested the exact slowdown, just a guess). Also, did my
> > modification also apply to rcu_tasks_rude and rcu_tasks_trace? (I am
> > going to study rcu_tasks_rude and rcu_tasks_trace in the following
> > days ;-))
>
> We do need a fix here because we don't want to punish people who make
> Linux boot faster.  ;-)
>
> The trick is making the fix operate correctly in all Kconfig combinations
> and also making sure that it does not slow down boot unnecessarily.
Thank Paul for your encouragement! I will design the fix thoughtfully,
and perform the tests when designing. Please give me about  two weeks
to try to accomplish the above.

Thanks a lot
Cheers
Zhouyi
>
>                                                         Thanx, Paul
>
> > Thanks a lot
> > Cheers
> > Zhouyi
> > > I will do it! This itself is such a valuable process of learning and
> > > self promoting which I can't obtain anywhere else by any means to be
> > > honest.
> > > >
> > > > One possibility is that the RCU tasks GP kthreads are not getting
> > > > scheduled during that time on your Thinkpad.  If so, something
> > > > like schedule_timeout_uninterruptible(1) at the beginning of
> > > > rcu_tasks_verify_self_tests() should avoid the failure.  (Not a proper
> > > > fix, of course!  Just for testing.)
> > > I will do the tests in the coming days.
> > > >
> > > > > I add Uladzislau, author of bfba7ed084f8a  rcu-tasks: Add RCU-tasks
> > > > > self tests to cc list.
> > > >
> > > > Thank you!
> > > >
> > > > Huh.  With my patch, it should be possible to move the
> > > > invocation of rcu_tasks_initiate_self_tests() to the beginning of
> > > > rcu_init_tasks_generic().
> > > I will also try that.
> > >
> > > Thank you for your patience!
> > >
> > > Thanks again
> > > Zhouyi
> > > >
> > > >                                                         Thanx, Paul
> > > >
> > > > > Kind Regards
> > > > > Sincerely yours
> > > > > Zhouyi
> > > > > >
> > > > > >                                                         Thanx, Paul
