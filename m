Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84861C35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543EF207FF
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581727293;
	bh=H9kwldvkk+c1yOe8wAMCrCGx8iN0YZw2sdHqzYKHQNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G6Lp3X7no1wur58vygicVIRNDBNKYCot87+QrsfVXptGpG2eTW9Bcjh6hb+pffN1j
	 RRoKfF7+yYEsrq3B1Ahv5slUqwNZnz+vFKGNLoJVEAerpwnE4pQRmBotZQB9rqFF82
	 mWDWYOr57vx0buxlqeKppgP/JV2ok3CvsOYMGkyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgBOAld (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgBOAlc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:41:32 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2A37206CC;
        Sat, 15 Feb 2020 00:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727292;
        bh=H9kwldvkk+c1yOe8wAMCrCGx8iN0YZw2sdHqzYKHQNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nsd//JuKevIk2EQil/l0VQBUmQ3UY2TZBlB/1dSAIKd+y06pKqlvEKzSThs8c6COZ
         rX6G4fIFOsExtTFmGfxpVvqdtDoHvIuRwfRJCCjTPudCPasMHEFRwhDL9k882LMZmB
         +iWnYFAsrm6YDuz5FQFryEwZOnq6OI1+RtDXIpU8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/18] torture: Allow disabling of boottime CPU-hotplug torture operations
Date:   Fri, 14 Feb 2020 16:41:14 -0800
Message-Id: <20200215004125.16953-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

In theory, RCU-hotplug operations are supposed to work as soon as there
is more than one CPU online.  However, in practice, in normal production
there is no way to make them happen until userspace is up and running.
Besides which, on smaller systems, rcutorture doesn't start doing hotplug
operations until 30 seconds after the start of boot, which on most
systems also means the better part of 30 seconds after the end of boot.
This commit therefore provides a new torture.disable_onoff_at_boot kernel
boot parameter that suppresses CPU-hotplug torture operations until
about the time that init is spawned.

Of course, if you know of a need for boottime CPU-hotplug operations,
then you should avoid passing this argument to any of the torture tests.
You might also want to look at the splats linked to below.

Link: https://lore.kernel.org/lkml/20191206185208.GA25636@paulmck-ThinkPad-P72/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 kernel/torture.c                                | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ee007b5..868f59a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4873,6 +4873,10 @@
 			topology updates sent by the hypervisor to this
 			LPAR.
 
+	torture.disable_onoff_at_boot= [KNL]
+			Prevent the CPU-hotplug component of torturing
+			until after init has spawned.
+
 	tp720=		[HW,PS2]
 
 	tpm_suspend_pcr=[HW,TPM]
diff --git a/kernel/torture.c b/kernel/torture.c
index e377b5b..8683375 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -42,6 +42,9 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 
+static bool disable_onoff_at_boot;
+module_param(disable_onoff_at_boot, bool, 0444);
+
 static char *torture_type;
 static int verbose;
 
@@ -229,6 +232,10 @@ torture_onoff(void *arg)
 		VERBOSE_TOROUT_STRING("torture_onoff end holdoff");
 	}
 	while (!torture_must_stop()) {
+		if (disable_onoff_at_boot && !rcu_inkernel_boot_has_ended()) {
+			schedule_timeout_interruptible(HZ / 10);
+			continue;
+		}
 		cpu = (torture_random(&rand) >> 4) % (maxcpu + 1);
 		if (!torture_offline(cpu,
 				     &n_offline_attempts, &n_offline_successes,
-- 
2.9.5

