Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBCBC433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 232A420842
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872715;
	bh=GRjF+ui7licP16JVWVDuHWFASeod5+Q3UxEqtDcPL1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X6aOa7fv/TnvQPbnogPvuMbe9H8OYNo0d9Hhu7eZ75acZG7/b73TnODgVCgiCBBNU
	 mdzwTWT3xp4oAh3SH2Lz4vS8MTs0jpMIjJSoMPuKvVX9YiobV/pgLHboldsf3O7Bp+
	 N+ok5Ou/i02c6Es2YEa2P7EtSZ2TgzXhp4XuLklc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732212AbgFWAiV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732166AbgFWAh6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:58 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F16A3217D8;
        Tue, 23 Jun 2020 00:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872678;
        bh=GRjF+ui7licP16JVWVDuHWFASeod5+Q3UxEqtDcPL1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=spwPyFIFACVTemimuert8MoHvYczv2ftNX7/dP7VVTM3B6KvfV2PtP4QZ4Br4/Zwr
         CAMYrw2rhBQgiMbO8KXzzarZJ0MtMbltwfgfGYRYNCl4LUFAz3iyQ6Wrt4+U/dO66w
         o4VGJk7GSwg+Pgcbeo0uK0Ky0wGQKyu/MGcYaMWY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 20/23] torture: Dump ftrace at shutdown only if requested
Date:   Mon, 22 Jun 2020 17:37:49 -0700
Message-Id: <20200623003752.26872-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

If there is a large number of torture tests running concurrently,
all of which are dumping large ftrace buffers at shutdown time, the
resulting dumping can take a very long time, particularly on systems
with rotating-rust storage.  This commit therefore adds a default-off
torture.ftrace_dump_at_shutdown module parameter that enables
shutdown-time ftrace-buffer dumping.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 kernel/torture.c                                | 6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a0dcc92..9f11ff8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5096,6 +5096,13 @@
 			Prevent the CPU-hotplug component of torturing
 			until after init has spawned.
 
+	torture.ftrace_dump_at_shutdown= [KNL]
+			Dump the ftrace buffer at torture-test shutdown,
+			even if there were no errors.  This can be a
+			very costly operation when many torture tests
+			are running concurrently, especially on systems
+			with rotating-rust storage.
+
 	tp720=		[HW,PS2]
 
 	tpm_suspend_pcr=[HW,TPM]
diff --git a/kernel/torture.c b/kernel/torture.c
index a1a4148..1061492 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -45,6 +45,9 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 static bool disable_onoff_at_boot;
 module_param(disable_onoff_at_boot, bool, 0444);
 
+static bool ftrace_dump_at_shutdown;
+module_param(ftrace_dump_at_shutdown, bool, 0444);
+
 static char *torture_type;
 static int verbose;
 
@@ -527,7 +530,8 @@ static int torture_shutdown(void *arg)
 		torture_shutdown_hook();
 	else
 		VERBOSE_TOROUT_STRING("No torture_shutdown_hook(), skipping.");
-	rcu_ftrace_dump(DUMP_ALL);
+	if (ftrace_dump_at_shutdown)
+		rcu_ftrace_dump(DUMP_ALL);
 	kernel_power_off();	/* Shut down the system. */
 	return 0;
 }
-- 
2.9.5

