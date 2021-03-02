Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9029CC433E0
	for <rcu@archiver.kernel.org>; Wed,  3 Mar 2021 04:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B64164ECE
	for <rcu@archiver.kernel.org>; Wed,  3 Mar 2021 04:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344490AbhCCEvJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 2 Mar 2021 23:51:09 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:53916 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446863AbhCBMNp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 2 Mar 2021 07:13:45 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210302120421epoutp04e946e62e23ae928b1ec084ac42ebbe94~ohPaiy6Nj0898908989epoutp04N
        for <rcu@vger.kernel.org>; Tue,  2 Mar 2021 12:04:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210302120421epoutp04e946e62e23ae928b1ec084ac42ebbe94~ohPaiy6Nj0898908989epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614686661;
        bh=4tIyARZYgVeW0cJ4YTf4aAbMGnWWBH3xvDhYbw6JmtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgitQc3yXQNQQS05ISni6yBwyvJ8nJr+1+W94JVfXOZ7LqAEWMjn3ZFCm9ZAyxDjn
         D3Qg1INinIF4tG723AVvNbg5ZQ6b98Zc++ImoskhgYUzLm14YFbMbNc3idckb9l4mq
         1y3hMhEsyWLg6e1IQm2ymBrn2K9ADH7vIabZJFIc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210302120420epcas1p40337a24890d0de4cf19b3b480a599e63~ohPZe6XtN2335423354epcas1p4x;
        Tue,  2 Mar 2021 12:04:20 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DqbQW0bb5z4x9Pr; Tue,  2 Mar
        2021 12:04:19 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.7B.02418.2C92E306; Tue,  2 Mar 2021 21:04:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210302120418epcas1p17e7f55d9c380ae864d2a6afab5fd3b1b~ohPYAOP5q0435304353epcas1p1W;
        Tue,  2 Mar 2021 12:04:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210302120418epsmtrp12129b5e540e3a4107da1e9ead8820266~ohPX-Y84Q0638806388epsmtrp1p;
        Tue,  2 Mar 2021 12:04:18 +0000 (GMT)
X-AuditID: b6c32a35-c23ff70000010972-9f-603e29c2a578
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.34.08745.2C92E306; Tue,  2 Mar 2021 21:04:18 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.183]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210302120418epsmtip28eadcea89f3b7b76f81ec0adfc77f44d~ohPXzPaeT2854228542epsmtip2P;
        Tue,  2 Mar 2021 12:04:18 +0000 (GMT)
