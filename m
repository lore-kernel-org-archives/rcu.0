Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2B1C433E0
	for <rcu@archiver.kernel.org>; Mon, 22 Feb 2021 08:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E11D664DD3
	for <rcu@archiver.kernel.org>; Mon, 22 Feb 2021 08:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBVIfE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Feb 2021 03:35:04 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:47858 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhBVIfC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Feb 2021 03:35:02 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210222083419epoutp032fbec553433ffcc420b53a332d59a7a2~mBNvtAD5J1798117981epoutp03W
        for <rcu@vger.kernel.org>; Mon, 22 Feb 2021 08:34:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210222083419epoutp032fbec553433ffcc420b53a332d59a7a2~mBNvtAD5J1798117981epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613982859;
        bh=UnWQByOkwotdD2M4krwLDT1HAWSlYFB+o4ap+vTzGm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s41XE5TAhXTsLbIM2AtlBX9qZ1+MnnRkqpC+4c0Nj7kAYcrzWs6DO9cU3uEmpHOql
         TdUazMaZ40LRBXAh8BLQuBhGr1KDejAV4VmdP/TrZsAX+eXgnwYkzzhJPsRV5FIm93
         cDHEZUUEzTg2xHrXEba44EDexd4qogG1sh9hle5Y=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210222083418epcas1p35acd2cf120dca570c75ebb01324f987e~mBNvC-G4J0037200372epcas1p3q;
        Mon, 22 Feb 2021 08:34:18 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.159]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Dkb7s337rz4x9Pw; Mon, 22 Feb
        2021 08:34:17 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.04.63458.98C63306; Mon, 22 Feb 2021 17:34:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210222083416epcas1p2c4d51fc7a793729c08e424f13077954a~mBNtoOwKc2963329633epcas1p29;
        Mon, 22 Feb 2021 08:34:16 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210222083416epsmtrp241adecaabd4ae0a794a39b6c94d2865e~mBNtnTXG41246012460epsmtrp2k;
        Mon, 22 Feb 2021 08:34:16 +0000 (GMT)
X-AuditID: b6c32a36-6dfff7000000f7e2-23-60336c89b1f3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.16.08745.88C63306; Mon, 22 Feb 2021 17:34:16 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.183]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210222083416epsmtip2163042ef771716005f6b4e192351e7f7~mBNtYjYnE2060420604epsmtip2a;
        Mon, 22 Feb 2021 08:34:16 +0000 (GMT)
From:   Sangmoon Kim <sangmoon.kim@samsung.com>
To:     paulmck@kernel.org
Cc:     jiangshanlai@gmail.com, joel@joelfernandes.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        neeraju@codeaurora.org, rcu@vger.kernel.org, rostedt@goodmis.org,
        sangmoon.kim@samsung.com
