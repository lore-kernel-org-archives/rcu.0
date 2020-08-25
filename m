Return-Path: <SRS0=ANd2=CD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD5CC433E3
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 22:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66CB820767
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 22:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LkSY7dm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgHYWr1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgHYWrZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Aug 2020 18:47:25 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46B2C061574
        for <rcu@vger.kernel.org>; Tue, 25 Aug 2020 15:47:25 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id y65so8477qtd.2
        for <rcu@vger.kernel.org>; Tue, 25 Aug 2020 15:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lCOMEyRgRSwvt59dfkS7SB7QIanjWNqkuVUXG9Hrk1s=;
        b=LkSY7dm+GJquyQ2aFOOspi9gf4IzwOKX8QtWMY8qrKiQuZYQaAAB1nz6G5pDu9w2Wp
         H6IL84OhwsjQbAXsT42VBpEDMiJq/OErETA7iJr8xl7R3T9ZAAT/Tvxq3iMDQgq6s9Vm
         4sQBfzltT3NmrwUVKRQewC0SyG2IEgHcw4qgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lCOMEyRgRSwvt59dfkS7SB7QIanjWNqkuVUXG9Hrk1s=;
        b=qA0YPIzL2tJkdFudLw6sYfq7pPxnOIYxUC3ZiOAONKt/wcAOsgiBN1G3e8HiD8jyjZ
         uLdMbPmOUIQTpuEk/v7Dku20J5IyeBQWMQNKELsSU9znM5aDTiWUJ721RE66b+mO7SvD
         pfxQ6EXr5Dsvntg8wi92vM1kgd4AjTAiXQsT/pXKqI7r7XfOPFMOysQcvtQg06/oDIpa
         mgAGMaelnJRXrzYc56rCi5WxHmBy/fPtGpczoH9Gs27KtAzlfyzzR71bWpm9TmeVO9VT
         tnF4EB+KeedPrYWEDSYZDazBAzf61lBpS/mmDxM0KdAm0uI/wjlbmgTGpSAgjOkNFoBU
         yQaQ==
X-Gm-Message-State: AOAM531CDsB4chYLhBCZ/O9L55hBKMCnjqPRPfx+6yncIH3ZpXxafcI8
        tSijGgjQrUtoBkk+zzokXb3X8w==
X-Google-Smtp-Source: ABdhPJw34rAEpjroAciCdCwuez0cuPpe8NoXAXEgfUK0puUjr8f5sWkSK4wODCYRfgPSNVmByQjmWQ==
X-Received: by 2002:ac8:23a3:: with SMTP id q32mr3897181qtq.361.1598395644732;
        Tue, 25 Aug 2020 15:47:24 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l13sm374104qth.77.2020.08.25.15.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 15:47:24 -0700 (PDT)
Date:   Tue, 25 Aug 2020 18:47:23 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        dave@stgolabs.net, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, vineethrp@gmail.com
Subject: Re: [PATCH v4 -rcu 1/4] rcu/segcblist: Do not depend on rcl->len to
 store the segcb len during merge
Message-ID: <20200825224723.GB579506@google.com>
References: <20200825024842.3408659-1-joel@joelfernandes.org>
 <20200825024842.3408659-2-joel@joelfernandes.org>
 <20200825200809.GW2855@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825200809.GW2855@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On Tue, Aug 25, 2020 at 01:08:09PM -0700, Paul E. McKenney wrote:
> On Mon, Aug 24, 2020 at 10:48:39PM -0400, Joel Fernandes (Google) wrote:
> > The donecbs's ->len field is used to store the total count of the segmented
> > callback list's length. This ->len field is then added to the destination segcb
> > list.
> > 
> > However, this presents a problem for per-segment length counting which is added
> > in a future patch. This future patch sets the rcl->len field as we move
> > segments of callbacks between source and destination lists, thus becoming
> > incompatible with the donecb's ->len field.
> 
> OK, I will bite.  What is "rcl"?  A placeholder for donecbs and pendcbs?
> If so, please just name them both.  If not, please explain.

Ok will fix.

> > This commit therefore avoids depending on the ->len field in this way. IMHO,
> > this is also less error-prone and is more accurate - the donecb's ->len field
> > should be the length of the done segment and not just used as a temporarily
> > variable.
> 
> Please also mention why ->len is handled specially at all, namely
> interactions between rcu_barrier() and callback invocation.  This is
> the answer to "why not just make all this work like normal lists?"
> This might go well in the first paragraph.

Are you referring to the cblist structures ->len?  I know the segcblist's
->len field is what rcu_barrier() samples but I am not changing that behavior
at all in this patch. This patch is only about the donecb's len (which is a
cblist structure on the stack).

> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/rcu_segcblist.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > index 2d2a6b6b9dfb..b70d4154433c 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -513,14 +513,18 @@ void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
> >  {
> >  	struct rcu_cblist donecbs;
> >  	struct rcu_cblist pendcbs;
> > +	long src_len;
> >  
> >  	rcu_cblist_init(&donecbs);
> >  	rcu_cblist_init(&pendcbs);
> > -	rcu_segcblist_extract_count(src_rsclp, &donecbs);
> > +
> > +	src_len = rcu_segcblist_xchg_len(src_rsclp, 0);
> 
> Given that both rcu_segcblist_xchg_len() and rcu_segcblist_extract_count()
> have only one callsite each, why not get rid of one of them?

Good point, I will do that.

> Or better yet, please see below, which should allow getting rid of both
> of them.
> 
> >  	rcu_segcblist_extract_done_cbs(src_rsclp, &donecbs);
> >  	rcu_segcblist_extract_pend_cbs(src_rsclp, &pendcbs);
> > -	rcu_segcblist_insert_count(dst_rsclp, &donecbs);
> > +
> > +	rcu_segcblist_add_len(dst_rsclp, src_len);
> >  	rcu_segcblist_insert_done_cbs(dst_rsclp, &donecbs);
> >  	rcu_segcblist_insert_pend_cbs(dst_rsclp, &pendcbs);
> 
> Rather than adding the blank lines, why not have the rcu_cblist structures
> carry the lengths?  You are already adjusting one of the two call sites
> that care (rcu_do_batch()), and the other is srcu_invoke_callbacks().
> That should shorten this function a bit more.  And make callback handling
> much more approachable, I suspect.

Sorry, I did not understand. The rcu_cblist structure already has a length
field. I do modify rcu_segcblist_extract_done_cbs() and
rcu_segcblist_extract_pend_cbs() to carry the length already, in a later
patch.

Just to emphasize, this patch is just a small refactor to avoid an issue in
later patches. It aims to keep current functionality unchanged.

thanks,

 - Joel

> 
> There would still be the callback-invocation need to be careful with
> ->cblist.len due to rcu_barrier() and srcu_barrier().  But both of
> those should be excluded by this code.  (But don't take my word for it,
> ask KCSAN.)
> 
> 							Thanx, Paul
> 
> > +
> >  	rcu_segcblist_init(src_rsclp);
> >  }
> > -- 
> > 2.28.0.297.g1956fa8f8d-goog
> > 
