Return-Path: <SRS0=oPal=A3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4923C433E1
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 14:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CFBD207DD
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 14:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3L7sNJi9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CmaaA0Fy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgGPOO0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgGPOOZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Jul 2020 10:14:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AA4C061755;
        Thu, 16 Jul 2020 07:14:25 -0700 (PDT)
Date:   Thu, 16 Jul 2020 16:14:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594908863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AAXlecMOFFlUauM/8ONbVZjnpZpBV3pslxC+IrQ6lXU=;
        b=3L7sNJi9VXo9Z5SmOslhbPfXNdmNOC/okJbIRApJQOVGSJHYxx3zwEI/NWVJtsP3JGmZud
        I63zlGcDTBzr7GduXcDlNUUgW8W1HLsbe951Dy5inHl3BnvEczyvua/WyfJTJPnlnIELUz
        0alHHrk1IZG/c9MMwTqFXZmUxgC5/SKi70ESzexzdMbcpd8SNAUMrtZQYAy3Vz4mr2RqGF
        RDt6sMFncZVSXQS4YmcmtESaIQRW2ckHE02Zt5q4IMN3dz2S/pEKXELvpma5Uh4XtW4hgc
        ALaHYuaZv3QGSyJrZDx04XbDKf+IkhaIVib9AxLiIQylgBb+ShhV6CxaUpuDVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594908863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AAXlecMOFFlUauM/8ONbVZjnpZpBV3pslxC+IrQ6lXU=;
        b=CmaaA0FyUpNJji9awzQD8Ot8BPXYUIJarkWbz1mYy2rj1VmNgJ75ieNKdI2WsJd0IfxG5u
        xlc/8jOjBf5sFDCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: Drop the lock before entering to page
 allocator
Message-ID: <20200716141421.fzwf4tedr6rixd6d@linutronix.de>
References: <20200715183537.4010-1-urezki@gmail.com>
 <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
 <20200715190243.GA26735@pc636>
 <20200715193250.axntj7jdt6bw52dr@linutronix.de>
 <20200715221449.GJ9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200715221449.GJ9247@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-07-15 15:14:49 [-0700], Paul E. McKenney wrote:
> 
> My concern is that some critical bug will show up at some point
> that requires double-argument kfree_rcu() be invoked while holding
> a raw spinlock.  (Single-argument kfree_rcu() must sometimes invoke
> synchronize_rcu(), so it can never be invoked in any state forbidding
> invoking schedule().)

So you are saying as of today we are good but in near future the
following
   synchronize_rcu() -> kfree_rcu()

may be needed?

> Yes, dropping to a plain spinlock would be simple in the here and now,
> but experience indicates that it is only a matter of time, and that when
> that time comes it will come as an emergency.

Hmmm.

> One approach would be to replace the "IS_ENABLED(CONFIG_PREEMPT_RT)"
> with some sort of check for being in a context where spinlock acquisition
> is not legal.  What could be done along those lines?

I would rethink the whole concept how this is implemented now and give
it another try. The code does not look pretty and is looking
complicated. The RT covering of this part then just added a simple
return because nothing else seemed to be possible. This patch here
looks like another duct tape attempt to avoid a warning.

> 							Thanx, Paul

Sebastian
