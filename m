Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F124C433E0
	for <rcu@archiver.kernel.org>; Thu, 25 Feb 2021 04:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3DFF64ED3
	for <rcu@archiver.kernel.org>; Thu, 25 Feb 2021 04:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhBYERL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Feb 2021 23:17:11 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:30259 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhBYERJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Feb 2021 23:17:09 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210225041624epoutp046afe3b2b9a40658d24af60f97ec24476~m4obDAacJ1511215112epoutp04x
        for <rcu@vger.kernel.org>; Thu, 25 Feb 2021 04:16:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210225041624epoutp046afe3b2b9a40658d24af60f97ec24476~m4obDAacJ1511215112epoutp04x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614226584;
        bh=N1wkrP/sIT/0l51aE+fMC/6fzoa9se6ABLxgaB7Yjs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kysNaMujjzz62RTEY5uf54jXBijy06GS2y5jlNlQ/YfJL91K100cCX16mWqarQQMF
         S4oNu0to9yFN/KQRmmQkMJ3PTg/9ROtLBnaH0BWGPiOWCV9qPaaDapULod/sjnnqH0
         M1aft1I6TMwZI3DMngrPUCgKYGo7CPhPR8DnQ/aw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210225041624epcas1p1f2e121e2c07e9472566892bb70312c95~m4oamHiFE0259902599epcas1p1M;
        Thu, 25 Feb 2021 04:16:24 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DmKGv2DnDz4x9Q9; Thu, 25 Feb
        2021 04:16:23 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.86.09582.79427306; Thu, 25 Feb 2021 13:16:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210225041622epcas1p159a1f427882a90a4ca815b31114c52b6~m4oZGvhSo0257102571epcas1p1W;
        Thu, 25 Feb 2021 04:16:22 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210225041622epsmtrp2f5638eb257d36faf6bbd978fe878775e~m4oZF6YWF2450324503epsmtrp2L;
        Thu, 25 Feb 2021 04:16:22 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-3c-60372497ba98
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.E3.08745.69427306; Thu, 25 Feb 2021 13:16:22 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.183]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210225041622epsmtip159620677e0951b6de7fa76aaf7c08306~m4oY8OWtl0215702157epsmtip1d;
        Thu, 25 Feb 2021 04:16:22 +0000 (GMT)
From:   Sangmoon Kim <sangmoon.kim@samsung.com>
To:     neeraju@codeaurora.org
Cc:     jiangshanlai@gmail.com, joel@joelfernandes.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        paulmck@kernel.org, rcu@vger.kernel.org, rostedt@goodmis.org,
        sangmoon.kim@samsung.com
Subject: [PATCH v2] rcu/tree: Add a trace event for RCU stall warnings
Date:   Thu, 25 Feb 2021 13:06:12 +0900
Message-Id: <20210225040612.9917-1-sangmoon.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210224151711.7823-1-sangmoon.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmru50FfMEg/WHuC2mrt3NZLGsQdXi
        /4J8i81nzzBb9C9dzm7xack3Fouzs8+xWuzreMBkcetBI4sDp8flvl4mj6Wn37B57Jx1l92j
        Zd8tdo+Fn76yetx6beuxaVUnm0ffllWMHp83yQVwRuXYZKQmpqQWKaTmJeenZOal2yp5B8c7
        x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBdqKRQlphTChQKSCwuVtK3synKLy1JVcjILy6x
        VUotSMkpMDQo0CtOzC0uzUvXS87PtTI0MDAyBapMyMnYsuIne8E8qYqeV7OZGhhfinYxcnJI
        CJhIbD9/gaWLkYtDSGAHo8TdWSuZQBJCAp8YJZo7wyESnxkl3k79wQrT8f7zJGaIxC5GidXP
        5jFCOF8YJb6cPcAGUsUmoCvxZd5lRhBbREBK4vbBG2BFzAJHGSW+rzrLApIQFnCTmPlgM9hY
        FgFViSs968DivAI2ElvXTGCCWCcvsXrDAWYQm1PAVmL3jIdgx0oIfGWX+P/pEAtEkYvEzfaz
        bBC2sMSr41vYIWwpic/v9kLF9zFK7FkpA9E8hVFi+ZQdUEXGEr09F4A2cACdpymxfpc+RFhR
        YufvuWAfMAvwSbz72sMKUiIhwCvR0SYEUaIm8fjVXUYIW0ai/858qHM8JE7N2cgGCZUJQKu+
        n2KewCg3C2HDAkbGVYxiqQXFuempxYYFxshxtokRnAi1zHcwTnv7Qe8QIxMH4yFGCQ5mJRHe
        zf9ME4R4UxIrq1KL8uOLSnNSiw8xmgJDbyKzlGhyPjAV55XEG5oaGRsbW5iYmZuZGiuJ8yYZ
        PIgXEkhPLEnNTk0tSC2C6WPi4JRqYMp7WxK22FK0Nd2wcfrkL0Wnj35ptxHut3PvnPL05b3Q
        P0+FCza7MxaUNikdeal2L8z6nXL/tPq9G56oHZy4wOFfxy59g1VPZa9vzVov81tqA9M+sz6X
        N4Zre0xYPT9lrGWRazV9kBI9dd8fmeOruiI3T019Ly9+QONqQjPb+apPD/VEeOVubF/m83XB
        Uecne97cvDTlof6q8KX9YnLTvtV67710cMH9ihX1l6fcWTnJnFNSxyytJTSja81Z5rRw/qtM
        yrU+JSwdNk/eTL0oekjwt8QmfUNOqUUqlwUTHM/8/Z738+hC/XnLq+PYZyV9UPr1vYVP4kV+
        9Mr1K3e0hu8RWb8xj8NZ4fWH5+ftzvMqsRRnJBpqMRcVJwIA/PsvKw0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSnO40FfMEg7cvtC2mrt3NZLGsQdXi
        /4J8i81nzzBb9C9dzm7xack3Fouzs8+xWuzreMBkcetBI4sDp8flvl4mj6Wn37B57Jx1l92j
        Zd8tdo+Fn76yetx6beuxaVUnm0ffllWMHp83yQVwRnHZpKTmZJalFunbJXBlbFnxk71gnlRF
        z6vZTA2ML0W7GDk5JARMJN5/nsTcxcjFISSwg1Fi5fMFTBAJGYmdFzcD2RxAtrDE4cPFIGEh
        gU+MEj2vOEBsNgFdiS/zLjOC2CICUhK3D94As5kFzjNK7P1dB2ILC7hJzHywmRXEZhFQlbjS
        s44FxOYVsJHYumYC1Cp5idUbDjCD2JwCthK7ZzxkgdhlI7Hg/z/2CYx8CxgZVjFKphYU56bn
        FhsWGOWllusVJ+YWl+al6yXn525iBAeqltYOxj2rPugdYmTiYDzEKMHBrCTCu/mfaYIQb0pi
        ZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTKE7EjQmtc6cW7Dc
        ZMYy2ebLNmf6F0gqHHY7K99lxF6zQyv1xQNu37v/ld6ssU38v3Wak+mGnzN8Ok5q1ypZH5Vd
        FZ5nHxf/aMrl0smMIqnxEYnyJso3amq2/Fy9o+Tungn9m3zPzT5j3X1oceDfbxpfiw4ffG9h
        a2PgkJDF+NasIsJmZpBVxsKTyptXHZ9rei7t100nRa+3c0RqL/etFTfsX2z5Xr/LWdXm0vwJ
        3AmRPjfXeK/Onxp0XWevwOsnJx7evFt5TCdzakHeF/Z44drwr7f2CM7+rWW/w1pg39tzucs2
        BVTZ+wmq3/qrZ1bbOuHBttjDZR5f5v3h3MvrbxFicM96T8TZeKa7578lGyqxFGckGmoxFxUn
        AgBcvTCgwwIAAA==
