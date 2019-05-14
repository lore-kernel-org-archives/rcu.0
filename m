Return-Path: <SRS0=dAg3=TO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B5CC04AB4
	for <rcu@archiver.kernel.org>; Tue, 14 May 2019 22:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EEE20578
	for <rcu@archiver.kernel.org>; Tue, 14 May 2019 22:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfENWUX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 14 May 2019 18:20:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726211AbfENWUW (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 14 May 2019 18:20:22 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4EMBxhu030429;
        Tue, 14 May 2019 18:20:21 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sg4n9usnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 May 2019 18:20:20 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x4EG7Jap007386;
        Tue, 14 May 2019 16:24:42 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 2sdp14s100-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 May 2019 16:24:42 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4EMKJ1a35586090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 22:20:19 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B89EB2068;
        Tue, 14 May 2019 22:20:19 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2BECB2065;
        Tue, 14 May 2019 22:20:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 14 May 2019 22:20:18 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B7FAC16C5E28; Tue, 14 May 2019 15:20:18 -0700 (PDT)
Date:   Tue, 14 May 2019 15:20:18 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org
Subject: Re: Should list_entry_rcu use rcu_dereference ?
Message-ID: <20190514222018.GD4184@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190504185944.GA79652@google.com>
 <20190506235430.GA3923@linux.ibm.com>
 <20190513033017.GA96252@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513033017.GA96252@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905140146
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, May 12, 2019 at 11:30:17PM -0400, Joel Fernandes wrote:
> Hi Paul,
> 
> On Mon, May 06, 2019 at 04:54:30PM -0700, Paul E. McKenney wrote:
> > > Looking at the list_entry_rcu primitive, I see it does direct READ_ONCE
> > > on ptr. That's Ok, but rcu_dereference also does additional lockdep and
> > > sparse checking.  Why not call rcu_dereference instead of READ_ONCE? The
> > > pointer may be dereference by the caller so IMO makes sense to check.
> > > 
> > > Here is the definition of list_entry_rcu:
> > > /**
> > >  * list_entry_rcu - get the struct for this entry
> > >  [snip]
> > > * This primitive may safely run concurrently with the _rcu list-mutation
> > >  * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
> > >  */
> > > #define list_entry_rcu(ptr, type, member) \
> > > 	container_of(READ_ONCE(ptr), type, member)
> > > 
> > > Also, I was curious why hlist_for_each_entry_rcu() uses rcu_dereference_raw()
> > > while __hlist_for_each_rcu)_ uses rcu_dereference(). I feel both should use
> > > rcu_dereference to have the lockdep checking. Is this not done due to
> > > performance reasons?
> > > 
> > > thanks!
> > > 
> > >   - Joel
> > 
> > The issue is that most of the RCU list macros are generic over the RCU
> > read-side flavors.  We could have created _bh and _sched variants of all
> > of these, but that seemed like way too much RCU API expansion at the time,
> > and still does.  This shows up in the sparse checking as well, so that
> > there is just __rcu instead of also being __rcu_bh and __rcu_sched.
> > 
> > Or are do you have a trick in mind that would allow lockdep checking
> > without RCU API expansion?
> 
> Sorry it took me a while to reply, I had it in mind to reply and was thinking
> about how to do it.
> 
> How about something like the following? It does cause some API expansion,
> however just one function: rcu_dereference_any().

You do also have rcu_read_lock_any_held() and rcu_dereference_any_check(),
but yes, fairly modest as API expansion goes.

>                                                   The purpose of this is to
> check if any RCU reader is active at all. I believe after the flavor
> consolidation effort, this is a sufficient condition from an RCU perspective.
> Having some lockdep checking is better than no lockdep checking so I think it
> is good to have. Let me know what you think about the below patch and I can
> roll into a proper patch and send it as well (with proper comments).
> 
> I was able to trigger the lockdep check by removing the preempt_disable()
> calls in ftrace_mod_get_kallsym() and insert some modules (PROVE_LOCKING and
> FUNCION_TRACE enabled).

