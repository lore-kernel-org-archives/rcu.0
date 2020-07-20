Return-Path: <SRS0=GZkA=A7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6164BC433EA
	for <rcu@archiver.kernel.org>; Mon, 20 Jul 2020 08:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD6621775
	for <rcu@archiver.kernel.org>; Mon, 20 Jul 2020 08:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb3QwmaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgGTIWS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgGTIWQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jul 2020 04:22:16 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E63C061794;
        Mon, 20 Jul 2020 01:22:16 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id e13so14432821qkg.5;
        Mon, 20 Jul 2020 01:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hn3XBHozzSpRXalgzql+MPTSBLyIidSsEYM8QEEhOtc=;
        b=Gb3QwmaI13D5zi+JQWDZCU5N3aZE/c+X+ldmSs0GLmM6IEFPFZ7EErKWsBCafaEFVy
         rTQqENeAgpAd44Sy5887xLmK4mMzKH0eUzlOqJYXJbzsDrY51R3ndloNPbLiqvfHq4Pj
         v/WWyprf7PjmKzi82u+F8ktPIDtnDzYaDiGsUHBWViTl1AGkFV1DXRaV36jpn/C3PNaZ
         j0m9PnrlsvOdIY/SxVZYzhVHY56pgzJPfEl3ip8tLqMMkqqiT1462HEI+OaMMBAHgt22
         p0RVCr+WmeH/4xS1rzyKBrTpp1GNFLtaPVqlzVXQ/+S4/E8soeWE6vrwlONIB8Pbz5Dp
         /D2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hn3XBHozzSpRXalgzql+MPTSBLyIidSsEYM8QEEhOtc=;
        b=PTP83i7gZDdUkIOGJB15VaR9BLIbLY5wP6h9Rkh7vVDzrzNoHnA95FViZhQlw5oynG
         HnSO/KkHQ41I8PRkfn0DxWBO6Yj2Hts9emZZDFl/xqOQpS3oaEQsPQut+7VPF5dhTaH+
         ZRn4RfzvXuy08qbTVLDskEc/kwTgCf/STaLp9R7HUuOhEYNLt1BjlZ7xWs6S7Yd5MPSL
         xGCUCcAXxjuntRgKm65cFvGGmLWu0SEKAnFSY3L2bQnPh9Dg4Bu0ddwGNMYfGns/cTEo
         pfQ+LhbAkombPNuUwSwP5E1kkN/yQqVIC0Y5k9htRepXMf/14W53oEoUr03tjpLy/HmC
         +DEA==
X-Gm-Message-State: AOAM530qvdd/OBNSvP75jFBprujNIU/Yy+bCPFPG7Ai7LFJMN6Ljv+Gz
        Om/k1YIGLng7mIyfAFu4JFo=
X-Google-Smtp-Source: ABdhPJzJTxh0p68VyupzKQ//6bAyTqgucI9hU6DGHszARvOmVINc617ihwWKvq1dlM7uMXlSp19lBw==
X-Received: by 2002:a37:9e41:: with SMTP id h62mr87241qke.426.1595233335431;
        Mon, 20 Jul 2020 01:22:15 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id c7sm21202327qta.95.2020.07.20.01.22.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 01:22:14 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id C430D27C0054;
        Mon, 20 Jul 2020 04:22:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 20 Jul 2020 04:22:13 -0400
X-ME-Sender: <xms:NVQVXxBsGexWrm9ObYZAUHW-8IWvp9fR37MGCz699asaPMTgrtVoVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrgeefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepsghoqhhunhdr
    fhgvnhhgsehgmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepuddvgfeutdeuhefggf
    fhlefggeevueeliefgvdfggeeukeehleelueeiiedukedunecukfhppeehvddrudehhedr
    udduuddrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeg
    hedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomh
    esfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:NVQVX_h-nySvrdHAAJxF0_gXJ8K76D2p47JjtkC8W2QeCgoS0FMYFQ>
    <xmx:NVQVX8k3_PdGmoEWQsF_0xyX7FrIXd6qamylCTPTGmSMqpHG0woUTg>
    <xmx:NVQVX7zCsTDztHnUn8Q6q9tollINMmMcsNon0HaDH_dLv0A-j-fmdw>
    <xmx:NVQVX1H1-ceR4hJBGytHZ-9vsREWkGysJ2z11BLlaV1wbwUN5LDhQA>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id B8781306005F;
        Mon, 20 Jul 2020 04:22:12 -0400 (EDT)