X-CMS-MailID: 20210225041622epcas1p159a1f427882a90a4ca815b31114c52b6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210225041622epcas1p159a1f427882a90a4ca815b31114c52b6
References: <20210224151711.7823-1-sangmoon.kim@samsung.com>
        <CGME20210225041622epcas1p159a1f427882a90a4ca815b31114c52b6@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The event allows us to trace the RCU stall when
sysctl_panic_on_rcu_stall is disabled.

The first parameter is the name of RCU flavour like other trace
events. The second one shows us which function detected stalls.

The RCU stall is mainly caused by external factors such as interrupt
handling or task scheduling or something else. Therefore, this event
uses TRACE_EVENT macro, not dedicated one, so that someone interested
in the RCU stall can use it without CONFIG_RCU_TRACE.

Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
---
Changes in v2:
 - Move the tracepoints before printing out stall messages.

 include/trace/events/rcu.h | 28 ++++++++++++++++++++++++++++
 kernel/rcu/tree_exp.h      |  1 +
 kernel/rcu/tree_stall.h    |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 155b5cb43cfd..8476f3161bd0 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -432,6 +432,34 @@ TRACE_EVENT_RCU(rcu_fqs,
 		  __entry->cpu, __entry->qsevent)
 );
 
+/*
+ * Tracepoint for RCU stall events. Takes a string identifying the RCU flavor
+ * and a string identifying which function detected the RCU stall as follows:
+ *
+ *	"StallDetected": Scheduler-tick detects other CPU's stalls.
+ *	"SelfDetected": Scheduler-tick detects a current CPU's stall.
+ *	"ExpeditedStall": Expedited grace period detects stalls.
+ */
+TRACE_EVENT(rcu_stall_warning,
+
+	TP_PROTO(const char *rcuname, const char *msg),
+
+	TP_ARGS(rcuname, msg),
+
+	TP_STRUCT__entry(
+		__field(const char *, rcuname)
+		__field(const char *, msg)
+	),
+
+	TP_fast_assign(
+		__entry->rcuname = rcuname;
+		__entry->msg = msg;
+	),
+
+	TP_printk("%s %s",
+		  __entry->rcuname, __entry->msg)
+);
+
 #endif /* #if defined(CONFIG_TREE_RCU) */
 
 /*
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 8760b6ead770..6e1ac5b41f69 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -521,6 +521,7 @@ static void synchronize_rcu_expedited_wait(void)
 		if (rcu_stall_is_suppressed())
 			continue;
 		panic_on_rcu_stall();
+		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
 		pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {",
 		       rcu_state.name);
 		ndetected = 0;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 70d48c52fabc..ed50056a3c7b 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -488,6 +488,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
 	 * RCU CPU stall warnings.
 	 */
+	trace_rcu_stall_warning(rcu_state.name, TPS("StallDetected"));
 	pr_err("INFO: %s detected stalls on CPUs/tasks:\n", rcu_state.name);
 	rcu_for_each_leaf_node(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -554,6 +555,7 @@ static void print_cpu_stall(unsigned long gps)
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
 	 * RCU CPU stall warnings.
 	 */
+	trace_rcu_stall_warning(rcu_state.name, TPS("SelfDetected"));
 	pr_err("INFO: %s self-detected stall on CPU\n", rcu_state.name);
 	raw_spin_lock_irqsave_rcu_node(rdp->mynode, flags);
 	print_cpu_stall_info(smp_processor_id());
-- 
2.17.1

