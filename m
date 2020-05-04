Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1FDC47259
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D41DD206D9
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edtZ4Ym9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgEDM5N (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 08:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728980AbgEDM5J (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 4 May 2020 08:57:09 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACE7C061A0E;
        Mon,  4 May 2020 05:57:09 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id j14so9626599lfg.9;
        Mon, 04 May 2020 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZMBDUKN1IPbdPO/CEHSL+SWr7vslWkepMbASX1mJnEg=;
        b=edtZ4Ym9b9o54Zy9L8jra65OEMVcqj+V/vq8M/LGOf7Cx3kOKv+xWGzS/TkKBt7ASK
         l5yrWOoqzHxfyeSyl7l2Uv8pehXn9wp/jKGyZ20Hh9Di+raDmZzQnbBs6zcZ5Wp1gTG1
         m0KD+iCKsWKtAnm4Sz9Smxjnq0HRyHMVZQAcVwEjMSJbrbo6tLNoobZgracAWKNI2oKu
         fs2BZMn1z0pVLZDdFI44J8qIx5I4ge1xIIzjcvX+Y0fEApY+Iq4hbEOL7lpw8jJRYvRg
         m+Ae6H/7kiqfECN4sTZTO5fK7V8hVHzdwVeigYU/7OCOkC6LHzmh8z9nFXC01ErAoU1J
         9AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZMBDUKN1IPbdPO/CEHSL+SWr7vslWkepMbASX1mJnEg=;
        b=q1OqkemzQStjabF4cR1Da9dnWmbrXzSKhQlneXZZzknNgNkBJ6HqPLBY3uXG9FYm3i
         Ow9QDU86s0f5OZBTfqPqLHr2kizG3jPHPeT1D5/PYf5ThldDjCr5VxtSpg9EvTJPKWRg
         kOLcYknpRJH6pJ+01JJyldPG5l1arBBF5AaZub0e/v6QS+c3vBNXI1Xlv5wKqixuDAFQ
         y2O4Vt0fxCShIePvi/xyJ5CcBIm3Mxb5v9brFi44ahjvWKlygff21JqWNyNdKf0vb86l
         YcmxydHulB4t9QLnEehmv0iVU9sH2IMHbOfDVD8/QyrQsJIkb1LQBkLeOnfIIQInpfGk
         FLhw==
X-Gm-Message-State: AGi0PubH/LucihvGhUc33rLge2/mcXo+J6uYmXAxSq6NkP56us7+FJpT
        eEc3RsKGxyzhmmJNI36/oLw=
X-Google-Smtp-Source: APiQypIX7ltKY3b/CBEQHDORoKERSjgUrkHCSeKWALKSkgaoWXR4hES6gPfMVOCGR/0hYoKsV0RfVg==
X-Received: by 2002:ac2:5685:: with SMTP id 5mr4962737lfr.5.1588597027796;
        Mon, 04 May 2020 05:57:07 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id o16sm9600546lfi.58.2020.05.04.05.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 05:57:06 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 May 2020 14:57:04 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 19/24] rcu/tree: Support reclaim for head-less object
Message-ID: <20200504125704.GF17577@pc636>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-20-urezki@gmail.com>
 <20200501223909.GF7560@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501223909.GF7560@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 01, 2020 at 03:39:09PM -0700, Paul E. McKenney wrote:
> On Tue, Apr 28, 2020 at 10:58:58PM +0200, Uladzislau Rezki (Sony) wrote:
> > Update the kvfree_call_rcu() with head-less support, it
> > means an object without any rcu_head structure can be
> > reclaimed after GP.
> > 
> > To store pointers there are two chain-arrays maintained
> > one for SLAB and another one is for vmalloc. Both types
> > of objects(head-less variant and regular one) are placed
> > there based on the type.
> > 
> > It can be that maintaining of arrays becomes impossible
> > due to high memory pressure. For such reason there is an
> > emergency path. In that case objects with rcu_head inside
> > are just queued building one way list. Later on that list
> > is drained.
> > 
> > As for head-less variant. Such objects do not have any
> > rcu_head helper inside. Thus it is dynamically attached.
> > As a result an object consists of back-pointer and regular
> > rcu_head. It implies that emergency path can detect such
> > object type, therefore they are tagged. So a back-pointer
> > could be freed as well as dynamically attached wrapper.
> > 
> > Even though such approach requires dynamic memory it needs
> > only sizeof(unsigned long *) + sizeof(struct rcu_head) bytes,
> > thus SLAB is used to obtain it. Finally if attaching of the
> > rcu_head and queuing get failed, the current context has
> > to follow might_sleep() annotation, thus below steps could
> > be applied:
> >    a) wait until a grace period has elapsed;
> >    b) direct inlining of the kvfree() call.
> > 
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree.c | 102 ++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 98 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 51726e4c3b4d..501cac02146d 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3072,15 +3072,31 @@ static void kfree_rcu_work(struct work_struct *work)
> >  	 */
> >  	for (; head; head = next) {
> >  		unsigned long offset = (unsigned long)head->func;
> > -		void *ptr = (void *)head - offset;
> > +		bool headless;
> > +		void *ptr;
> >  
> >  		next = head->next;
> > +
> > +		/* We tag the headless object, if so adjust offset. */
> > +		headless = (((unsigned long) head - offset) & BIT(0));
> > +		if (headless)
> > +			offset -= 1;
> > +
> > +		ptr = (void *) head - offset;
> > +
> >  		debug_rcu_head_unqueue((struct rcu_head *)ptr);
> >  		rcu_lock_acquire(&rcu_callback_map);
> >  		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
> >  
> > -		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
> > +		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset))) {
> > +			/*
> > +			 * If headless free the back-pointer first.
> > +			 */
> > +			if (headless)
> > +				kvfree((void *) *((unsigned long *) ptr));
> > +
> >  			kvfree(ptr);
> > +		}
> >  
> >  		rcu_lock_release(&rcu_callback_map);
> >  		cond_resched_tasks_rcu_qs();
> > @@ -3221,6 +3237,13 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> >  			if (IS_ENABLED(CONFIG_PREEMPT_RT))
> >  				return false;
> >  
> > +			/*
> > +			 * TODO: For one argument of kvfree_rcu() we can
> > +			 * drop the lock and get the page in sleepable
> > +			 * context. That would allow to maintain an array
> > +			 * for the CONFIG_PREEMPT_RT as well. Thus we could
> > +			 * get rid of dynamic rcu_head attaching code.
> > +			 */
> >  			bnode = (struct kvfree_rcu_bulk_data *)
> >  				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> >  		}
> > @@ -3244,6 +3267,23 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> >  	return true;
> >  }
> >  
> > +static inline struct rcu_head *
> > +attach_rcu_head_to_object(void *obj)
> > +{
> > +	unsigned long *ptr;
> > +
> > +	ptr = kmalloc(sizeof(unsigned long *) +
> > +			sizeof(struct rcu_head), GFP_NOWAIT |
> > +				__GFP_RECLAIM |	/* can do direct reclaim. */
> > +				__GFP_NORETRY |	/* only lightweight one.  */
> > +				__GFP_NOWARN);	/* no failure reports. */
> 
> Again, let's please not do this single-pointer-sized allocation.  If
> a full page is not available and this is a single-argument kfree_rcu(),
> just call synchronize_rcu() and then free the object directly.
> 
> It should not be -that- hard to adjust locking for CONFIG_PREEMPT_RT!
> For example, have some kind of reservation protocol so that a task
> that drops the lock can retry the page allocation and be sure of having
> a place to put it.  This might entail making CONFIG_PREEMPT_RT reserve
> more pages per CPU.  Or maybe that would not be necessary.
> 
Agreed. Will drop it!

--
Vlad Rezki