Date:   Mon, 20 Jul 2020 16:22:11 +0800
From:   boqun.feng@gmail.com
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC v2] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20200720082211.GA35358@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200719035518.2386828-1-joel@joelfernandes.org>
 <CAEXW_YQhYiYQZOJ95dqBcu_fAZ_6k7HGbrw53eTgPrgXU+5few@mail.gmail.com>
 <20200719041841.GA2398236@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719041841.GA2398236@google.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Joel,

On Sun, Jul 19, 2020 at 12:18:41AM -0400, Joel Fernandes wrote:
> On Sun, Jul 19, 2020 at 12:06:28AM -0400, Joel Fernandes wrote:
> > On Sat, Jul 18, 2020 at 11:55 PM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > [...]
> > >         /* If no callbacks moved, nothing more need be done. */
> > > @@ -419,10 +494,9 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
> > >          * callbacks.  The overall effect is to copy down the later pointers
> > >          * into the gap that was created by the now-ready segments.
> > >          */
> > > -       for (j = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++, j++) {
> > > -               if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
> > > -                       break;  /* No more callbacks. */
> > > +       for (j = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL && j < RCU_NEXT_TAIL; i++, j++) {
> > >                 WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
> > > +               rcu_segcblist_move_seglen(rsclp, i, j);
> > >                 rsclp->gp_seq[j] = rsclp->gp_seq[i];
> > >         }
> > 
> > Unfortunately I broke this code, _sigh_.  I need to reinstate the
> > if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL]) , I completely
> > misunderstood that.
> 
> And hopefully, third time's a charm with various extra newlines removed:
> 
> ---8<-----------------------
> 
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH v3] rcu/segcblist: Add counters to segcblist datastructure
> 
> Add counting of segment lengths of segmented callback list.
> 
> This will be useful for a number of things such as knowing how big the
> ready-to-execute segment have gotten. The immediate benefit is ability
> to trace how the callbacks in the segmented callback list change.
> 
> Tested by profusely reading traces when segcblist counts updated.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> v1->v3: minor nits.
> ---
>  include/linux/rcu_segcblist.h |  2 +
>  kernel/rcu/rcu_segcblist.c    | 77 +++++++++++++++++++++++++++++++++--
>  2 files changed, 76 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
> index b36afe7b22c9..d462ae5e340a 100644
> --- a/include/linux/rcu_segcblist.h
> +++ b/include/linux/rcu_segcblist.h
> @@ -69,8 +69,10 @@ struct rcu_segcblist {
>  	unsigned long gp_seq[RCU_CBLIST_NSEGS];
>  #ifdef CONFIG_RCU_NOCB_CPU
>  	atomic_long_t len;
> +	atomic_long_t seglen[RCU_CBLIST_NSEGS];
>  #else
>  	long len;
> +	long seglen[RCU_CBLIST_NSEGS];
>  #endif
>  	u8 enabled;
>  	u8 offloaded;
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 9a0f66133b4b..c5841efcd38e 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -88,6 +88,57 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
>  #endif
>  }
>  
> +/* Get the length of a segment of the rcu_segcblist structure. */
> +static long rcu_segcblist_get_seglen(struct rcu_segcblist *rsclp, int seg)
> +{
> +#ifdef CONFIG_RCU_NOCB_CPU
> +	return atomic_long_read(&rsclp->seglen[seg]);
> +#else
> +	return READ_ONCE(rsclp->seglen[seg]);
> +#endif
> +}
> +
> +/* Set the length of a segment of the rcu_segcblist structure. */
> +static void rcu_segcblist_set_seglen(struct rcu_segcblist *rsclp, int seg, long v)
> +{
> +#ifdef CONFIG_RCU_NOCB_CPU
> +	atomic_long_set(&rsclp->seglen[seg], v);
> +#else
> +	WRITE_ONCE(rsclp->seglen[seg], v);
> +#endif

These #ifdef really make me uncomfortable ;-) Since we are allowed to
use the '_Generic' key from C11 (see include/linux/compiler_types.h), I
wonder whether it's better if we have a few "generic" primitives like:

	#define gen_long_read(x) _Generic((x),						\
					  atomic_long_t: atomic_long_read(&x, v),	\
					  long: READ_ONCE(x)),				\
					  ...

	#define gen_long_set(x, v) _Generic((x),					\
					    atomic_long_t: atomic_long_set(&x, v),	\
					    long: WRITE_ONCE(x, v)),			\
					    ...

