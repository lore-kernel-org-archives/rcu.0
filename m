Return-Path: <SRS0=+k02=Z4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D64C43603
	for <rcu@archiver.kernel.org>; Fri,  6 Dec 2019 15:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720E22173E
	for <rcu@archiver.kernel.org>; Fri,  6 Dec 2019 15:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xA4bTKeR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfLFP6v (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:58:51 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43500 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfLFP6v (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 6 Dec 2019 10:58:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id q16so2881122plr.10
        for <rcu@vger.kernel.org>; Fri, 06 Dec 2019 07:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pygl8oMQvOdcJfo8OD7ZqM6kANo2v/N/jTBIk1Ungko=;
        b=xA4bTKeRYpdY/+/mnZnlANfDTD1eYnEC7UKH0/cEPhEwJbsOPPMAUnf6ZEZR6SfzOo
         1KCMflEIr/QemVn4RA4X38oHl2/j7bKcP5g5l7b+ETLaztmPs48Pyx9wFxp7EXWhHBZa
         p0gOEZkOjQlpqF+nvYKTw5d4SqmN5wJsj33r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pygl8oMQvOdcJfo8OD7ZqM6kANo2v/N/jTBIk1Ungko=;
        b=dF+hFzEwHK15dMthUVFytMnXctIhuDL0zXPVl7ub4qTGrY7zzCjsAy0iiotYb568os
         60DH9mKJ/uz0kKNueW9CDHbzHOGC/5NiEV6mwPu0OfxmVc4xXU7IgXdnRk1EqU2MA3YL
         v+AcQtXXO/pXzB8AVR6PKVNjoVIc7CFIDw21gGYACxV+tGqfjVt8OhOzIoKsgTcITNLB
         FdIDfFWLbOr/6DPpFZFzCL5VVymS9T88VP+cWuHrMnrfgwrn42X6FK1vDffYBFc1+4CM
         E4XjHwvCbmDVwx7IU58KeDGEA0F+YuxSdfHzhUXIWeFKUmEXg1WN11HzWcQ0Byxl5S1W
         xbCA==
X-Gm-Message-State: APjAAAVLkMy1/c/yDhBKHuDAJhGZjkqzjjdjey2nFQoZZbDNJFF1+ZLF
        5dvhcTelVTighCvDeruRTjdNcw==
X-Google-Smtp-Source: APXvYqyHcbMY2FvYIEPh6SR56LzKLX4vx0Fs5FhrAhi/UkKIZHLUhBBdgWkmqf97Fdj9mmK8tA1Hxg==
X-Received: by 2002:a17:90a:178f:: with SMTP id q15mr16632135pja.132.1575647929759;
        Fri, 06 Dec 2019 07:58:49 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x197sm17302182pfc.1.2019.12.06.07.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 07:58:49 -0800 (PST)
Date:   Fri, 6 Dec 2019 10:58:48 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     madhuparnabhowmik04@gmail.com, rostedt@goodmis.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] rculist: Add macro list_prev_rcu
Message-ID: <20191206155848.GA15547@google.com>
References: <20191206150554.10479-1-madhuparnabhowmik04@gmail.com>
 <20191206153258.GD2889@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206153258.GD2889@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Dec 06, 2019 at 07:32:58AM -0800, Paul E. McKenney wrote:
> On Fri, Dec 06, 2019 at 08:35:54PM +0530, madhuparnabhowmik04@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > 
> > There are instances in the linux kernel where the prev pointer
> > of a list is accessed.
> > Unlike list_next_rcu, a similar macro for accessing the prev
> > pointer was not present.
> 
> Interesting patch, but...
> 
> You lost me on this one.  The list_head ->prev pointer is not marked
> __rcu, so why is sparse complaining?  Or is someone trying to use
> rcu_dereference() or similar on ->prev?  If so, it is important to note
> that both list_del() and list_del_rcu() poision ->prev, so it is not
> usually safe to access ->prev within an RCU read-side critical section.
> At the very least, this restriction needs to be called out in the
> list_prev_rcu() comment header.  And that use of rcu_dereference() and
> friends on the ->prev pointer is almost always the result of confusion,
> if not a bug.  (Or is this some new-to-me use case?)

Madhuparna, could you please send the patch using this as well, to prevent
confusion? You can see how just sending one patch and not the user of it
creates avoidable confusion. Thanks.

Thanks Paul for taking a look. If I remember the dependent patch uses
rcu_dereference() but I don't remember all the details at the top of my head.

thanks,

 - Joel


> 
> Either way, the big question is how we are sure that the uses of ->prev
> that sparse is complaining about are in fact safe.  More specifically,
> what have those use cases done to ensure that there will be no invocation
> of either list_del() or list_del_rcu() on the current element just before
> the use of ->prev?  Here are a couple of possibilities:
> 
> 1.	The list only grows, so list_del() and list_del_rcu() are never
> 	ever invoked on it.
> 
> 	But even this is not safe because __list_add_rcu() does
> 	smp_store_release() only on ->next.  The initialization of
> 	->prev is completely unordered with any other initialization,
> 	which can result in bugs on lookup/insertion concurrency.
> 
> 	So this instead becomes the list being constant.
> 
> 2.	The ->prev pointer is never actually dereferenced, but only
> 	compared.  One example use case is determining whether the
> 	current element is first in the list by comparing its
> 	->prev pointer to the address of the list header.
> 
> 	But this use case needs a READ_ONCE().
> 
> 3.	These accesses are single-threaded, for example while the list
> 	is being initialized but before it is exposed to readers or
> 	after the list has been rendered inaccessible to readers
> 	(and following at least one grace period after that).  But in
> 	this case, there is no need for rcu_dereference(), so sparse
> 	should not be complaining.
> 
> 4.	#3 above, but code is shared with the non-single-threaded case.
> 	But then the non-single-threaded code needs to be safe with
> 	respect to concurrent insertions and deletions, as called
> 	out above.
> 
> So what am I missing here?
> 
> 							Thanx, Paul
> 
> > Therefore, directly accessing the prev pointer was causing
> > sparse errors.
> > One such example is the sparse error in fs/nfs/dir.c
> > 
> > error:
> > fs/nfs/dir.c:2353:14: error: incompatible types in comparison expression (different address spaces):
> > fs/nfs/dir.c:2353:14:    struct list_head [noderef] <asn:4> *
> > fs/nfs/dir.c:2353:14:    struct list_head *
> > 
> > The error is caused due to the following line:
> > 
> > lh = rcu_dereference(nfsi->access_cache_entry_lru.prev);
> > 
> > After adding the macro, this error can be fixed as follows:
> > 
> > lh = rcu_dereference(list_prev_rcu(&nfsi->access_cache_entry_lru));
> > 
> > Therefore, we think there is a need to add this macro to rculist.h.
> > 
> > Suggested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > ---
> >  include/linux/rculist.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> > index 4b7ae1bf50b3..49eef8437753 100644
> > --- a/include/linux/rculist.h
> > +++ b/include/linux/rculist.h
> > @@ -40,6 +40,12 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
> >   */
> >  #define list_next_rcu(list)	(*((struct list_head __rcu **)(&(list)->next)))
> >  
> > +/*
> > + * return the prev pointer of a list_head in an rcu safe
> > + * way, we must not access it directly
> > + */
> > +#define list_prev_rcu(list)	(*((struct list_head __rcu **)(&(list)->prev)))
> > +
> >  /*
> >   * Check during list traversal that we are within an RCU reader
> >   */
> > -- 
> > 2.17.1
> > 
