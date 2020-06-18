Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F675C433E0
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 18:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02839208DB
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 18:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfBv5FER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgFRSsz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgFRSsz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 14:48:55 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA137C06174E;
        Thu, 18 Jun 2020 11:48:54 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d7so4083036lfi.12;
        Thu, 18 Jun 2020 11:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wjGYovLtwBVlU5MI/beQQwAXgK/hwRXYMWBKVKLVNRA=;
        b=sfBv5FERRlAV1kHakd7ts07E2smqihvzD7VSa9Tt7zTel6b3kl2rTRGe0vlGzbZKfE
         Fx9j6aRPtNagG/9DeFubgJYIrcF2edD6gAYWYqj7OkC4oSD6S6S2JiGCeq0nPVvb8Dqp
         qv9bcrWLabN83XWkGXni8qWT7qUpctpRn4HtBFJakYdOJ7Ho+ifcA6zbuaSwadU8SBe7
         dGJFZMh34YLyW/PZz5taNPPPlFki3X5axqAs9zefhyfyGkRvuYEA1C7RQ9NChNGy23K9
         +71RqwAEV6vqZ4sDiZ1b07Yg+wrSYiQi3PLxo6J3xMm3MHnEj50YpoCzg4Q4LpXLgI+2
         +Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wjGYovLtwBVlU5MI/beQQwAXgK/hwRXYMWBKVKLVNRA=;
        b=fQTUkERXQx9ZSUixOqQh4Ot+HiZqWHgV60RyDEw+j3vImDYW6bQqoacq/4dCR9cVNR
         XWXMTl0MRgTYcBnjoDA4d+JWmvYF5Nq5L3OSOa5Y16H1VkRBTssHdKCvQgoDnPHsYjx4
         UXZdP4k4jauqBLKXSwWv2QVZwooFIHahgv7VOBcNsWy6xmbjX10YbUkcSXzXFvVkn/lr
         RHHm25OlFZsl+uwFQJycX7DrfN7VB/YFFUngVo6pg8nrPe89fGoWo7+5U3M8SNpinftd
         2orP4mO/i7HsTwz8tAO9V4a96xvQQ2cSOUALKOlV9Dtqp1kcevHfNhEeLr01ZXh01IRg
         6htw==
X-Gm-Message-State: AOAM533xyOZabQG51z3ujAHAfPg/dhSzc/3UB+8h6ZJkJ2Vk1QhWJac9
        gd9k6QWeqk+fhtBYFwhlHyg=
X-Google-Smtp-Source: ABdhPJzywC1l9vH4+kWG5TPIS2ra8u/BjFMfL86zBPsbqe2KWx6N0hXCTICdtbuHfyGhwJcnPCn15g==
X-Received: by 2002:ac2:5de1:: with SMTP id z1mr3087783lfq.183.1592506133214;
        Thu, 18 Jun 2020 11:48:53 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id q190sm775656ljb.29.2020.06.18.11.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 11:48:52 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 18 Jun 2020 20:48:50 +0200
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200618184850.GA15211@pc636>
References: <20200525214800.93072-1-urezki@gmail.com>
 <20200525214800.93072-10-urezki@gmail.com>
 <20200617234609.GA10087@paulmck-ThinkPad-P72>
 <20200618172504.GA14613@pc636>
 <20200618173206.GS2723@paulmck-ThinkPad-P72>
 <20200618175623.GA14865@pc636>
 <20200618181541.GS8681@bombadil.infradead.org>
 <20200618182333.GA15082@pc636>
 <20200618183751.GT8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618183751.GT8681@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 11:37:51AM -0700, Matthew Wilcox wrote:
> On Thu, Jun 18, 2020 at 08:23:33PM +0200, Uladzislau Rezki wrote:
> > > +void vfree_bulk(size_t count, void **addrs)
> > > +{
> > > +	unsigned int i;
> > > +
> > > +	BUG_ON(in_nmi());
> > > +	might_sleep_if(!in_interrupt());
> > > +
> > > +	for (i = 0; i < count; i++) {
> > > +		void *addr = addrs[i];
> > > +		kmemleak_free(addr);
> > > +		if (addr)
> > > +			__vfree(addr);
> > > +	}
> > > +}
> > > +EXPORT_SYMBOL(vfree_bulk);
> > > +
> > >
> > Can we just do addrs[i] all over the loop?
> > 
> > Also, we can just call vfree() instead that has all checking we
> > need: NMI, kmemleak, might_sleep.
> 
> Of course we _can_.  But would we want to?  This way, we only do these
> checks once instead of once per pointer, which is rather the point
> of batching.
>
Ahh, right. I briefly looked at it and missed that point. Right you
are we do not want the vfree() here!

> 
> I might actually go further and hoist the in_interrupt() check into
> this function ...
>
Why do you need it? Just to inline below code:

<snip>
 if (unlikely(in_interrupt()))
  __vfree_deferred(addr);
 else
  __vunmap(addr, 1);
<snip>

and bypass the __vfree() call(that is not marked as inline one)?
I mean to inline above into  vfree_bulk().

>
> I suspect the RCU code always runs in_interrupt()
> and so we always call vfree_deferred().
>
No. We release the memory from workqueue context.

--
Vlad Rezki
