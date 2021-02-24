Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39122C433E0
	for <rcu@archiver.kernel.org>; Wed, 24 Feb 2021 15:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E926264EF5
	for <rcu@archiver.kernel.org>; Wed, 24 Feb 2021 15:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbhBXP7A (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Feb 2021 10:59:00 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:42598 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbhBXP1s (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Feb 2021 10:27:48 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210224152607epoutp04bb85bea2f72312de268072a046fe3388~muH4KsNwb0864508645epoutp044
        for <rcu@vger.kernel.org>; Wed, 24 Feb 2021 15:26:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210224152607epoutp04bb85bea2f72312de268072a046fe3388~muH4KsNwb0864508645epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614180367;
        bh=cvu6G+xjQL8ERNKPssJKZA/4J2+3QBAz3OFIAb20i9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cx5H+3m2CnmDcyygDc9W0EQRnIt11FmvIonk9qzMtpzAFr3dqvgWcY8ZLKjA84B7j
         p2LrQp/Q1ganh0AN2rwtBZJ8ZCPQCOhLIs+KoroFY/Q9NSjG3geqNlVnQAJMPgngfq
         UkC4I7vhQxJmpCmEOlhkpJ3ql4KMbkWjFJ8jyf1U=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210224152607epcas1p16b87847aaf1d29e00ae7631f7fc3db6c~muH3qAq6J0174201742epcas1p1E;
        Wed, 24 Feb 2021 15:26:07 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.160]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Dm0B63WJFz4x9Ps; Wed, 24 Feb
        2021 15:26:06 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.8D.09582.E0076306; Thu, 25 Feb 2021 00:26:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210224152605epcas1p2170c2d6c0567c47e72559faa3148ddee~muH2Lu0b60807708077epcas1p2F;
        Wed, 24 Feb 2021 15:26:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210224152605epsmtrp113484bd9dff72ca431a8ecfc642f032f~muH2K1EEH2968929689epsmtrp1f;
        Wed, 24 Feb 2021 15:26:05 +0000 (GMT)
X-AuditID: b6c32a37-8afff7000000256e-e4-6036700e9e3b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.6D.13470.D0076306; Thu, 25 Feb 2021 00:26:05 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.183]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210224152605epsmtip2ddc387b3c95df24adb1d7756e3745a16~muH15oA5X2745027450epsmtip2S;
        Wed, 24 Feb 2021 15:26:05 +0000 (GMT)
From:   Sangmoon Kim <sangmoon.kim@samsung.com>
To:     neeraju@codeaurora.org
Cc:     jiangshanlai@gmail.com, joel@joelfernandes.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        paulmck@kernel.org, rcu@vger.kernel.org, rostedt@goodmis.org,
        sangmoon.kim@samsung.com
