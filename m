Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D3DC4332F
	for <rcu@archiver.kernel.org>; Fri, 22 Apr 2022 05:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiDVFjk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 22 Apr 2022 01:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiDVFb5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 22 Apr 2022 01:31:57 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158774F445
        for <rcu@vger.kernel.org>; Thu, 21 Apr 2022 22:29:04 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bv19so14149341ejb.6
        for <rcu@vger.kernel.org>; Thu, 21 Apr 2022 22:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LJU91aAO6DcnjOhMocYLVvA3BoTLbDI3DX/RSA3MhfM=;
        b=pkggemth+evpdu1RQAxT1trOBD7Z7zrNwLUM/Nz1bpAAINFOiTKIAnth0VCBgTaa9H
         0HMzov4W2naH+Y8dVSLhcGEVGSZmp8rEzL+pD1W7zTVdZouS5g1HU1d69hjnZoXIvlTW
         dM2GwXR9OcLDPM4iWrVJXiLjJ5N3yLYM8vc9iZ7Av1jHAt0BzVJL5w/e7AK+bf1U+1cu
         TBfQ4X1gXAAlBEC2uTieznSJxELWhrguaAZILI7P8qhEBxNY2oA7NSlNnnKwkJuAR864
         NLuPSo9FauOqwrMTgvog53Nj4Mk0PmVDMlywsF3bCnlr/T3aIpn2/tQbNxzOXzwKa4GM
         aziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LJU91aAO6DcnjOhMocYLVvA3BoTLbDI3DX/RSA3MhfM=;
        b=RNpZSrzQieUimiwzt5N/LSXDpX6s571CUpTh0hdG/6t8/Pjvl1KYjrGecxLLRptNIh
         UuTzR6sQdI3oaEwjvzL8vAkKx2cgQVxZSqxLYb30GbuH14LHpq6EtoYaG1Fu7TeHPkJW
         T5Q/35LxjfYHFp5X6lMXZOEhXgibbOVn4ww1F/CFunJau1LsaSrUIHv5fHUgi757Pn8F
         m5gdmCFP/pW0iqLO7dyxjOx1zcxzgQrbadEWUpTA4FUmd1KuExS647CHZqkaZQfDtsE3
         XIlNB+TcnVWBCayNz8r0idAa6GkmQS0vFgbSTzuYtj83JSRUX14oPeU5urxmhCPvEDej
         9CpA==
X-Gm-Message-State: AOAM5338GPcHZuzEJ36zgEFUUSIWAdK0LvGhABdB5BL8zXV2z025QAGy
        arJ7cjepRxxkI3dF3vKiWLxihiv/WunhOHL1vCE=
X-Google-Smtp-Source: ABdhPJzfbMNvqS9dg/SRNB6bx/VicILOuw9kmEDzDk32+iO3L2grgNGXbDfiazMOOLAeBAdea7NP1EYDydGTfqg2nDw=
X-Received: by 2002:a17:906:c1c1:b0:6ef:7bd7:a508 with SMTP id
 bw1-20020a170906c1c100b006ef7bd7a508mr2533770ejb.614.1650605342524; Thu, 21
 Apr 2022 22:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2xEtRnbRMGgywc2RSwiOAd1QY5jr0ZxwXd9p_8XwOiqhw@mail.gmail.com>
 <20220419230412.GU4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220419230412.GU4285@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Fri, 22 Apr 2022 13:28:51 +0800
Message-ID: <CAABZP2zBdDxmiFzwB+rg8fzfYHhteAmkRvaYMAXzQ_B12EF16w@mail.gmail.com>
Subject: Re: Reproducing call_rcu_tasks self-test bug on a dual sockets Intel
 Xeon machine
To:     "Paul E. McKenney" <paulmck@kernel.org>, urezki@gmail.com
Cc:     Paul McKenney <paulmckrcu@fb.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul

