Return-Path: <SRS0=oPal=A3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B733C433E4
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 15:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55CF12076D
	for <rcu@archiver.kernel.org>; Thu, 16 Jul 2020 15:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1hf64CMC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mVln4EgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgGPPgm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:36:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34056 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgGPPgl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Jul 2020 11:36:41 -0400
Date:   Thu, 16 Jul 2020 17:36:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594913800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Znin1qZ+GVKKZWfo8pTR1eebjm4kkJGTUgY2Ff7zFs=;
        b=1hf64CMCc0Fj0miZJXm5fWlr1x+X4rZ0/8IKFuL23AY19Kkitfbe5vN/cU0LDo5C+vAexw
        KyRrXl1xcF4oOre+ooBVnfK0hmqYVQJiDWQypcBauUFPgJe3+6xrQdd1l5h17ZF+AbdIeJ
        WfEw/YRuoQqwRne91sT6xtmjDuxrwkuIpTUGQP1n0i6quu9BmuM8eJy2JB5X4Ot0oCQZfJ
        ZzM/YkNZ2cOSq/gIjkcKtupxrDIueUCTVKq6pX9roQqm8ZzdEAbo1skjYotJMLzpSl69h/
        GFN4xb1E7v+/nnbWXCQUAGlloxxRLsLrrKRAof/k//8bSnXcTWsw54kcRSLwHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594913800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Znin1qZ+GVKKZWfo8pTR1eebjm4kkJGTUgY2Ff7zFs=;
        b=mVln4EgByMSCBqxuFMb+Cgh62v5trn1mfRNiJ5PRxrPIdAwcYPe6VY8njXiz9FDZuvohUy
        PHqWcj7Y0XUj+7CQ==
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
Message-ID: <20200716153638.gfh6dzp2h35ygfaa@linutronix.de>
References: <20200715183537.4010-1-urezki@gmail.com>
 <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
 <20200715190243.GA26735@pc636>
 <20200715193250.axntj7jdt6bw52dr@linutronix.de>
 <20200715221449.GJ9247@paulmck-ThinkPad-P72>
 <20200716141421.fzwf4tedr6rixd6d@linutronix.de>
 <20200716152027.GQ9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200716152027.GQ9247@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-07-16 08:20:27 [-0700], Paul E. McKenney wrote:
> You lost me on this one.  I am instead concerned that something like this
> might be needed on short notice:
> 
> 	raw_spin_lock(&some_lock);
> 	kfree_rcu(some_pointer, some_field_offset);
> 
> In contrast, single-argument kfree_rcu() cannot be invoked from any
> environment where synchronize_rcu() cannot be invoked.

I see. We don't have any kfree() in that context as far as I remember.
We had a few cases in "resize" where you allocate memory, copy content
and free old memory while under the lock but they are gone.

> > > Yes, dropping to a plain spinlock would be simple in the here and now,
> > > but experience indicates that it is only a matter of time, and that when
> > > that time comes it will come as an emergency.
> > 
> > Hmmm.
> 
> I point out the call_rcu() experience.
> 
> > > One approach would be to replace the "IS_ENABLED(CONFIG_PREEMPT_RT)"
> > > with some sort of check for being in a context where spinlock acquisition
> > > is not legal.  What could be done along those lines?
> > 
> > I would rethink the whole concept how this is implemented now and give
> > it another try. The code does not look pretty and is looking
> > complicated. The RT covering of this part then just added a simple
> > return because nothing else seemed to be possible. This patch here
> > looks like another duct tape attempt to avoid a warning.
> 
> In addition to the possibility of invocation from BH?

Invocation from BH should be possible because network would probably be
the first user. I don't remember anything wrong with BH if I remember
correctly.

> 							Thanx, Paul

Sebastian
