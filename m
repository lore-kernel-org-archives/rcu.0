Return-Path: <SRS0=/QKf=TY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BA8C072B5
	for <rcu@archiver.kernel.org>; Fri, 24 May 2019 17:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1910F21848
	for <rcu@archiver.kernel.org>; Fri, 24 May 2019 17:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbfEXRdK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 24 May 2019 13:33:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725923AbfEXRdK (ORCPT
        <rfc822;rcu@vger.kernel.org>); Fri, 24 May 2019 13:33:10 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4OHVuNd001610
        for <rcu@vger.kernel.org>; Fri, 24 May 2019 13:33:09 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2spjbn00mu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <rcu@vger.kernel.org>; Fri, 24 May 2019 13:33:09 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <rcu@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 24 May 2019 18:33:08 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 May 2019 18:33:06 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4OHX5ZI32440730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 17:33:05 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3734BB2067;
        Fri, 24 May 2019 17:33:05 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A92CB2065;
        Fri, 24 May 2019 17:33:05 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 24 May 2019 17:33:04 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8708016C5E05; Fri, 24 May 2019 10:33:06 -0700 (PDT)
Date:   Fri, 24 May 2019 10:33:06 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org
Subject: Re: Should list_entry_rcu use rcu_dereference ?
Reply-To: paulmck@linux.ibm.com
References: <20190504185944.GA79652@google.com>
 <20190506235430.GA3923@linux.ibm.com>
 <20190513033017.GA96252@google.com>
 <20190514222018.GD4184@linux.ibm.com>
 <20190524080737.GA176324@google.com>
 <20190524165009.GB197789@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524165009.GB197789@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19052417-0052-0000-0000-000003C6888E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011156; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01208004; UDB=6.00634461; IPR=6.00988994;
 MB=3.00027034; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-24 17:33:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052417-0053-0000-0000-00006107E861
Message-Id: <20190524173306.GD28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905240114
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 24, 2019 at 12:50:09PM -0400, Joel Fernandes wrote:
> On Fri, May 24, 2019 at 04:07:37AM -0400, Joel Fernandes wrote:
> [snip]
> > > > The purpose of this is to
> > > > check if any RCU reader is active at all. I believe after the flavor
> > > > consolidation effort, this is a sufficient condition from an RCU perspective.
> > > > Having some lockdep checking is better than no lockdep checking so I think it
> > > > is good to have. Let me know what you think about the below patch and I can
> > > > roll into a proper patch and send it as well (with proper comments).
> > > > 
> > > > I was able to trigger the lockdep check by removing the preempt_disable()
> > > > calls in ftrace_mod_get_kallsym() and insert some modules (PROVE_LOCKING and
> > > > FUNCION_TRACE enabled).
> > > 
> > > The big question is "what would use these?".  Although it would be good
> > > to replace uses of rcu_dereference_raw(), many of those are driven by a
> > > desire to support both RCU and non-RCU use cases, where in the non-RCU
> > > variant the user supplies the lock.
> > > 
> > > So would these actually see enough use to make their addition worthwhile?
> > > If so, which uses are you thinking in terms of?
> > 
> > Yes true. Actually my initial intent was to add some lockdep checking for
> > RCU-list traversal via list_for_each_entry_rcu(). Since the pointers are
> > traversed without any lockdep checking due to not going through the
> > rcu_dereference API family.
> > 
> > You are right the patch I shared is complicated, and I could just keep the
> > rcu_read_lock_any_held() and use that in list_for_each_entry_rcu for that
> > matter (and in any other list RCU APIs doing list traversals). In fact I
> > could probably also call this new API as: lockdep_assert_rcu_held().
> > 
> > Also I noticed there is a rcu_lockdep_assert() mentioned in the
> > Requirements.html part of the documentation, but didn't find such a
> > definition in the kernel sources. So we should probably also update that ;-)
> 
> And I see rcu_lockdep_assert() got converted to RCU_LOCKDEP_WARN in
> https://lore.kernel.org/patchwork/patch/580641/
> 
> I will toy with the idea of a lockdep_assert_rcu_held() which checks for
> consolidated RCU reader sections and use that for list RCU and such, and we
> can discuss more on the subsequent RFC.

Interesting...

RCU is now out of sync with the other lockdep assertions, but at Ingo
Molnar's request a few years back.  ;-)

							Thanx, Paul

