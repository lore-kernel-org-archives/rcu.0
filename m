Return-Path: <SRS0=mJfo=S4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEEBC43219
	for <rcu@archiver.kernel.org>; Fri, 26 Apr 2019 13:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266122084F
	for <rcu@archiver.kernel.org>; Fri, 26 Apr 2019 13:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfDZNvG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:51:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726039AbfDZNvF (ORCPT
        <rfc822;rcu@vger.kernel.org>); Fri, 26 Apr 2019 09:51:05 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3QDovD4093628
        for <rcu@vger.kernel.org>; Fri, 26 Apr 2019 09:51:04 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s42tgss21-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Fri, 26 Apr 2019 09:51:03 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 26 Apr 2019 14:51:02 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 26 Apr 2019 14:51:00 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3QDoxHn18940104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 13:50:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D2B0B2066;
        Fri, 26 Apr 2019 13:50:59 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDEC8B2064;
        Fri, 26 Apr 2019 13:50:58 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.206.135])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 26 Apr 2019 13:50:58 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 86C2616C6B4C; Fri, 26 Apr 2019 06:50:58 -0700 (PDT)
Date:   Fri, 26 Apr 2019 06:50:58 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kselftest@vger.kernel.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] rcutorture: Tweak kvm options
Reply-To: paulmck@linux.ibm.com
References: <20190424073446.8577-1-bigeasy@linutronix.de>
 <20190424103809.GM3923@linux.ibm.com>
 <20190424183039.GA4494@linux.ibm.com>
 <20190425194638.GA7238@linux.ibm.com>
 <20190426105413.rajcon4vyzov446c@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426105413.rajcon4vyzov446c@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042613-0040-0000-0000-000004E79841
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010999; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01194664; UDB=6.00626372; IPR=6.00975500;
 MB=3.00026608; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-26 13:51:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042613-0041-0000-0000-000008F398DD
Message-Id: <20190426135058.GD3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904260096
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 26, 2019 at 12:54:14PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-04-25 12:46:38 [-0700], Paul E. McKenney wrote:
> > > And it doesn't like my (admittedly ancient) QEMU, complaining about not
> > > knowing about "x2apic=on,tsc-deadline=on,hypervisor=on,tsc_adjust=on".
> > > If I remove these, it works.  I will be upgrading soon (famous last
> > > words), so what I am going to do is queue the following separate
> > > not-for-upstream patch that makes it work on my setup.
> > 
> > Also, the !SMP scenarios get this:
> > 
> > :CONFIG_PARAVIRT_SPINLOCKS=y: improperly set
> 
> I ignored that (because there is a CHECK option to ensure that certain
> options are set).

True enough, but these things are a bit like compiler warnings in that
it is good to have a clean run.

> > Would it make sense to only set this on CONFIG_SMP=y runs?  The easy
> > way to do this is to move it from CFcommon to the scenario files not
> > having CONFIG_SMP=n.

(Which is how I am currently running, I should have added.)

> > having CONFIG_SMP=n.  Or would something else work better?
> > 
> > Or am I doing something wrong?
> 
> You should also get that warning on ARM for instance since those
> PARAVIRT SPINLOCKS are only implemented on x86.

OK, so we would want this to only be added for x86 runs.

> I have no numbers to compare the performance with and without that
> option. So we could drop that option or you tell me where to look after
> a run with/without that option so I can tell if it is worth the effort.

One place to look is in the summary output:

TREE01 ------- 17540 GPs (58.4667/s) [rcu: g130629 f0x0 ]

The "58.4667/s" is the number of grace periods per second.  I would be
surprised if CONFIG_PARAVIRT_SPINLOCKS made a noticeable difference in
grace-period rate (given the natural variation), but you never know.

							Thanx, Paul

