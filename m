Return-Path: <SRS0=tj9r=VA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E9AC0650E
	for <rcu@archiver.kernel.org>; Wed,  3 Jul 2019 16:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF2421882
	for <rcu@archiver.kernel.org>; Wed,  3 Jul 2019 16:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfGCQKf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:10:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbfGCQKe (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 3 Jul 2019 12:10:34 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63G7SaD006032
        for <rcu@vger.kernel.org>; Wed, 3 Jul 2019 12:10:33 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tgwnw5mnx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Wed, 03 Jul 2019 12:10:30 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 3 Jul 2019 17:10:29 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Jul 2019 17:10:25 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x63GAPAN48103730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Jul 2019 16:10:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECE7EB2065;
        Wed,  3 Jul 2019 16:10:24 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEBC0B205F;
        Wed,  3 Jul 2019 16:10:24 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  3 Jul 2019 16:10:24 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 351FF16C0D6C; Wed,  3 Jul 2019 09:10:26 -0700 (PDT)
Date:   Wed, 3 Jul 2019 09:10:26 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Normal RCU grace period can be stalled for long because
 need-resched flags not set?
Reply-To: paulmck@linux.ibm.com
References: <CAEXW_YTzPJptrLqx1zzouVSYpssE0JExDYLr+HRnPQco+9Tk2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTzPJptrLqx1zzouVSYpssE0JExDYLr+HRnPQco+9Tk2g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19070316-0060-0000-0000-000003588A01
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011372; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01226908; UDB=6.00645953; IPR=6.01008135;
 MB=3.00027569; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-03 16:10:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070316-0061-0000-0000-00004A005033
Message-Id: <20190703161026.GP26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030195
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 03, 2019 at 11:25:20AM -0400, Joel Fernandes wrote:
> Hi!
> I am measuring performance of the RCU consolidated vs RCU before the
> consolidation of flavors happened (just for fun and may be to talk
> about in a presentation).
> 
> What I did is I limited the readers/writers in rcuperf to run on all
> but one CPU. And then on that one CPU, I had a thread doing a
> preempt-disable + busy-wait + preempt_enable in a loop.

In a CONFIG_PREEMPT=y kernel?  (Guessing so because otherwise
preempt_enable() doesn't do all that much.)

Ah, and CONFIG_NO_HZ_FULL has an effect as well.

> I was hoping the preempt disable busy-wait thread would stall the
> regular readers, and it did.
> But what I noticed is that grace periods take 100-200 milliseconds to
> finish instead of the busy-wait time of 5-10 ms that I set. On closer
> examination, it looks like even though the preempt_enable happens in
> my loop, the need-resched flag is not set even though the grace period
> is long over due. So the thread does not reschedule.

The 100 milliseconds is expected behavior if there is not much of
anything else runnable on the busy-wait CPU, at least in recent
kernels.  So which kernel are you running?  ;-)

And on the need-resched flag not being set, is it possible that it was
set, but was cleared before you looked at it?  After all, the grace
period did end, which means that there was some sort of quiescent state
on the busy-waiting CPU.  And one quiescent state would be a pass
through the scheduler, which would clear the need-resched flag.

> For now, in my test I am just setting the need-resched flag manual
> after a busy wait.

Or are you saying that without your setting need-resched, you are getting
RCU CPU stall warnings?  Depending on exactly what you have in your
busy-wait loop, that might be expected behavior for CONFIG_PREEMPT=n
kernels.

> But I was thinking, can this really happen in real life? So, say a CPU
> is doing a lot of work in preempt_disable but is diligent enough to
> check need-resched flag periodically. I believe some spin-on-owner
> type locking primitives do this.

I believe that RCU handles this correctly.  Of course, after detecting
need-resched, the code must do something that allows the scheduler to
take appropriate action.  One approach is to simply call cond_resched()
periodically, which conveniently combines the need-resched check with
the transfer of control to the scheduler.

> Even though the thread is stalling the grace period, it has no clue
> because no one told it that a GP is in progress that is being held up.
> The tick interrupt for that thread returns rcu_need_deferred_qs()
> returns false during the preempt disable section. Can we do better for
> such usecases, such as even sending an IPI to the CPUs holding the
> Grace period? Or even upgrading the grace period to an expedited one
> if need be?

The tick interrupt will invoke rcu_sched_clock_irq(), which should take
care of things.  Unless this is a CONFIG_NO_HZ_FULL=y kernel, in which a
CPU running in the kernel might never take a scheduling-clock interrupt.
The RCU grace-period kthread checks for this and takes appropriate action
in rcu_implicit_dynticks_qs().

> Expedited grace periods did not have such issues. However I did notice
> that sometimes the Grace period would end not within 1 busy-wait
> duration but within 2. The distribution was strongly bi-modal to
> 1*busy-wait and 2*busy-wait durations for expedited tests. (This
> expedited test actually happened by accident, because the
> preempt-disable in my loop was delaying init enough that the whole
> test was running during init during which synchronize_rcu is upgraded
> to expedited).

I could imagine all sorts of ways that this might happen, but use of
event tracing or ftrace or trace_printk() might be a good next step here.

> I am sorry if this is not a realistic real-life problem, but more a
> "doctor it hurts if I do this" problem as Steven once said ;-)

Within the kernel, there are rules that you are supposed to follow, such
as cond_resched() or similar within long-running loops.  If you break
those rules, stop doing that.  Otherwise, RCU is supposed to handle it.
Within userspace, anything goes, and RCU is supposed to handle it.
Give or take random writes to /dev/mem and similar, anyway.

> I'll keep poking ;-)

Very good!

							Thanx, Paul

