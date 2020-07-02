Return-Path: <SRS0=c9Wv=AN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240C9C433DF
	for <rcu@archiver.kernel.org>; Thu,  2 Jul 2020 14:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0041220772
	for <rcu@archiver.kernel.org>; Thu,  2 Jul 2020 14:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kKX0pWMw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eTwEnRvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgGBOM0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbgGBOMV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Jul 2020 10:12:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EA4C08C5DC;
        Thu,  2 Jul 2020 07:12:21 -0700 (PDT)
Date:   Thu, 2 Jul 2020 16:12:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593699138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cwTVNjRP46CGgsTBRixpnycU9jLYSLhEYRlI1gaMWYo=;
        b=kKX0pWMwnPp5WQSJFDYNNGgxzoRwWlwHYx/dhsfi59qGaidMG9d5j4G/jHrvmVzaQU4UXv
        9v6nFNe1//vG8mHw1b2wwwZVhTz/v0swjoBwp+yTu/0lT3IgLDlJWuiRXetM2Tj8im7OpH
        lbBGLs/PwcT+lutRhvAflyZnIhGgloQnY3ZEl1hOjzD0zFClc+NrKAqiZt97XM1iinwMlo
        8qGbo6W8sycMjh8ld8q3YrSSWglUkuiEkeH+i2JP6cYYsfkeYUAd4dMcMb23K7JGCr1eGx
        63L8wTpCvPqqpawrKzQ5jSwFUNZBbh8x5KCmRzQlCftWRzK3QlIK4sMUY5zrlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593699138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cwTVNjRP46CGgsTBRixpnycU9jLYSLhEYRlI1gaMWYo=;
        b=eTwEnRvlYJS0kZTlP2TOH/CU4wZd1QyZzsY1ezBUN8Y5EG4wmE1qY4MIBe3C6xl68JAhGa
        pIVv6XMIN0n+AWAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH tip/core/rcu 03/17] rcu/tree: Skip entry into the page
 allocator for PREEMPT_RT
Message-ID: <20200702141216.r4rbt5w3hjzafpgg@linutronix.de>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
 <20200624201226.21197-3-paulmck@kernel.org>
 <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
 <20200630183534.GG9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200630183534.GG9247@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-06-30 11:35:34 [-0700], Paul E. McKenney wrote:
> > This is not going to work together with the "wait context validator"
> > (CONFIG_PROVE_RAW_LOCK_NESTING). As of -rc3 it should complain about
> > printk() which is why it is still disabled by default.
> 
> Fixing that should be "interesting".  In particular, RCU CPU stall
> warnings rely on the raw spin lock to reduce false positives due
> to race conditions.  Some thought will be required here.

I don't get this part. Can you explain/give me an example where to look
at?

> > So assume that this is fixed and enabled then on !PREEMPT_RT it will
> > complain that you have a raw_spinlock_t acquired (the one from patch
> > 02/17) and attempt to acquire a spinlock_t in the memory allocator.
> 
> Given that the slab allocator doesn't acquire any locks until it gets
> a fair way in, wouldn't it make sense to allow a "shallow" allocation
> while a raw spinlock is held?  This would require yet another GFP_ flag,
> but that won't make all that much of a difference in the total.  ;-)

That would be one way of dealing with. But we could go back to
spinlock_t and keep the memory allocation even for RT as is. I don't see
a downside of this. And we would worry about kfree_rcu() from real
IRQ-off region once we get to it.

> 							Thanx, Paul
> 
> > >  			bnode = (struct kfree_rcu_bulk_data *)
> > >  				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > >  		}

Sebastian