Subject: Re: [PATCH] rcu/tree: Add a trace event for RCU stall warnings
Date:   Mon, 22 Feb 2021 17:25:39 +0900
Message-Id: <20210222082539.15573-1-sangmoon.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218185926.GV2743@paulmck-ThinkPad-P72>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmgW5njnGCQf96UYupa3czWSxrULX4
        vyDfYvPZM8wW/UuXs1t8WvKNxeLs7HOsFvs6HjBZ3HrQyOLA6XG5r5fJY+npN2weO2fdZfdo
        2XeL3WPhp6+sHrde23psWtXJ5tG3ZRWjx+dNcgGcUTk2GamJKalFCql5yfkpmXnptkrewfHO
        8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUAXKimUJeaUAoUCEouLlfTtbIryS0tSFTLyi0ts
        lVILUnIKDA0K9IoTc4tL89L1kvNzrQwNDIxMgSoTcjK+3uxiLpgiWHHt/WT2BsZdvF2MHBwS
        AiYSpz4ldDFycQgJ7GCUeDXnEiuE84lR4t/V3WwQzmdGidmNP4EcTrCOsw8XQlXtYpR4smse
        M0hCSOALo8SjH6kgNpuArsSXeZcZQWwRATGJPad2M4M0MAucZJSYMLkJbJKwgLtE07Z97CA2
        i4CqxKSeWWCDeAVsJXqefGeH2CYvsXrDAbA4p4ClxOMjX8A2Swj8ZJc4OvMc1EkuEs9XdbBC
        2MISr45vgWqWkvj8bi9UzT5GiT0rZSCapzBKLJ+yA6rIWKK35wIzKDSYBTQl1u/ShwgrSuz8
        PRfsA2YBPol3X3tYIQHGK9HRJgRRoibx+NVdRghbRqL/znwWCNtD4vuSt8yQEOphlFjYvIN5
        AqPcLIQNCxgZVzGKpRYU56anFhsWGCFH2SZGcBrUMtvBOOntB71DjEwcjIcYJTiYlUR42e4a
        JQjxpiRWVqUW5ccXleakFh9iNAWG3kRmKdHkfGAiziuJNzQ1MjY2tjAxMzczNVYS5000eBAv
        JJCeWJKanZpakFoE08fEwSnVwBTyiIvLcknKmTk3XHW8pXS45DK1QkSfcbVM2Zr3/GoVz+nQ
        65MPXLmxc1uR/cyderPTU7Vvaoj/SbN/r1RqP8PwzJ2QY6GfGrMvN319+LR0YZyTa/acQ9sk
        d91euUCEQduYQ/ZeCutj9tdVTC1XfC2mpMtGBP9o6mxh5PjLPsF+R8uV9wFfi3tmMgRNXiG7
        TeuXVWT5pmSf7MKZv/1+ZXkemBb4Tfxd5f0pd51sHN4+DE+/H8zVGrVyT1Hz/PsXXm+fuGjf
        rmubFXYfazZY8Nkly3/R60Xlb8PdQ0NbNZ8YM5071nKiQ/3e8X4OrYk+0SbB7Z+tM8ra8t56
        9dZV3e7m2fts5ftlj2Kv7OgLFFBiKc5INNRiLipOBAA7iWuNDAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSvG5HjnGCwZQNWhZT1+5msljWoGrx
        f0G+xeazZ5gt+pcuZ7f4tOQbi8XZ2edYLfZ1PGCyuPWgkcWB0+NyXy+Tx9LTb9g8ds66y+7R
        su8Wu8fCT19ZPW69tvXYtKqTzaNvyypGj8+b5AI4o7hsUlJzMstSi/TtErgyvt7sYi6YIlhx
        7f1k9gbGXbxdjJwcEgImEmcfLmTtYuTiEBLYwSixYu4cFoiEjMTOi5uZuhg5gGxhicOHi0HC
        QgKfGCU6r4WB2GwCuhJf5l1mBLFFBMQk9pzazQwyh1ngMqPEsmUPmEASwgLuEk3b9rGD2CwC
        qhKTemYxg9i8ArYSPU++s0PskpdYveEAWJxTwFLi8ZEvrBDLLCSW/r3JNIGRbwEjwypGydSC
        4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOBQ1dLawbhn1Qe9Q4xMHIyHGCU4mJVEeNnuGiUI
        8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwLRvSktox+l3
        a/5/0ell0X9kc3dJ/RurKZfip+8VurzhcPW1/bq93Cou+Y1vjB5W6Yh158oJVhya+bdrPe8G
        zsmxM7c0lEprHJsYOuODwqlru2Q9g9KqD3dMPPDe5P2sayKTV7VJytzvntGeaOmhc2uy+HP7
        iANNCiwp6buXTArxctnbuPW2p7d+g+UDATbDXSpekbrpGxRflYQ3/7DRc17po72cL/9gX8OK
        7f5vLD5zTb/73PHeOT1+3iKdSeuP6XtXrtjp8uhWzMESb2m5Y3u/qq92fm/TaHns24eL/Ite
        5/4S0l27O/DhStunrPcPz/oVsP1ReQLb/+0yAULrr39adeHULPkP4UunzT757YyeEktxRqKh
        FnNRcSIA9KhV8MQCAAA=
X-CMS-MailID: 20210222083416epcas1p2c4d51fc7a793729c08e424f13077954a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210222083416epcas1p2c4d51fc7a793729c08e424f13077954a
References: <20210218185926.GV2743@paulmck-ThinkPad-P72>
        <CGME20210222083416epcas1p2c4d51fc7a793729c08e424f13077954a@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> -----Original Message-----
> From: Paul E. McKenney <paulmck@kernel.org>
> Sent: Friday, February 19, 2021 3:59 AM
> 
> On Thu, Feb 18, 2021 at 01:24:16PM -0500, Steven Rostedt wrote:
> > On Thu, 18 Feb 2021 09:00:12 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >
> > > OK, I will bite.  ;-)
> >
> > Do I turn into a wearwolf?
> 
> Maybe even a wash-n-wear wolf.  ;-)
> 
> > > Can the saving of console into trace buffers be easily enabled and
> > > disabled within the code?
> >
> > Well, we do have this for ftrace:
> >
> >  echo 'enable_event:printk:console' > events/rcu/rcu_stall_warning/trigger
> >
> > Would enable the printk console to be traced to the ring buffer once the
> > stall is triggered, and not before hand.
> >
> > >  If so, does enabling and disabling nest?
> >
> > It has a disable as well, but unfortunately its global and does not nest.
> > We could always implement a percpu trigger that can nest though.
> 
> So Sangmoon could have a module react to an RCU CPU stall warning
> tracepoint by turning on tracing of console messages.  If there was a
> start-stop pair of RCU CPU stall warning tracepoints, he could turn it
> off as well.
> 
> Not sure if that is what Sangmoon is looking for, but it is a possibility.
> 
> 							Thanx, Paul

Thank you. I'm learning the new things through this review.

Copying console messages is not really necessary to me. I wanted to say
this tracepoint can also be used in such way for debugging purpose.

What I need is that a module records the stall happening and report the
stall event when kernel panic occurred. Of course, there is no detailed
information there, but it helps developers to recognize that the stall
has occurred in the system.

The usage scenario is as follows.
There is a kernel module for debugging.
The module registers a probe function using register_trace_rcu_stall_warning().
When a stall warning event occurs, the module records the event into its own buffer.
When a kernel panic occurs, the developers can see the report generated
by the module and can also see the buffer of the module directly through Ramdump.

Thanks,
Sangmoon