From:   Sangmoon Kim <sangmoon.kim@samsung.com>
To:     urezki@gmail.com
Cc:     jiangshanlai@gmail.com, joel@joelfernandes.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        neeraju@codeaurora.org, paulmck@kernel.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, sangmoon.kim@samsung.com
Subject: [PATCH v3] rcu/tree: Add a trace event for RCU stall warnings
Date:   Tue,  2 Mar 2021 20:55:15 +0900
Message-Id: <20210302115515.14239-1-sangmoon.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210228194700.GA55724@pc638.lan>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmru5hTbsEgxdOFlPX7mayWNagavF/
        Qb7F5rNnmC36ly5nt/i05BuLxdnZ51gt9nU8YLK49aCRxWL1RRYHLo/Lfb1MHktPv2Hz2Dnr
        LrtHy75b7B4LP31l9bj12tZj06pONo++LasYPT5vkgvgjMqxyUhNTEktUkjNS85PycxLt1Xy
        Do53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6UkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCR
        X1xiq5RakJJTYGhQoFecmFtcmpeul5yfa2VoYGBkClSZkJOx9OAr1oK10hXXPv5kaWC8I9bF
        yMkhIWAisel3HxuILSSwg1Hi+DyHLkYuIPsTo8S33QcYIZzPjBJPmtqYYDoOnDnOCpHYxSgx
        7+lhJoj2L4wSD3eB2WwCuhJf5l1mBLFFBEQkXk/9zgTSwCxwl1Fi9pQGsH3CAm4SU2ZPAprE
        wcEioCqx/1AVSJhXwFZiV9dyqGXyEqs3HGAGsTkF9CXOrZ/ABjJHQuAnu8TvBzOZQXolBFwk
        mp5bQNQLS7w6voUdwpaSeNnfBmXvY5TYs1IGoncKo8TyKTugEsYSvT0XwOYwC2hKrN+lDxFW
        lNj5ey7Y/cwCfBLvvvawQqzilehoE4IoUZN4/OouI4QtI9F/Zz4LhO0hcenlBxZI+DQBrbra
        wDaBUW4WwoYFjIyrGMVSC4pz01OLDQsMkSNsEyM4EWqZ7mCc+PaD3iFGJg7GQ4wSHMxKIrzi
        L20ThHhTEiurUovy44tKc1KLDzGaAsNuIrOUaHI+MBXnlcQbmhoZGxtbmJiZm5kaK4nzJhk8
        iBcSSE8sSc1OTS1ILYLpY+LglGpg0ovRXf119iLFMt4rUnf2xYQV/qk92X1HIUXLdM4MnxNH
        PNOU1/Dp9ebkyx6xPr+s+NrDQ8daTm7mnDC9ilG7u7r//rKDk/uXM4Z/UpW5Y79hb8HeLfYW
        LLF15/cKRVXa3359/BOL51z2FW4PNob8M576P5d7et7zw/42/4WCWgxOTSmtsHc69Prs1bBD
        a5kXV+T6RvZvnPjwn9yErU9/5Hxv51rwivHtXBHWyyJz/PLrjzicupo1f5U6l8UEVsVF95uW
        8vEdZTt+bGuYmfX8+8qTvzktfCjiYvnh/xWbuHk/m8UW+zJFXHB7trGnpaPV0+r1Jq8be15/
        YjetOr332bIJkms+eW0NTlt4M8jnWpMSS3FGoqEWc1FxIgB8xzzCDQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsWy7bCSvO4hTbsEg0uHJCymrt3NZLGsQdXi
        /4J8i81nzzBb9C9dzm7xack3Fouzs8+xWuzreMBkcetBI4vF6ossDlwel/t6mTyWnn7D5rFz
        1l12j5Z9t9g9Fn76yupx67Wtx6ZVnWwefVtWMXp83iQXwBnFZZOSmpNZllqkb5fAlbH04CvW
        grXSFdc+/mRpYLwj1sXIySEhYCJx4MxxVhBbSGAHo8TbWVwQcRmJnRc3M3UxcgDZwhKHDxd3
        MXIBlXxilLh9rJ8JpIZNQFfiy7zLjCC2iICIxOup38HizAIvGSWmn5EEsYUF3CSmzJ7ECjKH
        RUBVYv+hKpAwr4CtxK6u5UwQq+QlVm84wAxicwroS5xbP4EN4hw9iQlTjzBOYORbwMiwilEy
        taA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOFy1tHYw7ln1Qe8QIxMH4yFGCQ5mJRFe8Ze2
        CUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwdTlzvr/5
        aKLm46uc8/s7fPZVW/17UVa6e21ktJ+W08XlJof27fa5xvbB6W2p1zSH/cVtURz3y88kdpsI
        NmVY5zxIjHyWz/U5rDDqm3Fo6nNBpVUFXputlp5eP+Vfn10Qk7dr4uvDs+NW8V4RuXLwibCb
        XFZ93kx52ZXNq98x85/mV4osi+5uETNc2r3uhCvPbffa9XmmfQVH1go2b7gmaaR4RsDw8aqJ
        it6P7C9l9fGllLjEqyjVfzPXe/QnTLM68m3s8s6OvWy3Vgmmh8bevrlt8cmY40Kp186nFDFH
        vq6bI3d6e/AHrpSeSKdXzjendi8/G98ot/do4sK2F18l972UmrBC7ZmP6zxm3WlKLMUZiYZa
        zEXFiQCuLrogxgIAAA==
X-CMS-MailID: 20210302120418epcas1p17e7f55d9c380ae864d2a6afab5fd3b1b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210302120418epcas1p17e7f55d9c380ae864d2a6afab5fd3b1b
References: <20210228194700.GA55724@pc638.lan>
        <CGME20210302120418epcas1p17e7f55d9c380ae864d2a6afab5fd3b1b@epcas1p1.samsung.com>
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
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
Thank you for reviewing this.

Changes in v2:
 - Move the tracepoints before printing out stall messages.

Changes in v3:
 - Rebase on dev in linux-rcu.git

 include/trace/events/rcu.h | 28 ++++++++++++++++++++++++++++
 kernel/rcu/tree_exp.h      |  1 +
 kernel/rcu/tree_stall.h    |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 5fc29400e1a2..c7711e9b6900 100644
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
index 6c6ff06d4ae6..2796084ef85a 100644
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
index 475b26171b20..59b95cc5cbdf 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -536,6 +536,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
 	 * RCU CPU stall warnings.
 	 */
+	trace_rcu_stall_warning(rcu_state.name, TPS("StallDetected"));
 	pr_err("INFO: %s detected stalls on CPUs/tasks:\n", rcu_state.name);
 	rcu_for_each_leaf_node(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -606,6 +607,7 @@ static void print_cpu_stall(unsigned long gps)
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
 	 * RCU CPU stall warnings.
 	 */
+	trace_rcu_stall_warning(rcu_state.name, TPS("SelfDetected"));
 	pr_err("INFO: %s self-detected stall on CPU\n", rcu_state.name);
 	raw_spin_lock_irqsave_rcu_node(rdp->mynode, flags);
 	print_cpu_stall_info(smp_processor_id());
-- 
2.17.1

