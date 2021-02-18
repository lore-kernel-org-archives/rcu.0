Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F334C433E0
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 16:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D906146D
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 16:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhBRQln (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:41:43 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:49990 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhBRNCP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Feb 2021 08:02:15 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210218130059epoutp03b027e51e8c5c5899928ffdab1219408f~k2RcHkB8e2901029010epoutp03X
        for <rcu@vger.kernel.org>; Thu, 18 Feb 2021 13:00:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210218130059epoutp03b027e51e8c5c5899928ffdab1219408f~k2RcHkB8e2901029010epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613653259;
        bh=tCa4thfBogo02YNGbJu+OI8WnmGLkDFu+TItRqrynrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jbL3vvBuv8f0FRxJUvzI56Kpq+UmWxlJJWfUsqBDtfnh3x5lzOuOLrqkTXCLOnwIM
         YcGZqKR0OBRfJUhDqxCqv9I6H7DlVlN6H6CljNswZpPXZEyuUUi7ZdlsEpk2ariH8b
         YxuyjZrvmisg95vuUTn294ioKnWJp3QY3IHj5mCI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210218130058epcas1p4191b1d6646e9fc8f0debd0ddcf2aedfd~k2RbUJXct1704317043epcas1p47;
        Thu, 18 Feb 2021 13:00:58 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.161]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DhFFP4QlQz4x9Pp; Thu, 18 Feb
        2021 13:00:57 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.92.10463.9056E206; Thu, 18 Feb 2021 22:00:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210218130056epcas1p21e5b2e873f8c3cb0aa6953473d4c416c~k2RZzkHYj0602806028epcas1p2n;
        Thu, 18 Feb 2021 13:00:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210218130056epsmtrp1d45450ce2281e673c35573c0101a6a3c~k2RZyyOuw2210222102epsmtrp1P;
        Thu, 18 Feb 2021 13:00:56 +0000 (GMT)
X-AuditID: b6c32a38-efbff700000028df-3d-602e6509a2fc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.21.08745.8056E206; Thu, 18 Feb 2021 22:00:56 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.183]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210218130056epsmtip15edd0d810e7c00aba022dcf7cf96ed0b~k2RZi7JMX2024020240epsmtip1N;
        Thu, 18 Feb 2021 13:00:56 +0000 (GMT)
From:   Sangmoon Kim <sangmoon.kim@samsung.com>
To:     neeraju@codeaurora.org
Cc:     jiangshanlai@gmail.com, joel@joelfernandes.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        paulmck@kernel.org, rcu@vger.kernel.org, rostedt@goodmis.org,
        sangmoon.kim@samsung.com