The big question is "what would use these?".  Although it would be good
to replace uses of rcu_dereference_raw(), many of those are driven by a
desire to support both RCU and non-RCU use cases, where in the non-RCU
variant the user supplies the lock.

So would these actually see enough use to make their addition worthwhile?
If so, which uses are you thinking in terms of?

Sorry to be so skeptical, but it has not been that long since Linus
read me the riot act over RCU complexity.  ;-)

							Thanx, Paul

> ---8<-----------------------
> 
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index e91ec9ddcd30..334c625ef421 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -273,9 +273,12 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
>   *
>   * This primitive may safely run concurrently with the _rcu list-mutation
>   * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
> + *
> + * Use rcu_dereference_any() to ensure we are generically within an RCU reader
> + * section (whether sched, bh or regular).
>   */
>  #define list_entry_rcu(ptr, type, member) \
> -	container_of(READ_ONCE(ptr), type, member)
> +	container_of(rcu_dereference_any(ptr), type, member)
>  
>  /*
>   * Where are list_empty_rcu() and list_first_entry_rcu()?
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 922bb6848813..7481d93ed9bb 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -223,6 +223,7 @@ int debug_lockdep_rcu_enabled(void);
>  int rcu_read_lock_held(void);
>  int rcu_read_lock_bh_held(void);
>  int rcu_read_lock_sched_held(void);
> +int rcu_read_lock_any_held(void);
>  
>  #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>  
> @@ -243,6 +244,12 @@ static inline int rcu_read_lock_sched_held(void)
>  {
>  	return !preemptible();
>  }
> +
> +static inline int rcu_read_lock_any_held(void)
> +{
> +	return !preemptible();
> +}
> +
>  #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>  
>  #ifdef CONFIG_PROVE_RCU
> @@ -472,6 +479,10 @@ static inline void rcu_preempt_sleep_check(void) { }
>  	__rcu_dereference_check((p), (c) || rcu_read_lock_sched_held(), \
>  				__rcu)
>  
> +#define rcu_dereference_any_check(p, c) \
> +	__rcu_dereference_check((p), (c) || rcu_read_lock_any_held(), \
> +				__rcu)
> +
>  /*
>   * The tracing infrastructure traces RCU (we want that), but unfortunately
>   * some of the RCU checks causes tracing to lock up the system.
> @@ -525,6 +536,8 @@ static inline void rcu_preempt_sleep_check(void) { }
>   */
>  #define rcu_dereference_sched(p) rcu_dereference_sched_check(p, 0)
>  
> +#define rcu_dereference_any(p) rcu_dereference_any_check(p, 0)
> +
>  /**
>   * rcu_pointer_handoff() - Hand off a pointer from RCU to other mechanism
>   * @p: The pointer to hand off
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index c3bf44ba42e5..2dab75d34806 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -298,6 +298,31 @@ int rcu_read_lock_bh_held(void)
>  }
>  EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
>  
> +int rcu_read_lock_any_held(void)
> +{
> +	int lockdep_opinion = 0;
> +
> +	if (!debug_lockdep_rcu_enabled())
> +		return 1;
> +	if (!rcu_is_watching())
> +		return 0;
> +	if (!rcu_lockdep_current_cpu_online())
> +		return 0;
> +
> +	if (lock_is_held(&rcu_lock_map))
> +		return 1;
> +
> +	/* BH flavor */
> +	if (in_softirq() || irqs_disabled())
> +		return 1;
> +
> +	/* Sched flavor */
> +	if (debug_locks)
> +		lockdep_opinion = lock_is_held(&rcu_sched_lock_map);
> +	return lockdep_opinion || !preemptible();
> +}
> +EXPORT_SYMBOL_GPL(rcu_read_lock_any_held);
> +
>  #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>  
>  /**
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 
