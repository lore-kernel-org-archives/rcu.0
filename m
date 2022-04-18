Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B549AC433EF
	for <rcu@archiver.kernel.org>; Mon, 18 Apr 2022 03:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbiDRDTI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 17 Apr 2022 23:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiDRDTH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 17 Apr 2022 23:19:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A381658A
        for <rcu@vger.kernel.org>; Sun, 17 Apr 2022 20:16:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r13so24780091ejd.5
        for <rcu@vger.kernel.org>; Sun, 17 Apr 2022 20:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=8+qcsfD4ysR4HJWgofYAlCbX2uyBroLibRgFiYJQaEM=;
        b=EehvbAavnrXM5hw195/e8EheyNfmswcdqa+txan8eiBPRSV0LCddDXW+KFgQNfJKnq
         OlRkoG4uqlVxK6QLP24CafiwW4MzFZRinqVWm+pC1Dt4OVIgqSvmVpZWQd++5A/WC9Wv
         GURodb3F9O3k42jzB5M618CYZ8MIahu5oNEPH3SmnVzNc75Fy2hhlGth5oioQ5/M9+jP
         Na9BUuQeaMOaLdxgEv+4qJhylDTQvWODyGOB/74f01/DYZpu9BN0NzY8AUT8o6yJ7AUK
         AO2BySrbnjmxMiht0RQXJJr3M0F5qye2PtQPIRXxi6KgitWoRV5aezru4YvF4UllJFZO
         eLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8+qcsfD4ysR4HJWgofYAlCbX2uyBroLibRgFiYJQaEM=;
        b=aLiS0YZO0B/3bfoAg2/sd23r5FIAQaQAALeRstF+rHqI8Pa/MANoMW+UwDH8+7HFWQ
         UC10iN1+s/pLR3hnBeA+0Z23h3rZsyzd9di+USrDLQQl6a+k1coCohXrTA0NZbbOOmbF
         iNjiOoFJDK3e6oTqlq7N+BW5JHVICF8CY6KDT/3U8wPSHFDp5uwitHTLV01n71FUQbzx
         /L0WrIZeNh5riJEHoe60G4r3iIkeOsO623s4RkgReHUhZyKXZbp4vO6dGWklPL4nj1PT
         4DOQ8atWClK+4vX9QoL4VlQJadEm/0DL3Onfs10lOGplZJhyp55MvxhhCaBSFIbmk4Yi
         h+Qw==
X-Gm-Message-State: AOAM533F1b6B6VwkLGfBN7dT96l5WP5LZqJv64+bF14AqSIThgQnWUpT
        NVE0sKs+kjeBVePVlQjAHFn5Lt03cSoE4notSLgATFddfdQ=
X-Google-Smtp-Source: ABdhPJzXwHhjs8rpwT99iTSfbwtOKR/hv6UE8sqZi64QDI2N/QPV87a+pSboyw9WcIuY9GPScApThoHofYqo2VaNfeQ=
X-Received: by 2002:a17:907:2cc3:b0:6e6:45fb:39fa with SMTP id
 hg3-20020a1709072cc300b006e645fb39famr7266004ejc.545.1650251787586; Sun, 17
 Apr 2022 20:16:27 -0700 (PDT)
MIME-Version: 1.0
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Mon, 18 Apr 2022 11:16:16 +0800
Message-ID: <CAABZP2xEtRnbRMGgywc2RSwiOAd1QY5jr0ZxwXd9p_8XwOiqhw@mail.gmail.com>
Subject: Reproducing call_rcu_tasks self-test bug on a dual sockets Intel Xeon machine
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Paul McKenney <paulmckrcu@fb.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

1. Abstract
Previously, Matthew has reported a call_rcu_tasks bug [1]. But it is
hard to reproduce on a dual socket Intel machine. This report
developed a method to reproduce that bug on such a machine.

2. Introduction
Matthew has reported a call_rcu_tasks bug [1]. It is easy to reproduce
it on Thinkpad P1 gen4 (Intel i7-11800H) with following steps:
a) cp [2] to .config
b) build the kernel
c) execute  kvm -smp 4 -net none -serial file:/tmp/console.log -m 512
-kernel vmlinux -append "console=ttyS0"

The bug can even be reproduced on Thinkpad P1 gen4 (i7-11800H) by
stress testing the TASKS01 with the script [3].

However, the bug can't be reproduced by above methods on a dual socket
Intel Xeon machine (PowerEdge R720, Intel(R) Xeon(R) CPU E5-2660 0 @
2.20GHz, 2 CPUs, 16 cores, 32 threads).

