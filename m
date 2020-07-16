Return-Path: <SRS0=oPal=A3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866BDC433E0
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 15:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60254207BC
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 15:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQ2HYs4G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7ShNmqAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgGPPET (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgGPPES (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Jul 2020 11:04:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EBDC061755;
        Thu, 16 Jul 2020 08:04:17 -0700 (PDT)
Date:   Thu, 16 Jul 2020 17:04:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594911856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4PnkyZYWZOMwLjT2XEuyBaxyGODDUJAPPfVAnXgJWzM=;
        b=GQ2HYs4GXHXYKdgmS+JrKF0AdMhLCpbdhXTzdlWuN8uhLEP5TnDaw45/Os8glke2PRgdBd
        8QDd8BbUqKs3lHZ6CupHCesEAKEIEWamnNZVfLtQs3gwWnwR7BORXnSVzcFRCIT+E4LuNd
        ZCJJNXJ/Eh2HZoL9NZS63UlNqmCAZDWnymYH/RnMasVhXA+NVtQmw6ZzSYVkBnrRQqcg++
        2NNgn9KzGR4/fBPuY2iVR1YmJb0jriAuzHqODzUpGwfexaG9kjiuldYCid8QLUwSyiLZct
        rNzxMsTTt1G38Vjwg0r1T+TTR2N8pxjXupZGkRXT0SJPIr/vizXPUK0cU06YXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594911856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4PnkyZYWZOMwLjT2XEuyBaxyGODDUJAPPfVAnXgJWzM=;
        b=7ShNmqAVtSMsfGVWqF96OFqo6zG0vv/147EqDPF6TuT2Xpe1h5aN1dSq/v8b6LwN0Hj81f
        o3O9Jv7/KzbBGvDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: Drop the lock before entering to page
 allocator
Message-ID: <20200716150414.iqpyby6nrww4zbyk@linutronix.de>
References: <20200715183537.4010-1-urezki@gmail.com>
 <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
 <CAEXW_YRoTvQfqqcM9fi+MkMxCPEaoJh4zHRM3qNYkv=-nAVuBQ@mail.gmail.com>
 <20200716091913.GA28595@pc636>
 <20200716142537.ecp4icsq7kg6qhdx@linutronix.de>
 <20200716144728.GA31046@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200716144728.GA31046@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-07-16 16:47:28 [+0200], Uladzislau Rezki wrote:
> On Thu, Jul 16, 2020 at 04:25:37PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2020-07-16 11:19:13 [+0200], Uladzislau Rezki wrote:
> > > Sebastian, could you please confirm that if that patch that is in
> > > question fixes it?
> > > 
> > > It would be appreciated!
> > 
> > So that preempt disable should in terms any warnings. However I don't
> > think that it is strictly needed and from scheduling point of view you
> > forbid a CPU migration which might be good otherwise.
> >
> Please elaborate your point regarding "i do not think it is strictly needed".
> 
> Actually i can rework the patch to remove even such preempt_enable/disable
> to stay on the same CPU, but i do not see the point of doing it.
> 
> Do you see the point?

You disable preemption for what reason? It is not documented, it is not
obvious - why is it required?

> As for scheduling point of view. Well, there are many places when there
> is a demand in memory or pages from atomic context. Also, getting a page
> is not considered as a hot path in the kfree_rcu(). 

If you disable preemption than you assume that you wouldn't be atomic
otherwise. You say that at this point it is not a hot path so if this is
not *that* important why not allow preemption and allow the schedule to
place you somewhere else if the scheduler decides that it is a good idea.

> > Also if interrupts and everything is enabled then someone else might
> > invoke kfree_rcu() from BH context for instance.
> > 
> And what? What is a problem here, please elaborate if you see any
> issues.

That the kfree_rcu() caller from BH context will end up here as well,
asking for a page.

Sebastian
