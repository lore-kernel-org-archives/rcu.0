Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ED4C433DF
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 17:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BE7B20706
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 17:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnJVvr0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgFRRfZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgFRRfZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 13:35:25 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E30C06174E;
        Thu, 18 Jun 2020 10:35:25 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i3so8282827ljg.3;
        Thu, 18 Jun 2020 10:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2dnP8qUYYyaFpZ3zTbvKqOauflmJ29SpLJF29OdRiCY=;
        b=UnJVvr0vjgrNwYCuzGQ6Zwo0ZVOh/xGkhHUBk/0FzT/T+Ziki1U2FpCULJ6P04LVov
         JURhpY1o6uMKtJhlLf1rU1t0Et/tIhjTe6Ph/AdJ8FPnrhTLQVBacPE0hUXobrMePabw
         vouH+VTXBH8gtFwRihx66ME4fgW8MqQrRJYKM1ByaJBompes1rA7HRt0N4Izz2T5bHdf
         Xb76GGTOw60NJVLmPZCpl71bjGxL8Y3+niDOZqPT2czIf///ZMo+5MjG4XdPCXswIWRa
         vKCYkgC9UBOY4xne6+RfrbTwTqu4UogFTG05Yvxb2k5n/z2CoiUgrEMxfvZJpuIx/gk0
         48QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2dnP8qUYYyaFpZ3zTbvKqOauflmJ29SpLJF29OdRiCY=;
        b=j8YAJ4Hd11ziMBugddeq2igPvzR7ii2mFbhna6/J+Sj55LhgrDOUjXHNm5H3XSL8Sz
         CcWpFnuq1Ey49AYERp+qtO4skiZkD2J22KkGMg7sggbFxrzbiiJXPeocjR459Vvq9vki
         PPsRdrau9bAPHbzH6r4VDUg4HPj9SF23ev1/SYePJyHYNgACXHb+k25whP34hWQ5H7pE
         IltB1ZeauyBJ+DT7mFz7vCwopMP/p1IWRI2Qc2TOBMMMuXtUBzeJbnVkaGhMazg3OoZR
         cmXejhzdQVQWjokF0CTXuT/qanU2wijoTssntZ7Iq49YoCaqKFKK1T/kjKuxmSSnvYKg
         JZAg==
X-Gm-Message-State: AOAM530+gWw2Z0a51JEiQxPN2yjgNT7TxgdC3EqBnPg63oe3bjWeopo6
        xMNMwoqSvAmOLovtDqB9jgJ0HW5sabt3og==
X-Google-Smtp-Source: ABdhPJyRHfUAtfaXLaXdDIJZ3o3g1DeSegfwsePEd6xOssh783a7fX4fLQEGbc4AJvcyRvrKKGGOHw==
X-Received: by 2002:a05:651c:29b:: with SMTP id b27mr2725268ljo.454.1592501723586;
        Thu, 18 Jun 2020 10:35:23 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id t11sm427510lfc.24.2020.06.18.10.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 10:35:22 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 18 Jun 2020 19:35:20 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200618173520.GC14613@pc636>
References: <20200525214800.93072-1-urezki@gmail.com>
 <20200525214800.93072-10-urezki@gmail.com>
 <20200617234609.GA10087@paulmck-ThinkPad-P72>
 <20200618005214.GN8681@bombadil.infradead.org>
 <20200618031823.GQ2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618031823.GQ2723@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> > 
> > I don't think that replacing direct function calls with indirect function
> > calls is a great suggestion with the current state of play around branch
> > prediction.
> > 
> > I'd suggest:
> > 
> >  			rcu_lock_acquire(&rcu_callback_map);
> > 			trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
> > 				bkvhead[i]->nr_records, bkvhead[i]->records);
> >  			if (i == 0) {
> >  				kfree_bulk(bkvhead[i]->nr_records,
> >  					bkvhead[i]->records);
> >  			} else {
> >  				for (j = 0; j < bkvhead[i]->nr_records; j++) {
> >  					vfree(bkvhead[i]->records[j]);
> >  				}
> >  			}
> >  			rcu_lock_release(&rcu_callback_map);
> > 
> > But I'd also suggest a vfree_bulk be added.  There are a few things
> > which would be better done in bulk as part of the vfree process
> > (we batch them up already, but i'm sure we could do better).
> 
> I suspect that he would like to keep the tracing.
> 
> It might be worth trying the branches, given that they would be constant
> and indexed by "i".  The compiler might well remove the indirection.
> 
> The compiler guys brag about doing so, which of course might or might
> not have any correlation to a given compiler actually doing so.  :-/
> 
> Having a vfree_bulk() might well be useful, but I would feel more
> confidence in that if there were other callers of kfree_bulk().
>
Hmm... I think replacing that with vfree_bulk() is a good idea though.

> 
> But again, either way, future work as far as this series is concerned.
> 
What do you mean: is concerned?

We are planning to implement kfree_rcu() to be integrated directly into
SLAB: SLAB, SLUB, SLOB. So, there are plenty of future work :)

--
Vlad Rezki