3. Discover the reason behind the bug
On thinkpad P1 gen4, I tried to discover the reason behind the bug.
After some experimentation, I found that removing CONFIG_NFS_V4 from
the kernel config file will greatly increase the probabilities of
triggering the bug.

I guess maybe the init calls lend the grace period to RCU tasks self
tests, so I add some debug code to a test kernel to see what happens:
root@e0816662e3db:/mnt/linux# git diff
diff --git a/init/main.c b/init/main.c
index 98182c3c2c4b..9731566014cc 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1356,6 +1356,8 @@ static int __init ignore_unknown_bootoption(char
*param, char *val,
        return 0;
 }

+extern bool *notrunp;
+unsigned int numofcalls = 0;
 static void __init do_initcall_level(int level, char *command_line)
 {
        initcall_entry_t *fn;
@@ -1367,8 +1369,19 @@ static void __init do_initcall_level(int level,
char *command_line)
                   NULL, ignore_unknown_bootoption);

        trace_initcall_level(initcall_level_names[level]);
-       for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
+       for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++) {
+               bool before = *notrunp, after;
+               unsigned long jiffies_save = jiffies;
+               numofcalls++;
                do_one_initcall(initcall_from_entry(fn));
+               after = *notrunp;
+               if (before != after) {
+                 char sym[KSYM_SYMBOL_LEN];
+                 sprint_symbol(sym, (unsigned long )initcall_from_entry(fn));
+                 printk(KERN_INFO "init call level %d: %s changed the
rcu task test %lu\n",
+                        level, sym, jiffies - jiffies_save);
+               }
+       }
 }

 static void __init do_initcalls(void)
@@ -1376,15 +1389,17 @@ static void __init do_initcalls(void)
        int level;
        size_t len = strlen(saved_command_line) + 1;
        char *command_line;
-
+       unsigned long jiffies_save = jiffies;
        command_line = kzalloc(len, GFP_KERNEL);
        if (!command_line)
                panic("%s: Failed to allocate %zu bytes\n", __func__, len);
-
+
        for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++) {
                /* Parser modifies command_line, restore it each time */
                strcpy(command_line, saved_command_line);
                do_initcall_level(level, command_line);
+               if (level == 5)
+                 printk(KERN_INFO"init call level 5 costs: %lu
numofcalls %u\n", jiffies - jiffies_save, numofcalls);
        }

        kfree(command_line);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 99cf3a13954c..f4e175eeaec3 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1660,7 +1660,7 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)

        rttd->notrun = true;
 }
-
+bool *notrunp = &tests[0].notrun;
 static void rcu_tasks_initiate_self_tests(void)
 {
        pr_info("Running RCU-tasks wait API self tests\n");

The tests on Thinkpad P1 gen4 and Dell PowerEdge R720 show that during
the test, some init call will lend the grace period to the RCU tasks
self tests.

And of course, I am not using the above modification in Section 5 and
Section 6' tests. Section 5 and Section 6's tests are performed on
unmodified mainline!!

4. Reduce the init calls in kernel configuration
Based on above observation, I tried to reduce the kernel configuration
starting from [2] meanwhile keep the qemu bootable. Finally I got
[4].
And [4] will trigger the bug on Dell PowerEdge R720!

5. Trigger the bug in a more Linux way.
Why TASKS01 will not trigger the bug? There are two reasons:
a) there are too many init calls that will lend the grace period
b) the debug kernel param will lend the grace period

Solution to reason a:
I write a C++ program [5] to print the difference between the .config
generated by TASKS01 and [4]. Then I use the difference to create a
TASKS04.

Solution to reason b:
I add loglevel=7 to qemu boot parameter.

The result consists of newly created TASKS04 and TASKS04.boot [6].

Now the bug can trigger every time on Dell PowerEdge R720 by invoking:
./tools/testing/selftests/rcutorture/bin/kvm.sh --configs "TASKS04"
--duration 10 --trust-make

6. Conclusion
I am able to trigger the bug everytime in mainline without modifying
the kernel's functional code on a dual socket Intel Xeon machine.

7. Acknowledgement
Thanks Paul for your constant encouragement! Thanks Zhouyi

References
[1] https://lore.kernel.org/rcu/20220322142101.GQ4285@paulmck-ThinkPad-P17-Gen-1/T/#mb696465963393bbc3d38e85ffef0e03cf1e4fa54
[2] http://154.223.142.244/20220321/config-20220321
[3] http://154.223.142.244/20220418/test.sh.txt
[4] http://154.223.142.244/20220418/config
[5] http://154.223.142.244/20220418/processconfig.cpp
[6] http://154.223.142.244/20220418/0001-RCU.patch
