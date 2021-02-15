Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7DFC433E9
	for <rcu@archiver.kernel.org>; Mon, 15 Feb 2021 09:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3E664E51
	for <rcu@archiver.kernel.org>; Mon, 15 Feb 2021 09:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhBOJFA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 15 Feb 2021 04:05:00 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:57655 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhBOJEC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 15 Feb 2021 04:04:02 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210215090243epoutp0488183508afd334de3a28535f73d04851~j4FjNQ8IY0878508785epoutp04I
        for <rcu@vger.kernel.org>; Mon, 15 Feb 2021 09:02:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210215090243epoutp0488183508afd334de3a28535f73d04851~j4FjNQ8IY0878508785epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613379763;
        bh=Ts7LzP1U5O7bCWfNXJ+AHA5wkzyFrPGo0Umjv+ywHUc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=qF1e2xA1Tr+DYdvbF6E0qMIi5KM9fdNwB7lMfEcNcrmLSZTN8xdo580Q+lUuljU83
         S2HKBF3z30ajqAzWO8lokDWm5gR8qhEkFf+NaAeU6HvdxMhvV2DDwQFiVEq1fmdhfx
         iw8EV/FJX4krbM3WPLtvArV+l6sjpf4Q+jd/0QVg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210215090243epcas1p3626987346c8dec3907e353832f26482b~j4FiwzuNH2137721377epcas1p3T;
        Mon, 15 Feb 2021 09:02:43 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.164]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4DfJ5t1B0yz4x9Q3; Mon, 15 Feb
        2021 09:02:42 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.FD.09577.1B83A206; Mon, 15 Feb 2021 18:02:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210215090241epcas1p17b1319d38de5a09a9d65a06ebf936866~j4FheDSIo0088800888epcas1p1f;
        Mon, 15 Feb 2021 09:02:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210215090241epsmtrp2e0a17d495cb34181dd9b9b4b2a96a463~j4FhdOZdY0796207962epsmtrp2f;
        Mon, 15 Feb 2021 09:02:41 +0000 (GMT)
X-AuditID: b6c32a39-c13ff70000002569-78-602a38b1b5d1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.E7.13470.1B83A206; Mon, 15 Feb 2021 18:02:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.183]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210215090241epsmtip15f1827ae363319bb12b2f851e15ae8b1~j4FhNtdxB2616726167epsmtip1G;
        Mon, 15 Feb 2021 09:02:41 +0000 (GMT)