On Wed, Apr 20, 2022 at 7:04 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Apr 18, 2022 at 11:16:16AM +0800, Zhouyi Zhou wrote:
> > 1. Abstract
> > Previously, Matthew has reported a call_rcu_tasks bug [1]. But it is
> > hard to reproduce on a dual socket Intel machine. This report
> > developed a method to reproduce that bug on such a machine.
> >
> > 2. Introduction
> > Matthew has reported a call_rcu_tasks bug [1]. It is easy to reproduce
> > it on Thinkpad P1 gen4 (Intel i7-11800H) with following steps:
> > a) cp [2] to .config
> > b) build the kernel
> > c) execute  kvm -smp 4 -net none -serial file:/tmp/console.log -m 512
> > -kernel vmlinux -append "console=ttyS0"
> >
> > The bug can even be reproduced on Thinkpad P1 gen4 (i7-11800H) by
> > stress testing the TASKS01 with the script [3].
> >
> > However, the bug can't be reproduced by above methods on a dual socket
> > Intel Xeon machine (PowerEdge R720, Intel(R) Xeon(R) CPU E5-2660 0 @
> > 2.20GHz, 2 CPUs, 16 cores, 32 threads).
> >
> > 3. Discover the reason behind the bug
> > On thinkpad P1 gen4, I tried to discover the reason behind the bug.
> > After some experimentation, I found that removing CONFIG_NFS_V4 from
> > the kernel config file will greatly increase the probabilities of
> > triggering the bug.
> >
> > I guess maybe the init calls lend the grace period to RCU tasks self
> > tests, so I add some debug code to a test kernel to see what happens:
> > root@e0816662e3db:/mnt/linux# git diff
> > diff --git a/init/main.c b/init/main.c
> > index 98182c3c2c4b..9731566014cc 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -1356,6 +1356,8 @@ static int __init ignore_unknown_bootoption(char
> > *param, char *val,
> >         return 0;
> >  }
> >
> > +extern bool *notrunp;
> > +unsigned int numofcalls = 0;
> >  static void __init do_initcall_level(int level, char *command_line)
> >  {
> >         initcall_entry_t *fn;
> > @@ -1367,8 +1369,19 @@ static void __init do_initcall_level(int level,
> > char *command_line)
> >                    NULL, ignore_unknown_bootoption);
> >
> >         trace_initcall_level(initcall_level_names[level]);
> > -       for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
> > +       for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++) {
> > +               bool before = *notrunp, after;
> > +               unsigned long jiffies_save = jiffies;
> > +               numofcalls++;
> >                 do_one_initcall(initcall_from_entry(fn));
> > +               after = *notrunp;
> > +               if (before != after) {
> > +                 char sym[KSYM_SYMBOL_LEN];
> > +                 sprint_symbol(sym, (unsigned long )initcall_from_entry(fn));
> > +                 printk(KERN_INFO "init call level %d: %s changed the
> > rcu task test %lu\n",
> > +                        level, sym, jiffies - jiffies_save);
> > +               }
> > +       }
> >  }
> >
> >  static void __init do_initcalls(void)
> > @@ -1376,15 +1389,17 @@ static void __init do_initcalls(void)
> >         int level;
> >         size_t len = strlen(saved_command_line) + 1;
> >         char *command_line;
> > -
> > +       unsigned long jiffies_save = jiffies;
> >         command_line = kzalloc(len, GFP_KERNEL);
> >         if (!command_line)
> >                 panic("%s: Failed to allocate %zu bytes\n", __func__, len);
> > -
> > +
> >         for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++) {
> >                 /* Parser modifies command_line, restore it each time */
> >                 strcpy(command_line, saved_command_line);
> >                 do_initcall_level(level, command_line);
> > +               if (level == 5)
> > +                 printk(KERN_INFO"init call level 5 costs: %lu
> > numofcalls %u\n", jiffies - jiffies_save, numofcalls);
> >         }
> >
> >         kfree(command_line);
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 99cf3a13954c..f4e175eeaec3 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -1660,7 +1660,7 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
> >
> >         rttd->notrun = true;
> >  }
> > -
> > +bool *notrunp = &tests[0].notrun;
> >  static void rcu_tasks_initiate_self_tests(void)
> >  {
> >         pr_info("Running RCU-tasks wait API self tests\n");
> >
> > The tests on Thinkpad P1 gen4 and Dell PowerEdge R720 show that during
> > the test, some init call will lend the grace period to the RCU tasks
> > self tests.
> >
> > And of course, I am not using the above modification in Section 5 and
> > Section 6' tests. Section 5 and Section 6's tests are performed on
> > unmodified mainline!!
> >
> > 4. Reduce the init calls in kernel configuration
> > Based on above observation, I tried to reduce the kernel configuration
> > starting from [2] meanwhile keep the qemu bootable. Finally I got
> > [4].
> > And [4] will trigger the bug on Dell PowerEdge R720!
> >
> > 5. Trigger the bug in a more Linux way.
> > Why TASKS01 will not trigger the bug? There are two reasons:
> > a) there are too many init calls that will lend the grace period
> > b) the debug kernel param will lend the grace period
> >
> > Solution to reason a:
> > I write a C++ program [5] to print the difference between the .config
> > generated by TASKS01 and [4]. Then I use the difference to create a
> > TASKS04.
> >
> > Solution to reason b:
> > I add loglevel=7 to qemu boot parameter.
> >
> > The result consists of newly created TASKS04 and TASKS04.boot [6].
> >
> > Now the bug can trigger every time on Dell PowerEdge R720 by invoking:
> > ./tools/testing/selftests/rcutorture/bin/kvm.sh --configs "TASKS04"
> > --duration 10 --trust-make
> >
> > 6. Conclusion
> > I am able to trigger the bug everytime in mainline without modifying
> > the kernel's functional code on a dual socket Intel Xeon machine.
> >
> > 7. Acknowledgement
> > Thanks Paul for your constant encouragement! Thanks Zhouyi
>
> And thank you for digging into this!
You are very welcome ;-)
>
References
[1] https://lore.kernel.org/rcu/20220322142101.GQ4285@paulmck-ThinkPad-P17-Gen-1/T/#mb696465963393bbc3d38e85ffef0e03cf1e4fa54
[2] http://154.223.142.244/20220321/config-20220321
[3] http://154.223.142.244/20220418/test.sh.txt
[4] http://154.223.142.244/20220418/config
[5] http://154.223.142.244/20220418/processconfig.cpp
[6] http://154.223.142.244/20220418/0001-RCU.patch
> Here is a sneak preview of a lightly tested alleged fix, which may be
> found on the -rcu tree's "dev" branch:
>
> a3b1f9e07d47 rcu-tasks: Split rcu_tasks_one_gp() from rcu_tasks_kthread()
> 130dd60ddd96 rcu-tasks: Move synchronize_rcu_tasks_generic() down
> 7e510e661ea5 rcu-tasks: Drive synchronous grace periods from calling task
>
> Note that these are in the order that they should be applied rather than
> in git-log order.
I have been testing the above patches these days, on my Dell Poweredge
R720, the bug seems to be gone. But on my Thinkpad P1 gen4, the bug
seems to be there still.  Sorry to report that bad news.
I will study your patches carefully and double check my test
environment in the coming days.

I add Uladzislau, author of bfba7ed084f8a  rcu-tasks: Add RCU-tasks
self tests to cc list.

Kind Regards
Sincerely yours
Zhouyi
>
>                                                         Thanx, Paul