> thanks!
> 
> 
> > 
> > From Requirements.html:
> > 	A given function might wish to check for RCU-related preconditions
> > 	upon entry, before using any other RCU API.
> > 	The <tt>rcu_lockdep_assert()</tt> does this job,
> > 	asserting the expression in kernels having lockdep enabled
> > 	and doing nothing otherwise.
> > 
> > > Sorry to be so skeptical, but it has not been that long since Linus
> > > read me the riot act over RCU complexity.  ;-)
> > 
> > No problem, perfectly legit skepticism ;-)
> > 
> > thanks,
> > 
> >  - Joel
> > 
> > > 
> > > 							Thanx, Paul
> > > 
> > > > ---8<-----------------------
> > > > 
> > > > diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> > > > index e91ec9ddcd30..334c625ef421 100644
> > > > --- a/include/linux/rculist.h
> > > > +++ b/include/linux/rculist.h
> > > > @@ -273,9 +273,12 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
> > > >   *
> > > >   * This primitive may safely run concurrently with the _rcu list-mutation
> > > >   * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
> > > > + *
> > > > + * Use rcu_dereference_any() to ensure we are generically within an RCU reader
> > > > + * section (whether sched, bh or regular).
> > > >   */
> > > >  #define list_entry_rcu(ptr, type, member) \
> > > > -	container_of(READ_ONCE(ptr), type, member)
> > > > +	container_of(rcu_dereference_any(ptr), type, member)
> > > >  
> > > >  /*
> > > >   * Where are list_empty_rcu() and list_first_entry_rcu()?
> > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > index 922bb6848813..7481d93ed9bb 100644
> > > > --- a/include/linux/rcupdate.h
> > > > +++ b/include/linux/rcupdate.h
> > > > @@ -223,6 +223,7 @@ int debug_lockdep_rcu_enabled(void);
> > > >  int rcu_read_lock_held(void);
> > > >  int rcu_read_lock_bh_held(void);
> > > >  int rcu_read_lock_sched_held(void);
> > > > +int rcu_read_lock_any_held(void);
> > > >  
> > > >  #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> > > >  
> > > > @@ -243,6 +244,12 @@ static inline int rcu_read_lock_sched_held(void)
> > > >  {
> > > >  	return !preemptible();
> > > >  }
> > > > +
> > > > +static inline int rcu_read_lock_any_held(void)
> > > > +{
> > > > +	return !preemptible();
> > > > +}
> > > > +
> > > >  #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> > > >  
> > > >  #ifdef CONFIG_PROVE_RCU
> > > > @@ -472,6 +479,10 @@ static inline void rcu_preempt_sleep_check(void) { }
> > > >  	__rcu_dereference_check((p), (c) || rcu_read_lock_sched_held(), \
> > > >  				__rcu)
> > > >  
> > > > +#define rcu_dereference_any_check(p, c) \
> > > > +	__rcu_dereference_check((p), (c) || rcu_read_lock_any_held(), \
> > > > +				__rcu)
> > > > +
> > > >  /*
> > > >   * The tracing infrastructure traces RCU (we want that), but unfortunately
> > > >   * some of the RCU checks causes tracing to lock up the system.
> > > > @@ -525,6 +536,8 @@ static inline void rcu_preempt_sleep_check(void) { }
> > > >   */
> > > >  #define rcu_dereference_sched(p) rcu_dereference_sched_check(p, 0)
> > > >  
> > > > +#define rcu_dereference_any(p) rcu_dereference_any_check(p, 0)
> > > > +
> > > >  /**
> > > >   * rcu_pointer_handoff() - Hand off a pointer from RCU to other mechanism
> > > >   * @p: The pointer to hand off
> > > > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > > > index c3bf44ba42e5..2dab75d34806 100644
> > > > --- a/kernel/rcu/update.c
> > > > +++ b/kernel/rcu/update.c
> > > > @@ -298,6 +298,31 @@ int rcu_read_lock_bh_held(void)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
> > > >  
> > > > +int rcu_read_lock_any_held(void)
> > > > +{
> > > > +	int lockdep_opinion = 0;
> > > > +
> > > > +	if (!debug_lockdep_rcu_enabled())
> > > > +		return 1;
> > > > +	if (!rcu_is_watching())
> > > > +		return 0;
> > > > +	if (!rcu_lockdep_current_cpu_online())
> > > > +		return 0;
> > > > +
> > > > +	if (lock_is_held(&rcu_lock_map))
> > > > +		return 1;
> > > > +
> > > > +	/* BH flavor */
> > > > +	if (in_softirq() || irqs_disabled())
> > > > +		return 1;
> > > > +
> > > > +	/* Sched flavor */
> > > > +	if (debug_locks)
> > > > +		lockdep_opinion = lock_is_held(&rcu_sched_lock_map);
> > > > +	return lockdep_opinion || !preemptible();
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(rcu_read_lock_any_held);
> > > > +
> > > >  #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> > > >  
> > > >  /**
> > > > -- 
> > > > 2.21.0.1020.gf2820cf01a-goog
> > > > 
> 