Subject: Re: [PATCH] rcu/tree: Add a trace event for RCU stall warnings
Date:   Thu, 18 Feb 2021 21:52:24 +0900
Message-Id: <20210218125224.23739-1-sangmoon.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <bf80e296-14bf-6f36-8952-416829d30e5a@codeaurora.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmri5nql6CQc8BBYupa3czWSxrULX4
        vyDfYvPZM8wW/UuXs1t8WvKNxeLs7HOsFvs6HjBZ3HrQyOLA6XG5r5fJY+npN2weO2fdZfdo
        2XeL3WPhp6+sHrde23psWtXJ5tG3ZRWjx+dNcgGcUTk2GamJKalFCql5yfkpmXnptkrewfHO
        8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUAXKimUJeaUAoUCEouLlfTtbIryS0tSFTLyi0ts
        lVILUnIKDA0K9IoTc4tL89L1kvNzrQwNDIxMgSoTcjIazy5hKfioVTH1+CW2BsZpSl2MnBwS
        AiYStxueM4LYQgI7GCVOtGp0MXIB2Z8YJS78uMcE4XxmlHh4pZkFpmPXiW+MEIldjBLzli9n
        h3C+MEp8eviGDaSKTUBX4su8y2BzRQSkJG4fvAHWwSxwlFHi+6qzYKOEBdwlmrbtYwexWQRU
        Je593csEYvMK2Eo0730JtU5eYvWGA8wgNqeAk8SLKz/BbpIQ+Moucf/uJXaIIheJrS+nMkPY
        whKvjm+BiktJvOxvg7L3MUrsWSkD0TyFUWL5lB1QCWOJ3p4LQM0cQOdpSqzfpQ8RVpTY+Xsu
        2AfMAnwS7772sIKUSAjwSnS0CUGUqEk8fnWXEcKWkei/Mx/qZg+J3YsXsUFCZSqjxLmHnawT
        GOVmIWxYwMi4ilEstaA4Nz212LDABDnONjGCE6GWxQ7GuW8/6B1iZOJgPMQowcGsJMLL/lkr
        QYg3JbGyKrUoP76oNCe1+BCjKTD0JjJLiSbnA1NxXkm8oamRsbGxhYmZuZmpsZI4b5LBg3gh
        gfTEktTs1NSC1CKYPiYOTqkGprLtyQv2zLk8xeZ+uK8pp1eOnIli4Jejl979Y1u6Y8FsFu2l
        WQe3L+vodz70Mbu1XdB925wlfzyOh69/td1ghvVuvjknMlYVXm2oCOmPkJl5oNhP/uPch1cm
        8+5lD522VFZZpZHD6kGh/mLxVTIbOFi5XVTnx+nmqN3UOt2TpZz6fNfPqANh62b2GQbdqbra
        fMM2fufGpG0FuVZ/NOw4Ej7x3XjzKzi8p+V+15/j17PT5EpFz1wKnub974ZIxL/StQ8Dfz7d
        X+676Ipq0YLa3mn907Jjk5aePqeceNtPyPn+h9DEi+Uv5uc2npXfxbVJfvfDk8kfF8VdfBVS
        7bpD2KfA+8iBqpeNWTwL5NVmtSuxFGckGmoxFxUnAgDbyl1mDQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWy7bCSnC5Hql6CweW5+hZT1+5msljWoGrx
        f0G+xeazZ5gt+pcuZ7f4tOQbi8XZ2edYLfZ1PGCyuPWgkcWB0+NyXy+Tx9LTb9g8ds66y+7R
        su8Wu8fCT19ZPW69tvXYtKqTzaNvyypGj8+b5AI4o7hsUlJzMstSi/TtErgyGs8uYSn4qFUx
        9fgltgbGaUpdjJwcEgImErtOfGMEsYUEdjBKnL9WBBGXkdh5cTNTFyMHkC0scfhwcRcjF1DJ
        J0aJM90r2EBq2AR0Jb7MuwzWKyIgJXH74A0wm1ngPKPE3t91ILawgLtE07Z97CA2i4CqxL2v
        e5lAbF4BW4nmvS9ZIHbJS6zecIAZxOYUcJJ4ceUn2F4hAUeJo2u0JzDyLWBkWMUomVpQnJue
        W2xYYJSXWq5XnJhbXJqXrpecn7uJERymWlo7GPes+qB3iJGJg/EQowQHs5IIL/tnrQQh3pTE
        yqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamKKXfuXfo3LJee+1
        uf2ph5c8K5fTv+AT8UQ/Vj8poktMLn++jPiqf3t74m+Zae2TFZT+u8pP8QHjymeVl+813lv2
        4H3Uv3/3VSsZJa+uy8xkVgl6NGOCSP/0EENOhr/Kkksv7PdkbP1aLnn1SdUM3prlLBad+Z7X
        WJ56LNvm17RfUPWe2U6Nu7OrzvK83LhLLO7hiiXK14yqpRrPf/ZM6kiaed7Pv4dJ8tTDuRvn
        dDQ6Tbu768WHoEgmNs0DhSEXDbynnljKcipp7exHFkU3pVlb/qo16e1d/rOSj++7TlfTpRWn
        Z22VN7TaL3/CtPv/0RkSVn7ZLB5Lr/vcrpvA+ezlPo9Py37/Xn38GBsjzxQlluKMREMt5qLi
        RACcZaRcwgIAAA==
X-CMS-MailID: 20210218130056epcas1p21e5b2e873f8c3cb0aa6953473d4c416c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210218130056epcas1p21e5b2e873f8c3cb0aa6953473d4c416c
References: <bf80e296-14bf-6f36-8952-416829d30e5a@codeaurora.org>
        <CGME20210218130056epcas1p21e5b2e873f8c3cb0aa6953473d4c416c@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> -----Original Message-----
> From: neeraju=codeaurora.org@mg.codeaurora.org <neeraju=codeaurora.org@mg.codeaurora.org>
> Sent: Thursday, February 18, 2021 3:18 AM
> 
> Hi Sangmoon,
> 
> On 2/17/2021 7:19 PM, Sangmoon Kim wrote:
> >> -----Original Message-----
> >> From: Paul E. McKenney <paulmck@kernel.org>
> >> Sent: Wednesday, February 17, 2021 2:50 AM
> >>
> >> On Mon, Feb 15, 2021 at 05:53:25PM +0900, Sangmoon Kim wrote:
> >>> The event allows us to trace the RCU stall when
> >>> sysctl_panic_on_rcu_stall is disabled.
> >>>
> >>> The first parameter is the name of RCU flavour like other trace
> >>> events. The second one shows us which function detected stalls.
> >>>
> >>> The RCU stall is mainly caused by external factors such as interrupt
> >>> handling or task scheduling or something else. Therefore, this event
> >>> uses TRACE_EVENT macro, not dedicated one, so that someone interested
> >>> in the RCU stall can use it without CONFIG_RCU_TRACE.
> >>>
> >>> Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
> >>
> >> The patch looks plausible, but I have to ask...  Why not instead just
> >> get the existing information out of the console log?
> >>
> >> 							Thanx, Paul
> >
> > This can provide a trigger point for the RCU stall warning.
> > If a module in the kernel wants to trace the stall for debugging purposes,
> > there is a cost of continuing to parse the console log.
> > This tracepoint is useful because it is hard to pay these costs
> > especially on mobile devices.
> >
> > Thanks,
> > Sangmoon
> >
> 
> So, the idea here is to register to these trace events from kernel
> module and use that for debugging? Just curious what debugging action
> module does on these traces, as they have limited information
> about the stall, compared to console stall warnings, which gives a
> much more detailed information about stall.
> 
> 
> Thanks
> Neeraj