Subject: Re: [PATCH] rcu/tree: Add a trace event for RCU stall warnings
Date:   Thu, 25 Feb 2021 00:17:11 +0900
Message-Id: <20210224151711.7823-1-sangmoon.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2406eacc-b270-989d-79ce-9e97817b7458@codeaurora.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmvi5fgVmCwa9JEhZT1+5msljWoGrx
        f0G+xeazZ5gt+pcuZ7f4tOQbi8XZ2edYLfZ1PGCyuPWgkcWB0+NyXy+Tx9LTb9g8ds66y+7R
        su8Wu8fCT19ZPW69tvXYtKqTzaNvyypGj8+b5AI4o3JsMlITU1KLFFLzkvNTMvPSbZW8g+Od
        403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4AuVFIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fY
        KqUWpOQUGBoU6BUn5haX5qXrJefnWhkaGBiZAlUm5GT83NTMWrBMsmLNzc+sDYyPhLsYOTkk
        BEwkjj7uY+pi5OIQEtjBKPH9z09mCOcTo0TT7PdsEM43RomJd5aywLT83raeCcQWEtjLKNF2
        OAmi6AujxNpPz9hAEmwCuhJf5l1mBLFFBKQkbh+8wQhSxCxwFGjHqrNgk4QF3CWatu1jB7FZ
        BFQlljc1g8V5BWwk/h45zAaxTV5i9YYDQDdxcHAKOEnM/Ac2R0LgK7vEjXmboGpcJHqatjJB
        2MISr45vYYewpSRe9rdB2fsYJfaslIFonsIosXzKDqiEsURvzwWwBcwCmhLrd+lDhBUldv6e
        C/YAswCfxLuvPawgJRICvBIdbUIQJWoSj1/dZYSwZST678yHBpCHxI/9F6AhN5VR4vCVe8wT
        GOVmIWxYwMi4ilEstaA4Nz212LDAGDnKNjGC06CW+Q7GaW8/6B1iZOJgPMQowcGsJMK7+Z9p
        ghBvSmJlVWpRfnxRaU5q8SFGU2DgTWSWEk3OBybivJJ4Q1MjY2NjCxMzczNTYyVx3iSDB/FC
        AumJJanZqakFqUUwfUwcnFINTOdjVyWUdeySKfd5wCvwQcv29p3KnWItTH4/uCy3Occ9WdAv
        lJR1dteCedXu7jeaJzzpDit9nbVhoti3eb7L/Psu8Hgdv2n70E7/UHCaZSHv4ZWm2wy9Ff9F
        bUiP5Veb3Os3KXnS/Xs9vL3vH7D67drg9Mj/WJ9ljJy6SOvXywF/jGPWmvd0ZLk8bT98/ZpR
        zwZRJ3aLZdquLf1Xt353YhG33SfP9mJH5FP2uhkyO67/3iFeFJL0PMc3xOpLQvOsggUmuiln
        XzDwFmoYH+ha5yd2SkuEqdQvQD5x6fY3J19N4ylY8j7x+5HinKdThabYCCy02yp5f0uC6LV1
        LzmdGw4+vWrhssJL2I29ZtpFJZbijERDLeai4kQA7eDzbAwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvC5vgVmCwc476hZT1+5msljWoGrx
        f0G+xeazZ5gt+pcuZ7f4tOQbi8XZ2edYLfZ1PGCyuPWgkcWB0+NyXy+Tx9LTb9g8ds66y+7R
        su8Wu8fCT19ZPW69tvXYtKqTzaNvyypGj8+b5AI4o7hsUlJzMstSi/TtErgyfm5qZi1YJlmx
        5uZn1gbGR8JdjJwcEgImEr+3rWfqYuTiEBLYzSixrm8NO0RCRmLnxc1ACQ4gW1ji8OFiiJpP
        jBKb/25nBqlhE9CV+DLvMiOILSIgJXH74A0wm1ngPKPE3t91ILawgLtE07Z9YDNZBFQlljc1
        s4DYvAI2En+PHGaD2CUvsXrDAWaQXZwCThIz/4GNERJwlHjRNpd5AiPfAkaGVYySqQXFuem5
        xYYFhnmp5XrFibnFpXnpesn5uZsYwYGqpbmDcfuqD3qHGJk4GA8xSnAwK4nwbv5nmiDEm5JY
        WZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QDU/fMaw2T58k9FhRO
        ZEsNLv63yUNA5fZ8of7LTh+XvD537tMtnpuCjo+KjC1esrL8bhKvPnz41rbl7iu0et3TPBdM
        0btx9WzdKobTqmdcF8x4u3oyg8wVhSUrlA/lmGkXZz8/O/PtwfuOD/V2tp4oOaIXMGn+byae
        81tvC77QVXincbI78uUJrW+H3kT8WTfj6OO8PB+RnaX7ne99P8P4cTmbaNMb6e8PpwaKHXnB
        Me3caiPx+BX1xRriq7iMusQC1/THfmPkehlzjYPLxv7o1zd3/CYm/P6Rw+ftLKiyyFv0t8eK
        x+JXhU2cvCc9FX4cynj58+n173rnM6rYNDaklS6Uf3bE6mba1M+2BWnTE98psRRnJBpqMRcV
        JwIAOl/mQ8MCAAA=
