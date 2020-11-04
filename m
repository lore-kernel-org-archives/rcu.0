Return-Path: <SRS0=XTmi=EK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCD1C2D0A3
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 12:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E5DB2236F
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 12:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sO6TyAte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgKDMMI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Nov 2020 07:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKDMMH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Nov 2020 07:12:07 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B517C0613D3;
        Wed,  4 Nov 2020 04:12:07 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id y184so24866052lfa.12;
        Wed, 04 Nov 2020 04:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zFxlkviNq8oY1JYiwmSh5Vs2myFF5OtsqFy2+LMGGlA=;
        b=sO6TyAteui5wdoT8yCsvcUvZVkNkk67zcseg3SyHI8KxSkD73sCLPXkSA0OIpG+H/D
         b53uDfygwEjofEHOLYCW+FIctHNovv6ZicvLQA46oSeW/oD2uHo4BHEA1HamDlK46zr1
         UGGslxQm2cziEU2yX/w/xlzHjF36omdjKO4+6z9WbqS51kqabnHqmarLLL8+tpueCSnh
         wFzmTXuQSxb+iPU5ZawSJdykJTrvo+ZLqNZ0+2XKuTulVaNK4hkdJFApja4/bMlcUp2c
         WzJ2oZ6fVWbOjmd5tjQYOfAy3AR/dYP1pWS6Voa7EbtSwWV+1kS8NgkCK2h0qALj8/S9
         YVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zFxlkviNq8oY1JYiwmSh5Vs2myFF5OtsqFy2+LMGGlA=;
        b=bzoM/4CM9FdLHfKsfAkACwOvydwtQ6HQudvYjDJ+VwjyXmS/9Q/oQnzo7NEvVnojk0
         3hdPxTnCxKPagpy708Iyd4uD8fmOxAlXboCaGu37MqYQKutpWNcwVqpEVfQKPgwIc7l8
         U2UeQvghsruT4q6A/N8Fza/ixcZKbFVNOjEABP8aIUbwgWHW4Y23AXSukcekOP9QgVsC
         ZktLCg27s5bEfYHUbvg7EAiRZ/CvIutt+yebu6AaBe2tvscbN4P4x7lnT97A4A4kF8yS
         KTS+8k1wVfX+rogrufrskgiB1QiwZZMnycDsPRIUJQF5bD3N9JBEb70Uvht2yw/m7ZJ9
         ye9g==
X-Gm-Message-State: AOAM53282xKHHSDVuOBbFsnhw8yYZ224eWRUdPz8m8/pEmxcZ8U4jfbW
        cviJIEFvdujpLmjkWkOKnN8=
X-Google-Smtp-Source: ABdhPJzklSAwEI5brLMtXwwy35EXqMl4O+dz0ngVRUUYFX6CW8nRdv4/seeFX58ly2xdXCiIlBHRLg==
X-Received: by 2002:a19:4c1:: with SMTP id 184mr8809966lfe.547.1604491925925;
        Wed, 04 Nov 2020 04:12:05 -0800 (PST)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id h11sm500174ljc.21.2020.11.04.04.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 04:12:05 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 4 Nov 2020 13:12:03 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
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
Message-ID: <20201104121203.GB17782@pc636>
References: <20201029165019.14218-1-urezki@gmail.com>
 <20201103175422.GB1310511@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103175422.GB1310511@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 03, 2020 at 12:54:22PM -0500, Joel Fernandes wrote:
> On Thu, Oct 29, 2020 at 05:50:04PM +0100, Uladzislau Rezki (Sony) wrote:
> > The current memmory-allocation interface presents to following
> > difficulties that this patch is designed to overcome
> [...]
> > ---
> >  kernel/rcu/tree.c | 109 ++++++++++++++++++++++++++++------------------
> >  1 file changed, 66 insertions(+), 43 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 06895ef85d69..f2da2a1cc716 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -177,7 +177,7 @@ module_param(rcu_unlock_delay, int, 0444);
> >   * per-CPU. Object size is equal to one page. This value
> >   * can be changed at boot time.
> >   */
> > -static int rcu_min_cached_objs = 2;
> > +static int rcu_min_cached_objs = 5;
> >  module_param(rcu_min_cached_objs, int, 0444);
> >  
> >  /* Retrieve RCU kthreads priority for rcutorture */
> > @@ -3084,6 +3084,9 @@ struct kfree_rcu_cpu_work {
> >   *	In order to save some per-cpu space the list is singular.
> >   *	Even though it is lockless an access has to be protected by the
> >   *	per-cpu lock.
> > + * @page_cache_work: A work to refill the cache when it is empty
> > + * @work_in_progress: Indicates that page_cache_work is running
> > + * @hrtimer: A hrtimer for scheduling a page_cache_work
> >   * @nr_bkv_objs: number of allocated objects at @bkvcache.
> >   *
> >   * This is a per-CPU structure.  The reason that it is not included in
> > @@ -3100,6 +3103,11 @@ struct kfree_rcu_cpu {
> >  	bool monitor_todo;
> >  	bool initialized;
> >  	int count;
> > +
> > +	struct work_struct page_cache_work;
> > +	atomic_t work_in_progress;
> 
> Does it need to be atomic? run_page_cache_work() is only called under a lock.
> You can use xchg() there. And when you do the atomic_set, you can use
> WRITE_ONCE as it is a data-race.
> 
We can use xchg together with *_ONCE() macro. Could you please clarify what
is your concern about using atomic_t? Both xchg() and atomic_xchg() guarantee
atamarity. Same as WRITE_ONCE() or atomic_set().

> > @@ -4449,24 +4482,14 @@ static void __init kfree_rcu_batch_init(void)
> >  
> >  	for_each_possible_cpu(cpu) {
> >  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > -		struct kvfree_rcu_bulk_data *bnode;
> >  
> >  		for (i = 0; i < KFREE_N_BATCHES; i++) {
> >  			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
> >  			krcp->krw_arr[i].krcp = krcp;
> >  		}
> >  
> > -		for (i = 0; i < rcu_min_cached_objs; i++) {
> > -			bnode = (struct kvfree_rcu_bulk_data *)
> > -				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > -
> > -			if (bnode)
> > -				put_cached_bnode(krcp, bnode);
> > -			else
> > -				pr_err("Failed to preallocate for %d CPU!\n", cpu);
> > -		}
> > -
> >  		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
> > +		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
> >  		krcp->initialized = true;
> 
> During initialization, is it not better to still pre-allocate? That way you
> don't have to wait to get into a situation where you need to initially
> allocate.
> 
Since we have a worker that does it when a cache is empty there is no
a high need in doing it during initialization phase. If we can reduce
an amount of code it is always good :)

Thanks, Joel.

--
Vlad Rezki
