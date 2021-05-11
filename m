Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87867C43618
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66C4E6192F
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhEKWyX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230338AbhEKWyP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 582236194D;
        Tue, 11 May 2021 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773587;
        bh=KKDkezvfsvDBcdHebQoHjhjJnMglnYNTHv+gz9t1HBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wv5J72k9xCDolJsIJoZ+aeuYiSqTTOeKIhECnyRex1vgQD5y/3AKdg2fZnv4X2LI7
         FwH1eZZs19Nzl/oPoVFcvYrEV1ioTFcnChYFXqZ9Dks2RTBDS3wz0EWDSH2Igc1KLj
         N2+v5hIjRPffpT+GHr6pQTw/JgN78vQTtx41QOr40+PsoJI0CSAisxp20ps3s73UoQ
         s5Gwr5t6ZP2l5xLr2HhNebW1TMtLhO43k8rWw6waflWsciyw+UyXPFqi8OQk93s6xR
         Qq2grU5mZc65jEAEoMFT4l6t37r8bSt+dRhxsY+7YTkjR0dM3uOyfmrHS3zHSfYxdm
         eSvMSHwrJ0qcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A3EEC5C0E3F; Tue, 11 May 2021 15:53:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH tip/core/rcu 16/19] sched/isolation: reconcile rcu_nocbs= and nohz_full=
Date:   Tue, 11 May 2021 15:53:01 -0700
Message-Id: <20210511225304.2893154-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

We have a mismatch between RCU and isolation -- in relation to what is
considered the maximum valid CPU number.

This matters because nohz_full= and rcu_nocbs= are joined at the hip; in
fact the former will enforce the latter.  So we don't want a CPU mask to
be valid for one and denied for the other.

The difference 1st appeared as of v4.15; further details are below.

As it is confusing to anyone who isn't looking at the code regularly, a
reminder is in order; three values exist here:

CONFIG_NR_CPUS	- compiled in maximum cap on number of CPUs supported.
nr_cpu_ids 	- possible # of CPUs (typically reflects what ACPI says)
cpus_present	- actual number of present/detected/installed CPUs.

For this example, I'll refer to NR_CPUS=64 from "make defconfig" and
nr_cpu_ids=6 for ACPI reporting on a board that could run a six core,
and present=4 for a quad that is physically in the socket.  From dmesg:

 smpboot: Allowing 6 CPUs, 2 hotplug CPUs
 setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:6 nr_node_ids:1
 rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=6.
 smp: Brought up 1 node, 4 CPUs

And from userspace, see:

   paul@trash:/sys/devices/system/cpu$ cat present
   0-3
   paul@trash:/sys/devices/system/cpu$ cat possible
   0-5
   paul@trash:/sys/devices/system/cpu$ cat kernel_max
   63

Everything is fine if we boot 5x5 for rcu/nohz:

  Command line: BOOT_IMAGE=/boot/bzImage nohz_full=2-5 rcu_nocbs=2-5 root=/dev/sda1 ro
  NO_HZ: Full dynticks CPUs: 2-5.
  rcu: 	Offload RCU callbacks from CPUs: 2-5.

..even though there is no CPU 4 or 5.  Both RCU and nohz_full are OK.
Now we push that > 6 but less than NR_CPU and with 15x15 we get:

  Command line: BOOT_IMAGE=/boot/bzImage rcu_nocbs=2-15 nohz_full=2-15 root=/dev/sda1 ro
  rcu: 	Note: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.
  rcu: 	Offload RCU callbacks from CPUs: 2-5.

These are both functionally equivalent, as we are only changing flags on
phantom CPUs that don't exist, but note the kernel interpretation changes.
And worse, it only changes for one of the two - which is the problem.

RCU doesn't care if you want to restrict the flags on phantom CPUs but
clearly nohz_full does after this change from v4.15 (edb9382175c3):

-       if (cpulist_parse(str, non_housekeeping_mask) < 0) {
-               pr_warn("Housekeeping: Incorrect nohz_full cpumask\n");
+       err = cpulist_parse(str, non_housekeeping_mask);
+       if (err < 0 || cpumask_last(non_housekeeping_mask) >= nr_cpu_ids) {
+               pr_warn("Housekeeping: nohz_full= or isolcpus= incorrect CPU range\n");

To be clear, the sanity check on "possible" (nr_cpu_ids) is new here.

The goal was reasonable ; not wanting housekeeping to land on a
not-possible CPU, but note two things:

1) this is an exclusion list, not an inclusion list; we are tracking
non_housekeeping CPUs; not ones who are explicitly assigned housekeeping

2) we went one further in 9219565aa890 - ensuring that housekeeping was
sanity checking against present and not just possible CPUs.

To be clear, this means the check added in v4.15 is doubly redundant.
And more importantly, overly strict/restrictive.

We care now, because the bitmap boot arg parsing now knows that a value
of "N" is NR_CPUS; the size of the bitmap, but the bitmap code doesn't
know anything about the subtleties of our max/possible/present CPU
specifics as outlined above.

So drop the check added in v4.15 (edb9382175c3) and make RCU and
nohz_full both in alignment again on NR_CPUS so "N" works for both,
and then they can fall back to nr_cpu_ids internally just as before.

  Command line: BOOT_IMAGE=/boot/bzImage nohz_full=2-N rcu_nocbs=2-N root=/dev/sda1 ro
  NO_HZ: Full dynticks CPUs: 2-5.
  rcu: 	Offload RCU callbacks from CPUs: 2-5.

As shown above, with this change, RCU and nohz_full are in sync, even
with the use of the "N" placeholder.  Same result is achieved with "15".

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/sched/isolation.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5a6ea03f9882..7f06eaf12818 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -81,11 +81,9 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 {
 	cpumask_var_t non_housekeeping_mask;
 	cpumask_var_t tmp;
-	int err;
 
 	alloc_bootmem_cpumask_var(&non_housekeeping_mask);
-	err = cpulist_parse(str, non_housekeeping_mask);
-	if (err < 0 || cpumask_last(non_housekeeping_mask) >= nr_cpu_ids) {
+	if (cpulist_parse(str, non_housekeeping_mask) < 0) {
 		pr_warn("Housekeeping: nohz_full= or isolcpus= incorrect CPU range\n");
 		free_bootmem_cpumask_var(non_housekeeping_mask);
 		return 0;
-- 
2.31.1.189.g2e36527f23

