Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1636C43460
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF056192B
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhEKWps (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229970AbhEKWpr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:45:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F7D96192A;
        Tue, 11 May 2021 22:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773080;
        bh=Dyyx978RzE0US4WnuMqJiKi2LRlG5caABC8FzHCPHis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EP5MyT1TwRQAZwPN13bAsl5ghAh+BWA4EclFitmU9T+I04+jKJ+2gxsYo/bc1Mvh2
         xWoDuuxvWl4jgIQ1ietv7O8NSyd5OLvDYM+2ur/W2nwcpQdt1A/6PriLPV71ovopHX
         P1Ssu2y5Yv0LztRpp46G0oDHczTDaKEZxtTu2nUvLArsXvtpg6l75PhYogaNEELswW
         +HQJQ5lcfAYl2Td/N9YpCiY5XELcniagaMnZodvBA9yN52Po7TH7CqOLb1hyrHwEk8
         L5ovWEsA/7LvAZ2pQf4LDP5kmTjgQ0HIsQgRX8jR+HTMDUf97A0ahKttFw11WPVGA1
         to3g9AtsxolHQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DC5FF5C09EF; Tue, 11 May 2021 15:44:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH tip/core/rcu 3/3] tools/rcu: Add drgn script to dump number of RCU callbacks
Date:   Tue, 11 May 2021 15:44:38 -0700
Message-Id: <20210511224438.2892442-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511224402.GA2892361@paulmck-ThinkPad-P17-Gen-1>
References: <20210511224402.GA2892361@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit adds an rcu-cbs.py drgn script that computes the number of
RCU callbacks waiting to be invoked.  This information can be helpful
when managing systems that are short of memory and that have software
components that make heavy use of RCU, for example, by opening and
closing files in tight loops.  (But please note that there are almost
always better ways to get your job done than by opening and closing
files in tight loops.)

Reported-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/rcu/rcu-cbs.py | 46 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 tools/rcu/rcu-cbs.py

diff --git a/tools/rcu/rcu-cbs.py b/tools/rcu/rcu-cbs.py
new file mode 100644
index 000000000000..f8b461b9eaa7
--- /dev/null
+++ b/tools/rcu/rcu-cbs.py
@@ -0,0 +1,46 @@
+#!/usr/bin/env drgn
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Dump out the number of RCU callbacks outstanding.
+#
+# On older kernels having multiple flavors of RCU, this dumps out the
+# number of callbacks for the most heavily used flavor.
+#
+# Usage: sudo drgn rcu-cbs.py
+#
+# Copyright (C) 2021 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+import sys
+import drgn
+from drgn import NULL, Object
+from drgn.helpers.linux import *
+
+def get_rdp0(prog):
+	try:
+		rdp0 = prog.variable('rcu_preempt_data', 'kernel/rcu/tree.c');
+	except LookupError:
+		rdp0 = NULL;
+
+	if rdp0 == NULL:
+		try:
+			rdp0 = prog.variable('rcu_sched_data',
+					     'kernel/rcu/tree.c');
+		except LookupError:
+			rdp0 = NULL;
+
+	if rdp0 == NULL:
+		rdp0 = prog.variable('rcu_data', 'kernel/rcu/tree.c');
+	return rdp0.address_of_();
+
+rdp0 = get_rdp0(prog);
+
+# Sum up RCU callbacks.
+sum = 0;
+for cpu in for_each_possible_cpu(prog):
+	rdp = per_cpu_ptr(rdp0, cpu);
+	len = rdp.cblist.len.value_();
+	# print("CPU " + str(cpu) + " RCU callbacks: " + str(len));
+	sum += len;
+print("Number of RCU callbacks in flight: " + str(sum));
-- 
2.31.1.189.g2e36527f23