X-CMS-MailID: 20210224152605epcas1p2170c2d6c0567c47e72559faa3148ddee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210224152605epcas1p2170c2d6c0567c47e72559faa3148ddee
References: <2406eacc-b270-989d-79ce-9e97817b7458@codeaurora.org>
        <CGME20210224152605epcas1p2170c2d6c0567c47e72559faa3148ddee@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


> -----Original Message-----
> From: neeraju=codeaurora.org@mg.codeaurora.org <neeraju=codeaurora.org@mg.codeaurora.org>
> Neeraj Upadhyay
> Sent: Wednesday, February 24, 2021 6:19 PM
> 
> Hi Sangmoon,
> 
> 
> On 2/22/2021 1:55 PM, Sangmoon Kim wrote:
> >
> >
> >> -----Original Message-----
> >> From: Paul E. McKenney <paulmck@kernel.org>
> >> Sent: Friday, February 19, 2021 3:59 AM
> >>
> >> On Thu, Feb 18, 2021 at 01:24:16PM -0500, Steven Rostedt wrote:
> >>> On Thu, 18 Feb 2021 09:00:12 -0800
> >>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >>>
> >>>> OK, I will bite.  ;-)
> >>>
> >>> Do I turn into a wearwolf?
> >>
> >> Maybe even a wash-n-wear wolf.  ;-)
> >>
> >>>> Can the saving of console into trace buffers be easily enabled and
> >>>> disabled within the code?
> >>>
> >>> Well, we do have this for ftrace:
> >>>
> >>>   echo 'enable_event:printk:console' > events/rcu/rcu_stall_warning/trigger
> >>>
> >>> Would enable the printk console to be traced to the ring buffer once the
> >>> stall is triggered, and not before hand.
> >>>
> >>>>   If so, does enabling and disabling nest?
> >>>
> >>> It has a disable as well, but unfortunately its global and does not nest.
> >>> We could always implement a percpu trigger that can nest though.
> >>
> >> So Sangmoon could have a module react to an RCU CPU stall warning
> >> tracepoint by turning on tracing of console messages.  If there was a
> >> start-stop pair of RCU CPU stall warning tracepoints, he could turn it
> >> off as well.
> >>
> >> Not sure if that is what Sangmoon is looking for, but it is a possibility.
> >>
> >> 							Thanx, Paul
> >
> > Thank you. I'm learning the new things through this review.
> >
> > Copying console messages is not really necessary to me. I wanted to say
> > this tracepoint can also be used in such way for debugging purpose.
> >
> 
> In case we want to use this trace event, to capture RCU stall
> information, which comes on console, into trace buffers; why not have
> these events at the start of the functions like print_other_cpu_stall(),
> print_cpu_stall() rather than  at the end ?

I agree. It is good to be located before printing console message. I'll
revise the patch. Or, should I make a patch with start-end pair?

Thanks,
Sangmoon

> 
> 
> Thanks
> Neeraj
> 
> > What I need is that a module records the stall happening and report the
> > stall event when kernel panic occurred. Of course, there is no detailed
> > information there, but it helps developers to recognize that the stall
> > has occurred in the system.
> >
> > The usage scenario is as follows.
> > There is a kernel module for debugging.
> > The module registers a probe function using register_trace_rcu_stall_warning().
> > When a stall warning event occurs, the module records the event into its own buffer.
> > When a kernel panic occurs, the developers can see the report generated
> > by the module and can also see the buffer of the module directly through Ramdump.
> >
> > Thanks,
> > Sangmoon
> >
> 
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member of the Code Aurora Forum, hosted by The Linux Foundation
