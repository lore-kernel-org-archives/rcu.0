Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035C6C433E6
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D952F2083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897661;
	bh=r/8SPHtuKRq25wvGCK/MlfZRSs6CbFZHnXBwdHIQk5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GsFQngFORAhSfHHIVPFE3w6p9Z9+fBrF3owwjMmcTZisLHvmsmPZibHNdplwlxQod
	 XIwhHIMzPHNmwru1L8HKbbt+T6moX6MceQrX6mLMXkg0IclNqifBzvUuIW7Z5K4EvE
	 EFdNFRhddlorqgjW2z3HkaopcIuK4Y1pVv4hqZKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgHaSOU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:14:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728913AbgHaSOT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:14:19 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 975B12068E;
        Mon, 31 Aug 2020 18:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897658;
        bh=r/8SPHtuKRq25wvGCK/MlfZRSs6CbFZHnXBwdHIQk5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iEhSQyQ0+u739e0EKZzwzXHS0g8FM5t5npiEotmSBaAEHqSKtS2QhV8LGabUUpiQW
         j+eKYM9XKl8EBabR89IOwvIqTMcWFQK04tfCDEHFtBFeYl7jj4wZktl0+b4KE4TW7a
         CRXDmYzjCzw3PFH0Ltj6FP16h1pHSqqcY1QWyLso=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org
Subject: [PATCH tip/core/rcu 1/4] lib: Add backtrace_idle parameter to force backtrace of idle CPUs
Date:   Mon, 31 Aug 2020 11:14:14 -0700
Message-Id: <20200831181417.1378-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181356.GA1224@paulmck-ThinkPad-P72>
References: <20200831181356.GA1224@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, the nmi_cpu_backtrace() declines to produce backtraces for
idle CPUs.  This is a good choice in the common case in which problems are
caused only by non-idle CPUs.  However, there are occasionally situations
in which idle CPUs are helping to cause problems.  This commit therefore
adds an nmi_backtrace.backtrace_idle kernel boot parameter that causes
nmi_cpu_backtrace() to dump stacks even of idle CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <linux-doc@vger.kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 lib/nmi_backtrace.c                             | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdc1f33..5e6d191 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3073,6 +3073,10 @@
 			and gids from such clients.  This is intended to ease
 			migration from NFSv2/v3.
 
+	nmi_backtrace.backtrace_idle [KNL]
+			Dump stacks even of idle CPUs in response to an
+			NMI stack-backtrace request.
+
 	nmi_debug=	[KNL,SH] Specify one or more actions to take
 			when a NMI is triggered.
 			Format: [state][,regs][,debounce][,die]
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 15ca78e..8abe187 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -85,12 +85,16 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 	put_cpu();
 }
 
+// Dump stacks even for idle CPUs.
+static bool backtrace_idle;
+module_param(backtrace_idle, bool, 0644);
+
 bool nmi_cpu_backtrace(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
 
 	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
-		if (regs && cpu_in_idle(instruction_pointer(regs))) {
+		if (!READ_ONCE(backtrace_idle) && regs && cpu_in_idle(instruction_pointer(regs))) {
 			pr_warn("NMI backtrace for cpu %d skipped: idling at %pS\n",
 				cpu, (void *)instruction_pointer(regs));
 		} else {
-- 
2.9.5

