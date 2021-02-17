Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFF5C433E0
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 13:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8BC064E0F
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 13:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhBQN7C (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Feb 2021 08:59:02 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:54510 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbhBQN7B (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Feb 2021 08:59:01 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210217135816epoutp030087cd83ff155bdb1809869017d74415~kjaK553qt3037330373epoutp03c
        for <rcu@vger.kernel.org>; Wed, 17 Feb 2021 13:58:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210217135816epoutp030087cd83ff155bdb1809869017d74415~kjaK553qt3037330373epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613570296;
        bh=2LNQsNPpDSrQe61krlGFbDldUxTlW5chCXPv4z2DIPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mbQJNKsE7X92p2bJe2/5gMcgjU88xnmMoiV5d1TQcyZdP1wtdqbMG+JF5RbVLzX14
         db4Xu5KurOFqAageCftnbusBEBhAthl2J3rt273PPmfjSrW7NTQgRNF7s/mcORzQUD
         GirxJdwcEi2LleAh3r2cyO+Bqh/UGxrMA0fp8A8Q=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210217135815epcas1p226be604ae48f85ed244749def5a597f7~kjaKCaBMk0628406284epcas1p2Y;
        Wed, 17 Feb 2021 13:58:15 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DgfYy509Bz4x9Pr; Wed, 17 Feb
        2021 13:58:14 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.87.09577.6F02D206; Wed, 17 Feb 2021 22:58:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210217135813epcas1p2b3bd79ca06ac847472b048b889100978~kjaIJllX81567815678epcas1p2m;
        Wed, 17 Feb 2021 13:58:13 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210217135813epsmtrp2bc50e16d0c2248dccd409e4bd48ce6b1~kjaII2wBU2651426514epsmtrp2M;
        Wed, 17 Feb 2021 13:58:13 +0000 (GMT)
X-AuditID: b6c32a39-bfdff70000002569-c1-602d20f68613
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.2D.08745.5F02D206; Wed, 17 Feb 2021 22:58:13 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.183]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210217135813epsmtip24800ecd43308d236a96224603ff6a1ad~kjaH5JdBy0748407484epsmtip22;
        Wed, 17 Feb 2021 13:58:13 +0000 (GMT)
From:   Sangmoon Kim <sangmoon.kim@samsung.com>
To:     paulmck@kernel.org
Cc:     jiangshanlai@gmail.com, joel@joelfernandes.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        rcu@vger.kernel.org, rostedt@goodmis.org, sangmoon.kim@samsung.com
Subject: Re: [PATCH] rcu/tree: Add a trace event for RCU stall warnings
Date:   Wed, 17 Feb 2021 22:49:47 +0900
Message-Id: <20210217134947.19055-1-sangmoon.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210216175015.GZ2743@paulmck-ThinkPad-P72>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmnu43Bd0EgwX7VS2mrt3NZLGsQdXi
        /4J8i81nzzBbfFryjcXi7OxzrBb7Oh4wWdx60MjiwOGx9PQbNo+ds+6ye7Tsu8XusfDTV1aP
        W69tPTat6mTz6NuyitHj8ya5AI6oHJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtz
        JYW8xNxUWyUXnwBdt8wcoLuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWGBgV6
        xYm5xaV56XrJ+blWhgYGRqZAlQk5Ga+23mcpaJavuHL2EWsD4xmJLkZODgkBE4lvF4+ydDFy
        cQgJ7GCU2Dp7NRtIQkjgE6PE+TdCEPZnRok70ypgGhZO/cQG0bCLUWL1xmlQDV8YJVZN9Aex
        2QR0Jb7Mu8wIYosIiEnsObWbGaSBWWAjo8TBA3tZQBLCAu4STdv2sYPYLAKqEp/mvgGyOTh4
        BWwlbm+zgVgmL7F6wwFmEJtTwFJi4tV/YJdKCDxil5iw5DvQAnYgx0XitwJEubDEq+Nb2CFs
        KYnP7/ayQdj7GCX2rJSBaJ3CKLF8yg6oImOJ3p4LzCBrmQU0Jdbv0ocIK0rs/D0X7HxmAT6J
        d197WEFKJAR4JTrahCBK1CQev7rLCGHLSPTfmc8CYXtI/P2+Exo8PYwS239MZ5vAKDcLYcMC
        RsZVjGKpBcW56anFhgWmyNG1iRGc6rQsdzBOf/tB7xAjEwfjIUYJDmYlEV72z1oJQrwpiZVV
        qUX58UWlOanFhxhNgUE3kVlKNDkfmGzzSuINTY2MjY0tTMzMzUyNlcR5kwwexAsJpCeWpGan
        phakFsH0MXFwSjUwTVbL6iiYarfiYYnibovK0OIFJrtstsmtubXqwtqTa5d49e83FC4qtXoe
        Hb/tqt7RmMMr/krK+eZ+fquvkbs1scnPv9lk3++42sTHkysXvPFYExvTVpcXdrKZ5SbfvItN
        G0+fjZ1tfWNjnZ3d9fvRcqksvl1XnuaI82mpP9tvUT05copyBuPPr49lDknLnrW9KtHUnPv9
        s3sA/9mqz7IfyplXe7a1Sk3643e6KXWegXjLgu9se3WSG9Ti/9y9KJY24d2z51f+7msS5zsr
        rzepUK1j5Q6FFVnap+alv1x6m1Hiz8w9nfmPDt/bWKQYNMduSyHLgxT5BUdWKPOsqza/sMC6
        49mWMNWW+NLPM3+HK7EUZyQaajEXFScCALm0AOX+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsWy7bCSvO5XBd0EgykLJS2mrt3NZLGsQdXi
        /4J8i81nzzBbfFryjcXi7OxzrBb7Oh4wWdx60MjiwOGx9PQbNo+ds+6ye7Tsu8XusfDTV1aP
        W69tPTat6mTz6NuyitHj8ya5AI4oLpuU1JzMstQifbsEroxXW++zFDTLV1w5+4i1gfGMRBcj
        J4eEgInEwqmf2LoYuTiEBHYwSpxq72KCSMhI7Ly4GcjmALKFJQ4fLgYJCwl8YpS4cMMdxGYT
        0JX4Mu8yI4gtIiAmsefUbmaQOcwCOxklbvS+ZgdJCAu4SzRt2wdmswioSnya+4YdZCavgK3E
        7W02EKvkJVZvOMAMYnMKWEpMvPqPBWKXhcTk1mtsExj5FjAyrGKUTC0ozk3PLTYsMMpLLdcr
        TswtLs1L10vOz93ECA5KLa0djHtWfdA7xMjEwXiIUYKDWUmEl/2zVoIQb0piZVVqUX58UWlO
        avEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTEJuS6Kzd9gZV27OX/NvJvu3jk6F
        GY5LNSuOeM66oBw1X1Q+YZFLefRezSVn7TcuOOq+LOwvqwlr1npG/r3RtwsLCjITmHb5Pw9f
        wnNv3QGLl5fnbbDumbd7VlNAkF05/1zPzd9YalS00nSyVcSveSo/LWctXaxz4ym3/D/7d/OK
        3WduLVvtI5W2SD9Id0u4onHHHPsJSQ/mzdi4c5LD81RZq+PM10u0rk2UlLF107FsOh+9zt3+
        RlZlle1xzUVyTDqnz8yL3HHX/Of6kyE5k7JuhCkcn3o1Y/p/sXDVnSnBExiKL366JHjP6ZDg
        0sTy807nE8rt5xtklcf6P7DQm9C4afXBz3EtK7588Tl9V4mlOCPRUIu5qDgRAJuFRyq5AgAA
X-CMS-MailID: 20210217135813epcas1p2b3bd79ca06ac847472b048b889100978
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210217135813epcas1p2b3bd79ca06ac847472b048b889100978
References: <20210216175015.GZ2743@paulmck-ThinkPad-P72>
        <CGME20210217135813epcas1p2b3bd79ca06ac847472b048b889100978@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> -----Original Message-----
> From: Paul E. McKenney <paulmck@kernel.org>
> Sent: Wednesday, February 17, 2021 2:50 AM
> 
> On Mon, Feb 15, 2021 at 05:53:25PM +0900, Sangmoon Kim wrote:
> > The event allows us to trace the RCU stall when
> > sysctl_panic_on_rcu_stall is disabled.
> >
> > The first parameter is the name of RCU flavour like other trace
> > events. The second one shows us which function detected stalls.
> >
> > The RCU stall is mainly caused by external factors such as interrupt
> > handling or task scheduling or something else. Therefore, this event
> > uses TRACE_EVENT macro, not dedicated one, so that someone interested
> > in the RCU stall can use it without CONFIG_RCU_TRACE.
> >
> > Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
> 
> The patch looks plausible, but I have to ask...  Why not instead just
> get the existing information out of the console log?
> 
> 							Thanx, Paul

This can provide a trigger point for the RCU stall warning.
If a module in the kernel wants to trace the stall for debugging purposes,
there is a cost of continuing to parse the console log.
This tracepoint is useful because it is hard to pay these costs
especially on mobile devices.

Thanks,
Sangmoon

> 
> > ---
> >  include/trace/events/rcu.h | 28 ++++++++++++++++++++++++++++
> >  kernel/rcu/tree_exp.h      |  2 ++
> >  kernel/rcu/tree_stall.h    |  2 ++
> >  3 files changed, 32 insertions(+)
> >
> > diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> > index 155b5cb43cfd..8476f3161bd0 100644
> > --- a/include/trace/events/rcu.h
> > +++ b/include/trace/events/rcu.h
> > @@ -432,6 +432,34 @@ TRACE_EVENT_RCU(rcu_fqs,
> >  		  __entry->cpu, __entry->qsevent)
> >  );
> >
> > +/*
> > + * Tracepoint for RCU stall events. Takes a string identifying the RCU flavor
> > + * and a string identifying which function detected the RCU stall as follows:
> > + *
> > + *	"StallDetected": Scheduler-tick detects other CPU's stalls.
> > + *	"SelfDetected": Scheduler-tick detects a current CPU's stall.
> > + *	"ExpeditedStall": Expedited grace period detects stalls.
> > + */
> > +TRACE_EVENT(rcu_stall_warning,
> > +
> > +	TP_PROTO(const char *rcuname, const char *msg),
> > +
> > +	TP_ARGS(rcuname, msg),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(const char *, rcuname)
> > +		__field(const char *, msg)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->rcuname = rcuname;
> > +		__entry->msg = msg;
> > +	),
> > +
> > +	TP_printk("%s %s",
> > +		  __entry->rcuname, __entry->msg)
> > +);
> > +
> >  #endif /* #if defined(CONFIG_TREE_RCU) */
> >
> >  /*
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index 8760b6ead770..c16618284cb2 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -566,6 +566,8 @@ static void synchronize_rcu_expedited_wait(void)
> >  				dump_cpu_task(cpu);
> >  			}
> >  		}
> > +		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
> > +
> >  		jiffies_stall = 3 * rcu_jiffies_till_stall_check() + 3;
> >  	}
> >  }
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index 70d48c52fabc..e93df4fac5b1 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -531,6 +531,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
> >
> >  	rcu_check_gp_kthread_starvation();
> >
> > +	trace_rcu_stall_warning(rcu_state.name, TPS("StallDetected"));
> >  	panic_on_rcu_stall();
> >
> >  	rcu_force_quiescent_state();  /* Kick them all. */
> > @@ -575,6 +576,7 @@ static void print_cpu_stall(unsigned long gps)
> >  			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
> >  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >
> > +	trace_rcu_stall_warning(rcu_state.name, TPS("SelfDetected"));
> >  	panic_on_rcu_stall();
> >
> >  	/*
> > --
> > 2.17.1
> >

