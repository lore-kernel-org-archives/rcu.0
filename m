Return-Path: <SRS0=wSob=VD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0FAC0650E
	for <rcu@archiver.kernel.org>; Sat,  6 Jul 2019 18:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD3B2082F
	for <rcu@archiver.kernel.org>; Sat,  6 Jul 2019 18:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfGFSFh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 6 Jul 2019 14:05:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726966AbfGFSFh (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sat, 6 Jul 2019 14:05:37 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x66I1uHq039679
        for <rcu@vger.kernel.org>; Sat, 6 Jul 2019 14:05:35 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tjn8u7cd5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Sat, 06 Jul 2019 14:05:35 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 6 Jul 2019 19:05:35 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 6 Jul 2019 19:05:32 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x66I5VoH52232614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 6 Jul 2019 18:05:31 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AC7EB205F;
        Sat,  6 Jul 2019 18:05:31 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A977B2067;
        Sat,  6 Jul 2019 18:05:31 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.215.71])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat,  6 Jul 2019 18:05:31 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 106F716C1F1D; Sat,  6 Jul 2019 11:05:32 -0700 (PDT)
Date:   Sat, 6 Jul 2019 11:05:32 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: [attn: Steve] Re: Normal RCU grace period can be stalled for
 long because need-resched flags not set?
Reply-To: paulmck@linux.ibm.com
References: <20190704003213.GA218086@google.com>
 <20190704005009.GZ26519@linux.ibm.com>
 <20190704032454.GA259593@google.com>
 <20190704171315.GG26519@linux.ibm.com>
 <20190704185055.GA12919@google.com>
 <20190704221702.GL26519@linux.ibm.com>
 <20190705000830.GB12919@google.com>
 <20190705013045.GA141984@google.com>
 <20190705015726.GN26519@linux.ibm.com>
 <20190706121807.GB200542@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190706121807.GB200542@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19070618-0052-0000-0000-000003DB2CD2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011388; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01228361; UDB=6.00646837; IPR=6.01009612;
 MB=3.00027611; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-06 18:05:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070618-0053-0000-0000-000061976999
Message-Id: <20190706180532.GX26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907060240
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jul 06, 2019 at 08:18:07AM -0400, Joel Fernandes wrote:
> On Thu, Jul 04, 2019 at 06:57:26PM -0700, Paul E. McKenney wrote:
> [snip]
> > > I tried again, if I make sure the ftrace dump absolutely does not happen
> > > until the preempt-disable loop is done marked by a new global variable as you
> > > pointed, then it fixes it. And I don't need any set_preempt_need_resched() or
> > > rcu_perf_shutdown_wait() in my preempt disable loop to fix it. Basically the
> > > below diff. However, it still does answer the question about why a parallel
> > > ftrace dump running in parallel with the still running preempt-disable loop
> > > caused some writers to have multi-second grace periods. I think something
> > > during the ftrace dump prevented the tick path of that loop CPU to set the
> > > need-resched flag. It is quite hard to trace because the problem itself is
> > > caused by tracing, so by the time the dump starts, the traces cannot be seen
> > > after that which are what would give a clue here.
> > 
> > Hmmm...  Doesn't ftrace_dump() iterate through the trace buffer with
> > interrupts disabled or some such?  If so, that would fully explain
> > its delaying RCU grace periods.
> 
> Looking through the ftrace_dump() code, I don't see any interrupt disabled
> happening, and in this case it would be happening on a different CPU than my
> preempt disable loop anyway since that loop runs on a CPU I reserved, and the
> writer thread doing the dump runs on a different CPU. So it is a bit odd that
> the presence of my preempt disable loop effects anything. No having the
> preempt disable loop in the first place, does not have this issue.
> 
> (Also added "attn: Steve" for the tracing question, to get his attention
> since this thread is very long).
> Steven, any thoughts on how rcu_ftrace_dump() can affect grace-period
> durations or other RCU parts? Do you see how it could impact the RCU GP
> thread if at all? I did setup RT priority 10 for the thread.

I see a local_irq_save() a few lines into ftrace_dump() itself.  Am I
missing where interrupts are being re-enabled prior to the trace-dump
loop?

							Thanx, Paul