From:   Sangmoon Kim <sangmoon.kim@samsung.com>
To:     paulmck@kernel.org, josh@joshtriplett.org
Cc:     rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, Sangmoon Kim <sangmoon.kim@samsung.com>
Subject: [PATCH] rcu/tree: Add a trace event for RCU stall warnings
Date:   Mon, 15 Feb 2021 17:53:25 +0900
Message-Id: <20210215085325.5461-1-sangmoon.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7bCmnu4mC60Eg79LGS2mrt3NZLGsQdXi
        /4J8i81nzzBbfFryjcXi7OxzrBb7Oh4wWdx60MjiwOGx9PQbNo+ds+6ye7Tsu8XusfDTV1aP
        W69tPTat6mTz6NuyitHj8ya5AI6oHJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtz
        JYW8xNxUWyUXnwBdt8wcoLuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWGBgV6
        xYm5xaV56XrJ+blWhgYGRqZAlQk5GXem9LAXNItXtN89zd7A2CXcxcjBISFgIrHhXnAXIxeH
        kMAORon/Rw8wQTifGCV+XPwG5XxjlHjx4Q1LFyMnWMfshpVMILaQwF5Gift/CiCKvjBKTNm3
        hhUkwSagK/Fl3mVGEFsEyD55+xM7SBGzwEpGif55v5hBEsICzhKLJj0Ea2ARUJV4Me8PG8hN
        vAI2Et3bBCGWyUus3nCAGaRXQuAUu0TrrlOsEHe7SLydlQRRIyzx6vgWdghbSuLzu71sEPY+
        Rok9K2UgeqcwSiyfsgOqyFiit+cCM8gcZgFNifW79CHCihI7f88Fu5lZgE/i3dceqFW8Eh1t
        QhAlahKPX91lhLBlJPrvzIeGiYfEyt9L2SFhEitxf9N35gmMsrMQFixgZFzFKJZaUJybnlps
        WGCKHEebGMFJTctyB+P0tx/0DjEycTAeYpTgYFYS4b0qoZEgxJuSWFmVWpQfX1Sak1p8iNEU
        GFwTmaVEk/OBaTWvJN7Q1MjY2NjCxMzczNRYSZw3yeBBvJBAemJJanZqakFqEUwfEwenVANT
        602hP9K8/e2KOtd6njxeY//dL0iotSs9q/2WZKND8/l3OlNlzldrNbdPMBb1OFwU7Gei+H9/
        0s2KXaW6724/c/mtny+nxh6ct9Mn/uDFVv6AT8+uurxVV1ufuOu7pvfpyU8Nbl2X3en00MRn
        68wH+1eJWnNVpe2Jm3vRKt+o/sTt9r3Tp1y+bn6a67PXsRs/bh/IM//V7fD/7I1PIkd5Hk9n
        0ubsearEYzvb0EGhM+SZvW3dk5LamPzi+3f/6zbvZuzj5spbdl6iNur1jtT1d3doMGdMesJ+
        PHOTYupWP9PeJ06t0jyntB/wzTDVO72c4ae65E3eOPMPmvfm+vourGm8G1c9S+aKlsy5h5+V
        WIozEg21mIuKEwFvcaoo8wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJTnejhVaCwfEuOYupa3czWSxrULX4
        vyDfYvPZM8wWn5Z8Y7E4O/scq8W+jgdMFrceNLI4cHgsPf2GzWPnrLvsHi37brF7LPz0ldXj
        1mtbj02rOtk8+rasYvT4vEkugCOKyyYlNSezLLVI3y6BK+POlB72gmbxiva7p9kbGLuEuxg5
        OSQETCRmN6xk6mLk4hAS2M0ocW33ZyaIhIzEzoubgWwOIFtY4vDhYoiaT4wSl8/1MIPUsAno
        SnyZd5kRxBYR0JdYuX4NM0gRs8B6RomeTdPZQRLCAs4SiyY9ZAWxWQRUJV7M+8MGMpRXwEai
        e5sgxC55idUbDjBPYORZwMiwilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOMy0NHcw
        bl/1Qe8QIxMH4yFGCQ5mJRHeqxIaCUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8s
        Sc1OTS1ILYLJMnFwSjUw5c8Teto322/aibo1LaarLyv0sLU3cuurVV9M7O00XfNyiuddMy0h
        A6fPU+732uk97L3N3Wq74JCXUs95gdhvPyzqpbXK183p/jbtw6mgfX6P7/2922v+ecYDxtAF
        FmuzGMwfnJ+8bN8SrlNzZ0sd7g5aePuX0/2DDoZvt7z8HXFDJ2jx6i5H1XDu2XcbE9scK4PD
        2nK+l2TP2ajmFpvgznLCU+6V6RudwqDcrVJn5JauzlNufdTJ0DW9desesVlRkXNkW1JW7OJ+
        fYylwYDhiXDgKp6/2lr5UVz+ih/ffLGeNy35ylbzHTqu0enbXuxhX692dbIJf+ryviMRDF97
        18iqzH3ms/HXV/5UDb0cJZbijERDLeai4kQAtOA7/6ICAAA=
X-CMS-MailID: 20210215090241epcas1p17b1319d38de5a09a9d65a06ebf936866
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210215090241epcas1p17b1319d38de5a09a9d65a06ebf936866
References: <CGME20210215090241epcas1p17b1319d38de5a09a9d65a06ebf936866@epcas1p1.samsung.com>
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
 include/trace/events/rcu.h | 28 ++++++++++++++++++++++++++++
 kernel/rcu/tree_exp.h      |  2 ++
 kernel/rcu/tree_stall.h    |  2 ++
 3 files changed, 32 insertions(+)

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
index 8760b6ead770..c16618284cb2 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -566,6 +566,8 @@ static void synchronize_rcu_expedited_wait(void)
 				dump_cpu_task(cpu);
 			}
 		}
+		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
+
 		jiffies_stall = 3 * rcu_jiffies_till_stall_check() + 3;
 	}
 }
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 70d48c52fabc..e93df4fac5b1 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -531,6 +531,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 
 	rcu_check_gp_kthread_starvation();
 
+	trace_rcu_stall_warning(rcu_state.name, TPS("StallDetected"));
 	panic_on_rcu_stall();
 
 	rcu_force_quiescent_state();  /* Kick them all. */
@@ -575,6 +576,7 @@ static void print_cpu_stall(unsigned long gps)
 			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
+	trace_rcu_stall_warning(rcu_state.name, TPS("SelfDetected"));
 	panic_on_rcu_stall();
 
 	/*
-- 
2.17.1

