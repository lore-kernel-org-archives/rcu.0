Return-Path: <SRS0=XTmi=EK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81129C2D0A3
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 18:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25BBB20719
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 18:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKHti6FF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbgKDSiw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Nov 2020 13:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbgKDSiw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Nov 2020 13:38:52 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390CDC0613D3;
        Wed,  4 Nov 2020 10:38:52 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id v144so696427lfa.13;
        Wed, 04 Nov 2020 10:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xfi4qxxkzLVx6Fda8dTuV56C6Q45OB8JjOkkvYWDxcA=;
        b=qKHti6FFatoAvB6uvUNrOsTcqB0oQwEvC/PyqDBjC3skECHacFwxRe/91ZSgMzORHR
         N/Ot8nmikv7BKbEoND3ssvjEJV1tQTL3Llm/bBele5OAEsF3Eh3wHnMBuj725XA97sKd
         CICulThfZxHH0r2UJjTjAWY61OGcnIKR2UpxTPVpj0AfD+AzkQG1QrHdQ2VRphe3dVrZ
         3AxzYecDZvl+4qIKw5gZoUgw74y4HIjMeIuDC375OeTjyydBKpDo20pxRAgJhiyEUyE+
         G3da9h5zvx7nLbDAWQdxjYfS8RqWLccw9k9lMPvowZccn00WGptt05mN5FRPT/JqEMTa
         EOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xfi4qxxkzLVx6Fda8dTuV56C6Q45OB8JjOkkvYWDxcA=;
        b=meh8RR/raktqGaO24RWnAU9ljZ/HBH2lX97dkVqqia/NvM2R0jyRFUGBPZzM2mXsRv
         fUEocgCi05vkmpZF4EzxRidpPF+fcjbIGujDZemEh4PaKoAtXU8hIDtUOyTo3HjKQOMU
         2C2pBVwNtV7uk9jvM5jWP7I1VzP1bbnI7AuNck4B8iYSSHr9byVEEiDO+WuRhYyvtT0V
         osmbPwotINhSr/4LO+wVe9kQ6nV4wjdCKXmI7bcW49iINZKvrqQhynvqFmHERl1F1qk+
         FmjckDCtaUrCaBM/jMZ0gQM7I2bP+eVt0aTeydFssNauJk3ud51fQTmCYy3IUBPGUCa1
         7dSw==
X-Gm-Message-State: AOAM530N1/zLBqn8hpQUU/AnPsngwuRVxHnja6m2g2xAryr/TQ1D1jgZ
        Q0A0iz0AhyowkcWyM90L4iY=
X-Google-Smtp-Source: ABdhPJyz4uPm+H1FdYufmvJr76WXfsCBJaTGjPhdvjwasZpI8rf+f4VXHNR33JijOFFTjRFsn7WnUA==
X-Received: by 2002:a19:4f5e:: with SMTP id a30mr1242847lfk.64.1604515130698;
        Wed, 04 Nov 2020 10:38:50 -0800 (PST)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id u22sm591592ljk.45.2020.11.04.10.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 10:38:49 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 4 Nov 2020 19:38:47 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 01/16] rcu/tree: Add a work to allocate pages from
 regular context
Message-ID: <20201104183847.GA22933@pc636>
References: <20201029165019.14218-1-urezki@gmail.com>
 <20201103175422.GB1310511@google.com>
 <20201104121203.GB17782@pc636>
 <20201104150143.GB2313912@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104150143.GB2313912@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > > >   * This is a per-CPU structure.  The reason that it is not included in
> > > > @@ -3100,6 +3103,11 @@ struct kfree_rcu_cpu {
> > > >  	bool monitor_todo;
> > > >  	bool initialized;
> > > >  	int count;
> > > > +
> > > > +	struct work_struct page_cache_work;
> > > > +	atomic_t work_in_progress;
> > > 
> > > Does it need to be atomic? run_page_cache_work() is only called under a lock.
> > > You can use xchg() there. And when you do the atomic_set, you can use
> > > WRITE_ONCE as it is a data-race.
> > > 
> > We can use xchg together with *_ONCE() macro. Could you please clarify what
> > is your concern about using atomic_t? Both xchg() and atomic_xchg() guarantee
> > atamarity. Same as WRITE_ONCE() or atomic_set().
> 
> Right, whether there's lock or not does not matter as xchg() is also
> atomic-swap.
> 
> atomic_t is a more complex type though, I would directly use int since
> atomic_t is not needed here and there's no lost-update issue here. It could
> be matter of style as well.
> 
> BTW I did think atomic_xchg() adds additional memory barriers
> but I could not find that to be the case in the implementation. Is that not
> the case? Docs says "atomic_xchg must provide explicit memory barriers around
> the operation.".
> 
In most of the systems atmoc_xchg() is same as xchg() and atomic_set()
is same as WRITE_ONCE(). But there are exceptions, for example "parisc"

*** arch/parisc/include/asm/atomic.h:
<snip>
...
#define _atomic_spin_lock_irqsave(l,f) do { \
    arch_spinlock_t *s = ATOMIC_HASH(l); \
    local_irq_save(f);   \
    arch_spin_lock(s);   \
} while(0)
...
static __inline__ void atomic_set(atomic_t *v, int i)
{
     unsigned long flags;
     _atomic_spin_lock_irqsave(v, flags);

     v->counter = i;

     _atomic_spin_unlock_irqrestore(v, flags);
}
<snip>

I will switch to xchg() and WRITE_ONCE(), because of such specific ARCHs.

> > > > @@ -4449,24 +4482,14 @@ static void __init kfree_rcu_batch_init(void)
> > > >  
> > > >  	for_each_possible_cpu(cpu) {
> > > >  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > > > -		struct kvfree_rcu_bulk_data *bnode;
> > > >  
> > > >  		for (i = 0; i < KFREE_N_BATCHES; i++) {
> > > >  			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
> > > >  			krcp->krw_arr[i].krcp = krcp;
> > > >  		}
> > > >  
> > > > -		for (i = 0; i < rcu_min_cached_objs; i++) {
> > > > -			bnode = (struct kvfree_rcu_bulk_data *)
> > > > -				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > > > -
> > > > -			if (bnode)
> > > > -				put_cached_bnode(krcp, bnode);
> > > > -			else
> > > > -				pr_err("Failed to preallocate for %d CPU!\n", cpu);
> > > > -		}
> > > > -
> > > >  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
> > > > +		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
> > > >  		krcp->initialized = true;
> > > 
> > > During initialization, is it not better to still pre-allocate? That way you
> > > don't have to wait to get into a situation where you need to initially
> > > allocate.
> > > 
> > Since we have a worker that does it when a cache is empty there is no
> > a high need in doing it during initialization phase. If we can reduce
> > an amount of code it is always good :)
> 
> I am all for not having more code than needed. But you would hit
> synchronize_rcu() slow path immediately on first headless kfree_rcu() right?
> That seems like a step back from the current code :)
> 
As for slow path and hitting the synchronize_rcu() immediately. Yes, a slow 
hit "counter" will be increased by 1, the difference between two variants
will be N and N + 1 times. I do not consider N + 1 as a big difference and
impact on performance.

Should we guarantee that a first user does not hit a fallback path that
invokes synchronize_rcu()? If not, i would rather remove redundant code.

Any thoughts here?

Thanks!

--
Vlad Rezki