, and similar for _xchg and _add.

With these primitives introduced, you can avoid to add those
rcu_segcblist_*_seglen() which have #ifdefs in them. Of course, an
alternative would be that we implement rcu_segcblist_*_seglen() using
_Generic, but I think someone else may have the similar problems or
requirement (already or in the future), so it might be worthwhile to
introduce the gen_ primitives for broader usage.

Also add Peter and Will to the Cc list.

To summarize, Joel's patch points out that there are some places where
the developers want to save some cost from atomic APIs in a particular
configuration, and obviously they know what they are doing when they use
{READ,WRITE}_ONCE() to replace atomic APIs: they use different types in
different configurations. With the help of C11's _Generic keyword, we
can provide a set of APIs help developers write less but cleaner code.

Any idea? I admit that "gen_" is not a good prefix, just put it here as
a placeholder ;-)

Regards,
Boqun

> +}
> +
> +/* Return number of callbacks in a segment of the segmented callback list. */
> +static void rcu_segcblist_add_seglen(struct rcu_segcblist *rsclp, int seg, long v)
> +{
> +#ifdef CONFIG_RCU_NOCB_CPU
> +	smp_mb__before_atomic(); /* Up to the caller! */
> +	atomic_long_add(v, &rsclp->seglen[seg]);
> +	smp_mb__after_atomic(); /* Up to the caller! */
> +#else
> +	smp_mb(); /* Up to the caller! */
> +	WRITE_ONCE(rsclp->seglen[seg], rsclp->seglen[seg] + v);
> +	smp_mb(); /* Up to the caller! */
> +#endif
> +}
> +
> +/* Move from's segment length to to's segment. */
> +static void rcu_segcblist_move_seglen(struct rcu_segcblist *rsclp, int from, int to)
> +{
> +	long len = rcu_segcblist_get_seglen(rsclp, from);
> +
> +	if (!len || from == to)
> +		return;
> +	rcu_segcblist_add_seglen(rsclp, to, len);
> +	rcu_segcblist_set_seglen(rsclp, from, 0);
> +}
> +
> +/* Increment segment's length. */
> +static void rcu_segcblist_inc_seglen(struct rcu_segcblist *rsclp, int seg)
> +{
> +	rcu_segcblist_add_seglen(rsclp, seg, 1);
> +}
> +
>  /*
>   * Increase the numeric length of an rcu_segcblist structure by the
>   * specified amount, which can be negative.  This can cause the ->len
> @@ -149,8 +200,10 @@ void rcu_segcblist_init(struct rcu_segcblist *rsclp)
>  	BUILD_BUG_ON(RCU_NEXT_TAIL + 1 != ARRAY_SIZE(rsclp->gp_seq));
>  	BUILD_BUG_ON(ARRAY_SIZE(rsclp->tails) != ARRAY_SIZE(rsclp->gp_seq));
>  	rsclp->head = NULL;
> -	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
> +	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
>  		rsclp->tails[i] = &rsclp->head;
> +		rcu_segcblist_set_seglen(rsclp, i, 0);
> +	}
>  	rcu_segcblist_set_len(rsclp, 0);
>  	rsclp->enabled = 1;
>  }
> @@ -245,6 +298,7 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
>  			   struct rcu_head *rhp)
>  {
>  	rcu_segcblist_inc_len(rsclp);
> +	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
>  	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
>  	rhp->next = NULL;
>  	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
> @@ -274,6 +328,7 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
>  	for (i = RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
>  		if (rsclp->tails[i] != rsclp->tails[i - 1])
>  			break;
> +	rcu_segcblist_inc_seglen(rsclp, i);
>  	WRITE_ONCE(*rsclp->tails[i], rhp);
>  	for (; i <= RCU_NEXT_TAIL; i++)
>  		WRITE_ONCE(rsclp->tails[i], &rhp->next);
> @@ -307,6 +362,7 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
>  
>  	if (!rcu_segcblist_ready_cbs(rsclp))
>  		return; /* Nothing to do. */
> +	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_DONE_TAIL);
>  	*rclp->tail = rsclp->head;
>  	WRITE_ONCE(rsclp->head, *rsclp->tails[RCU_DONE_TAIL]);
>  	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
> @@ -314,6 +370,7 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
>  	for (i = RCU_CBLIST_NSEGS - 1; i >= RCU_DONE_TAIL; i--)
>  		if (rsclp->tails[i] == rsclp->tails[RCU_DONE_TAIL])
>  			WRITE_ONCE(rsclp->tails[i], &rsclp->head);
> +	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
>  }
>  
>  /*
> @@ -330,11 +387,16 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
>  
>  	if (!rcu_segcblist_pend_cbs(rsclp))
>  		return; /* Nothing to do. */
> +	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_WAIT_TAIL) +
> +		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_READY_TAIL) +
> +		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL);
>  	*rclp->tail = *rsclp->tails[RCU_DONE_TAIL];
>  	rclp->tail = rsclp->tails[RCU_NEXT_TAIL];
>  	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
> -	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++)
> +	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++) {
>  		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_DONE_TAIL]);
> +		rcu_segcblist_set_seglen(rsclp, i, 0);
> +	}
>  }
>  
>  /*
> @@ -359,6 +421,7 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
>  
>  	if (!rclp->head)
>  		return; /* No callbacks to move. */
> +	rcu_segcblist_add_seglen(rsclp, RCU_DONE_TAIL, rclp->len);
>  	*rclp->tail = rsclp->head;
>  	WRITE_ONCE(rsclp->head, rclp->head);
>  	for (i = RCU_DONE_TAIL; i < RCU_CBLIST_NSEGS; i++)
> @@ -379,6 +442,8 @@ void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
>  {
>  	if (!rclp->head)
>  		return; /* Nothing to do. */
> +
> +	rcu_segcblist_add_seglen(rsclp, RCU_NEXT_TAIL, rclp->len);
>  	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rclp->head);
>  	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], rclp->tail);
>  }
> @@ -403,6 +468,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
>  		if (ULONG_CMP_LT(seq, rsclp->gp_seq[i]))
>  			break;
>  		WRITE_ONCE(rsclp->tails[RCU_DONE_TAIL], rsclp->tails[i]);
> +		rcu_segcblist_move_seglen(rsclp, i, RCU_DONE_TAIL);
>  	}
>  
>  	/* If no callbacks moved, nothing more need be done. */
> @@ -423,6 +489,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
>  		if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
>  			break;  /* No more callbacks. */
>  		WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
> +		rcu_segcblist_move_seglen(rsclp, i, j);
>  		rsclp->gp_seq[j] = rsclp->gp_seq[i];
>  	}
>  }
> @@ -444,7 +511,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
>   */
>  bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
>  {
> -	int i;
> +	int i, j;
>  
>  	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
>  	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
> @@ -479,6 +546,10 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
>  	if (++i >= RCU_NEXT_TAIL)
>  		return false;
>  
> +	/* Accounting: everything below i is about to get merged into i. */
> +	for (j = i + 1; j <= RCU_NEXT_TAIL; j++)
> +		rcu_segcblist_move_seglen(rsclp, j, i);
> +
>  	/*
>  	 * Merge all later callbacks, including newly arrived callbacks,
>  	 * into the segment located by the for-loop above.  Assign "seq"
> -- 
> 2.28.0.rc0.105.gf9edc3c819-goog
> 
