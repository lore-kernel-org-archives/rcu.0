Return-Path: <SRS0=jzWG=WP=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B20EC3A5A0
	for <rcu@archiver.kernel.org>; Mon, 19 Aug 2019 22:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA76F22CE8
	for <rcu@archiver.kernel.org>; Mon, 19 Aug 2019 22:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfHSWbB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Aug 2019 18:31:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728402AbfHSWbB (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 19 Aug 2019 18:31:01 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JMRNBh069135;
        Mon, 19 Aug 2019 18:30:58 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ug0x1gb3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 18:30:57 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7JMU0t6032331;
        Mon, 19 Aug 2019 22:30:56 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04wdc.us.ibm.com with ESMTP id 2ufye01hsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 22:30:56 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7JMUuvh48365856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 22:30:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C901B205F;
        Mon, 19 Aug 2019 22:30:56 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EB39B2064;
        Mon, 19 Aug 2019 22:30:56 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 19 Aug 2019 22:30:56 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B87D616C3882; Mon, 19 Aug 2019 15:31:00 -0700 (PDT)
Date:   Mon, 19 Aug 2019 15:31:00 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190819223100.GI28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190811211318.GX28441@linux.ibm.com>
 <20190812032142.GA171001@google.com>
 <20190812035306.GE28441@linux.ibm.com>
 <20190812212013.GB48751@google.com>
 <20190812230138.GS28441@linux.ibm.com>
 <20190813010249.GA129011@google.com>
 <20190815171714.GA1023@linux.ibm.com>
 <20190815200432.GB23194@google.com>
 <20190815203107.GL28441@linux.ibm.com>
 <20190819165710.GF27088@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819165710.GF27088@lenoir>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190222
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 19, 2019 at 06:57:10PM +0200, Frederic Weisbecker wrote:
> On Thu, Aug 15, 2019 at 01:31:07PM -0700, Paul E. McKenney wrote:
> > On Thu, Aug 15, 2019 at 04:04:32PM -0400, Joel Fernandes wrote:
> > > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > > index be9707f68024..e697c7a2ce67 100644
> > > --- a/kernel/time/tick-sched.c
> > > +++ b/kernel/time/tick-sched.c
> > > @@ -198,6 +198,10 @@ static bool check_tick_dependency(atomic_t *dep)
> > >  		return true;
> > >  	}
> > >  
> > > +	if (val & TICK_DEP_MASK_CLOCK_RCU) {
> > > +		return true;
> > > +	}
> > > +
> > >  	return false;
> > >  }
> > 
> > That one is not in my tree, either.  Frederic, should I add this to
> > your patch?  For that matter, may I add your Signed-off-by as well?
> > Your original is in my -rcu tree at:
> > 
> > 0cb41806c799 ("EXP nohz: Add TICK_DEP_BIT_RCU")
> > 
> > I am testing Joel's suggested addition now.
> 
> Also this:

Good point, added!

							Thanx, Paul

> diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
> index b7a904825e7d..295517f109d7 100644
> --- a/include/trace/events/timer.h
> +++ b/include/trace/events/timer.h
> @@ -367,7 +367,8 @@ TRACE_EVENT(itimer_expire,
>  		tick_dep_name(POSIX_TIMER)		\
>  		tick_dep_name(PERF_EVENTS)		\
>  		tick_dep_name(SCHED)			\
> -		tick_dep_name_end(CLOCK_UNSTABLE)
> +		tick_dep_name(CLOCK_UNSTABLE)		\
> +		tick_dep_name_end(RCU)
>  
>  #undef tick_dep_name
>  #undef tick_dep_mask_name
> 