Hi Neeraj,

Yes, a module can log the stall occurence using the trace, although
there is no detailed information. If the kernel panic occurs for some
reasons, the debugging report generated by the module can include that
RCU stall warning has occurred before.

In addition, it's just an idea now, when a trace event happens, the
module can store the console log including detailed information, or may
also obtain CPU/task information by parsing the console log.

Thanks,
Sangmoon

> 
> >>
> >>> ---
> >>>   include/trace/events/rcu.h | 28 ++++++++++++++++++++++++++++
> >>>   kernel/rcu/tree_exp.h      |  2 ++
> >>>   kernel/rcu/tree_stall.h    |  2 ++
> >>>   3 files changed, 32 insertions(+)
> >>>
> >>> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> >>> index 155b5cb43cfd..8476f3161bd0 100644
> >>> --- a/include/trace/events/rcu.h
> >>> +++ b/include/trace/events/rcu.h
> >>> @@ -432,6 +432,34 @@ TRACE_EVENT_RCU(rcu_fqs,
> >>>   		  __entry->cpu, __entry->qsevent)
> >>>   );
> >>>
> >>> +/*
> >>> + * Tracepoint for RCU stall events. Takes a string identifying the RCU flavor
> >>> + * and a string identifying which function detected the RCU stall as follows:
> >>> + *
> >>> + *	"StallDetected": Scheduler-tick detects other CPU's stalls.
> >>> + *	"SelfDetected": Scheduler-tick detects a current CPU's stall.
> >>> + *	"ExpeditedStall": Expedited grace period detects stalls.
> >>> + */
> >>> +TRACE_EVENT(rcu_stall_warning,
> >>> +
> >>> +	TP_PROTO(const char *rcuname, const char *msg),
> >>> +
> >>> +	TP_ARGS(rcuname, msg),
> >>> +
> >>> +	TP_STRUCT__entry(
> >>> +		__field(const char *, rcuname)
> >>> +		__field(const char *, msg)
> >>> +	),
> >>> +
> >>> +	TP_fast_assign(
> >>> +		__entry->rcuname = rcuname;
> >>> +		__entry->msg = msg;
> >>> +	),
> >>> +
> >>> +	TP_printk("%s %s",
> >>> +		  __entry->rcuname, __entry->msg)
> >>> +);
> >>> +
> >>>   #endif /* #if defined(CONFIG_TREE_RCU) */
> >>>
> >>>   /*
> >>> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> >>> index 8760b6ead770..c16618284cb2 100644
> >>> --- a/kernel/rcu/tree_exp.h
> >>> +++ b/kernel/rcu/tree_exp.h
> >>> @@ -566,6 +566,8 @@ static void synchronize_rcu_expedited_wait(void)
> >>>   				dump_cpu_task(cpu);
> >>>   			}
> >>>   		}
> >>> +		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
> >>> +
> >>>   		jiffies_stall = 3 * rcu_jiffies_till_stall_check() + 3;
> >>>   	}
> >>>   }
> >>> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> >>> index 70d48c52fabc..e93df4fac5b1 100644
> >>> --- a/kernel/rcu/tree_stall.h
> >>> +++ b/kernel/rcu/tree_stall.h
> >>> @@ -531,6 +531,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
> >>>
> >>>   	rcu_check_gp_kthread_starvation();
> >>>
> >>> +	trace_rcu_stall_warning(rcu_state.name, TPS("StallDetected"));
> >>>   	panic_on_rcu_stall();
> >>>
> >>>   	rcu_force_quiescent_state();  /* Kick them all. */
> >>> @@ -575,6 +576,7 @@ static void print_cpu_stall(unsigned long gps)
> >>>   			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
> >>>   	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >>>
> >>> +	trace_rcu_stall_warning(rcu_state.name, TPS("SelfDetected"));
> >>>   	panic_on_rcu_stall();
> >>>
> >>>   	/*
> >>> --
> >>> 2.17.1
> >>>
> >
> 
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member of the Code Aurora Forum, hosted by The Linux Foundation
