Return-Path: <SRS0=tj9r=VA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA8AC5B578
	for <rcu@archiver.kernel.org>; Wed,  3 Jul 2019 21:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF86218A0
	for <rcu@archiver.kernel.org>; Wed,  3 Jul 2019 21:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfGCV5T (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:57:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726736AbfGCV5S (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 3 Jul 2019 17:57:18 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63LqtCj067278
        for <rcu@vger.kernel.org>; Wed, 3 Jul 2019 17:57:17 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2th1m66acv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Wed, 03 Jul 2019 17:57:17 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 3 Jul 2019 22:57:16 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Jul 2019 22:57:13 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x63LvD8614942722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Jul 2019 21:57:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05284B2064;
        Wed,  3 Jul 2019 21:57:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C930AB205F;
        Wed,  3 Jul 2019 21:57:12 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  3 Jul 2019 21:57:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 91A9116C3792; Wed,  3 Jul 2019 14:57:14 -0700 (PDT)
Date:   Wed, 3 Jul 2019 14:57:14 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Normal RCU grace period can be stalled for long because
 need-resched flags not set?
Reply-To: paulmck@linux.ibm.com
References: <CAEXW_YTzPJptrLqx1zzouVSYpssE0JExDYLr+HRnPQco+9Tk2g@mail.gmail.com>
 <20190703113036.04f6169d@gandalf.local.home>
 <20190703164134.GA125833@google.com>
 <20190703173935.GU26519@linux.ibm.com>
 <20190703212426.GC146386@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703212426.GC146386@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19070321-0052-0000-0000-000003DA0E56
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011374; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01227023; UDB=6.00646022; IPR=6.01008250;
 MB=3.00027574; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-03 21:57:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070321-0053-0000-0000-0000618EE1E2
Message-Id: <20190703215714.GW26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030267
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 03, 2019 at 05:24:26PM -0400, Joel Fernandes wrote:
> On Wed, Jul 03, 2019 at 10:39:35AM -0700, Paul E. McKenney wrote:
> > On Wed, Jul 03, 2019 at 12:41:34PM -0400, Joel Fernandes wrote:
> > > On Wed, Jul 03, 2019 at 11:30:36AM -0400, Steven Rostedt wrote:
> > > > On Wed, 3 Jul 2019 11:25:20 -0400
> > > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > 
> > > > 
> > > > > I am sorry if this is not a realistic real-life problem, but more a
> > > > > "doctor it hurts if I do this" problem as Steven once said ;-)
> > > > > 
> > > > > I'll keep poking ;-)
> > > > 
> > > > Hi Joel,
> > > > 
> > > > Can you also share the tests you are performing as well as any
> > > > module/code changes you made so that we can duplicate the results?
> > > 
> > > Sure thing. Below is the diff that I applied to Paul's /dev branch. But I
> > > believe Linus's tree should have same results.
> > > 
> > > After applying the diff below, I run it like this:
> > > tools/testing/selftests/rcutorture/bin/kvm.sh --bootargs rcuperf.pd_test=1 rcuperf.pd_busy_wait=5000 rcuperf.holdout=5 rcuperf.pd_resched=0 --duration 1 --torture rcuperf
> > > 
> > > Some new options I added:
> > > pd_test=1 runs the preempt disable loop test
> > > pd_busy_wait is the busy wait time each pass through the loop in microseconds
> > > pd_resched is whether the loop should set the need-resched flag periodically.
> > > 
> > > If your qemu is a bit old or from debian, then you may also need to pass: --qemu-args "-net nic,model=e1000"
> > > 
> > > With pd_resched = 0, I get quite high average grace-period latencies. The
> > > preempt-disable loop thread is running on its own CPU. Enabling the rcu:*
> > > tracepoints, I see that for long periods of time, the FQS rcu loop can be
> > > running while the scheduler tick learns from rcu_preempt_deferred_qs() that
> > > there's nothing to worry about (at least this is what I remember tracing).
> > > 
> > > With pd_resched = 0, the output of the command above:
> > > Average grace-period duration: 195629 microseconds
> > > Minimum grace-period duration: 30111.7
> > > 50th percentile grace-period duration: 211000
> > > 90th percentile grace-period duration: 218000
> > > 99th percentile grace-period duration: 222999
> > > Maximum grace-period duration: 236351
> > > 
> > > With pd_resched = 1, you get more like twice (10ms) the busy-wait time (5ms).
> > > I wonder why its twice, but that's still Ok. It is as follows:
> > > Average grace-period duration: 12302.2 microseconds
> > > Minimum grace-period duration: 5998.35
> > > 50th percentile grace-period duration: 12000.4
> > > 90th percentile grace-period duration: 15996.4
> > > 99th percentile grace-period duration: 18000.6
> > > Maximum grace-period duration: 20998.6
> > 
> > Both of these results are within the design range for normal
> > RCU grace-period durations on busy systems.  See the code in
> > adjust_jiffies_till_sched_qs(), which is setting one of the "panic
> > durations" at which RCU starts taking more aggressive actions to end
> > the current grace period.  See especially:
> > 
> > 	if (j < HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV)
> > 		j = HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV;
> > 	pr_info("RCU calculated value of scheduler-enlistment delay is %ld jiffies.\n", j);
> > 	WRITE_ONCE(jiffies_to_sched_qs, j);
> > 
> > This usually gets you about 100 milliseconds, and if you are starting
> > grace periods in quick succession from a single thread while other threads
> > are doing likewise, each grace-period wait gets to wait about two grace
> > periods worth due to the end of the previous grace period having started
> > a new grace period before the thread is awakened.
> > 
> > Of course, if this is causing trouble for some use case, it would not
> > be hard to create a tunable to override this panic duration.  But that
> > would of course require a real use case in real use, given that RCU isn't
> > exactly short on tunables at the moment.  Significantly shortening this
> > panic duration caused 0day to complain about slowness last I tried it,
> > just so you know.
> 
> Thanks a lot for the explanation.
> Indeed this code in the tick is doing a good job and I just had to drop
> jiffies_till_first_fqs to bring down the latencies. With a
> jiffies_till_first_fqs of 50 instead of the default of 100, the latencies
> drop by 4 fold.

You lost me on this one.  The normal value of jiffies_till_first_fqs
is but three, for systems with 255 or fewer CPUs and HZ=1000.  So I
have to ask...  What did you do to get jiffies_till_first_fqs=100?
The normal default automatic settings would need something like 8,000
CPUs to get it up to that level.

Or did you instead mean replacing the "HZ / 10" in the code snippet
above with "HZ / 20" or similar?

Or did you mean jiffies_to_sched_qs instead of jiffies_till_first_fqs?
-That- does default to 100, and you could set it using the
rcutree.jiffies_to_sched_qs kernel boot parameter.  But even then, I
must admit that I would naively expect halving jiffies_till_first_fqs to
halve the latencies.  But I have not looked at it closely, and there are
lots of moving parts in RCU's grace-period encouragement code, so maybe
that is the effect.

> In the tick:
>         if (smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs))) {
>                 /* Idle and userspace execution already are quiescent states. */
>                 if (!rcu_is_cpu_rrupt_from_idle() && !user) {
>                         set_preempt_need_resched();     <--------\
>                         set_tsk_need_resched(current);  <------- the preempt
> 								count test loop
> 								stands no chance!
>                 }
>                 __this_cpu_write(rcu_data.rcu_urgent_qs, false);
>         }

You got it!  That is indeed where it sets resched.

But if I understand what your preempt-count test loop consists of, RCU
would have a tough time with it in a CONFIG_PREEMPT=n kernel.

							Thanx, Paul

> Appreciate it! thanks,
> 
>  - Joel
> 

