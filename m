Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE54C433E0
	for <rcu@archiver.kernel.org>; Mon, 25 Jan 2021 16:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 141F522795
	for <rcu@archiver.kernel.org>; Mon, 25 Jan 2021 16:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbhAYQdn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 Jan 2021 11:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbhAYQ1Q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 Jan 2021 11:27:16 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A68C0613D6;
        Mon, 25 Jan 2021 08:26:05 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id f2so10799469ljp.11;
        Mon, 25 Jan 2021 08:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pwiBAJcXYk8d7kT5fmV95SV7WAmrxHsioIdFAWPZ7cs=;
        b=L8o1UrrEFpCjbC+bRyN15Jhx0D19SfJEVpzjAqtevIxwNchxm1wC9LK5lbb+af17p1
         l0C2jiTNpqYYZpBbXpH2e0WZST2qHNiPTaaYHEeULnSi2lQZCuCB01GGpaXApBpVGfJ8
         t4N1YWCForZTUrbRzZ1wGWnWqNhKSU1imQj9jlOCG8WjMk9z54Te6nyTBlwZrbfapVNt
         KOs56wtG4jpINOa3fM51Twa28b4kDQJpdUvR6KQLP7UWWubUAeDClWOyEEjORrI9Y8tP
         7t8cL2JS4v1KeIGoWSud5qKBCIz0In93ApU2vzy5Uwp3ILb9GR1G+dqvi/K5tUWlB1gc
         YgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pwiBAJcXYk8d7kT5fmV95SV7WAmrxHsioIdFAWPZ7cs=;
        b=TUc+KY9QgQTyAlFkwPwTglpsYX45d3n4SZM17Lr9bSW9NwULkWZUXZ+gyRYImJnA+s
         KWSNQfSL2P10C4HYKSCpdhn05I472pkiEIZV5vHPZ6bvOhy9On+xjmq9DJCn7eJFDXgL
         8O1AWM2n52YOLn8LNhB3OXNEUyTIOI7139J6P2UmHxnCfhOKtcXnQBrIZMkH7V39xalk
         mVuosGtKfdOqrAZ/QEYciDkZ25H6fz+t6KgEprCubcQW42KazrjlC2Z3xEjaMgWYBwa4
         z5dNRS0jMFkpObps3OuLi+jJ5gLFT2uxQpgtXZSF+bXEafJuYd6AITuiBpzbnPeGOIu5
         RqUg==
X-Gm-Message-State: AOAM533G9vuVq2IicsIRF32uyD4CwIDpeuCKERPYk+A52iCBS+0EIqzI
        88tacRBSRO7XiTzheAEL0iM=
X-Google-Smtp-Source: ABdhPJyX8tp9f2RFd1Z3a9fsWAs40Rjv4MfVUtkXuu1ZDEkw1ViCeMQo1Z1byhVy2PYh4qg53nh/tQ==
X-Received: by 2002:a2e:914b:: with SMTP id q11mr518510ljg.503.1611591963587;
        Mon, 25 Jan 2021 08:26:03 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id 10sm334972lfq.53.2021.01.25.08.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 08:26:02 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 25 Jan 2021 17:25:59 +0100
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/3] kvfree_rcu: Allocate a page for a single argument
Message-ID: <20210125162559.GA52712@pc638.lan>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210125132236.GJ827@dhcp22.suse.cz>
 <20210125143150.GA2282@pc638.lan>
 <20210125153943.GN827@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125153943.GN827@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jan 25, 2021 at 04:39:43PM +0100, Michal Hocko wrote:
> On Mon 25-01-21 15:31:50, Uladzislau Rezki wrote:
> > > On Wed 20-01-21 17:21:46, Uladzislau Rezki (Sony) wrote:
> > > > For a single argument we can directly request a page from a caller
> > > > context when a "carry page block" is run out of free spots. Instead
> > > > of hitting a slow path we can request an extra page by demand and
> > > > proceed with a fast path.
> > > > 
> > > > A single-argument kvfree_rcu() must be invoked in sleepable contexts,
> > > > and that its fallback is the relatively high latency synchronize_rcu().
> > > > Single-argument kvfree_rcu() therefore uses GFP_KERNEL|__GFP_RETRY_MAYFAIL
> > > > to allow limited sleeping within the memory allocator.
> > > 
> > > __GFP_RETRY_MAYFAIL can be quite heavy. It is effectively the most heavy
> > > way to allocate without triggering the OOM killer. Is this really what
> > > you need/want? Is __GFP_NORETRY too weak?
> > > 
> > Hm... We agreed to proceed with limited lightwait memory direct reclaim.
> > Johannes Weiner proposed to go with __GFP_NORETRY flag as a starting
> > point: https://www.spinics.net/lists/rcu/msg02856.html
> > 
> > <snip>
> >     So I'm inclined to suggest __GFP_NORETRY as a starting point, and make
> >     further decisions based on instrumentation of the success rates of
> >     these opportunistic allocations.
> > <snip>
> 
> I completely agree with Johannes here.
> 
> > but for some reason, i can't find a tail or head of it, we introduced
> > __GFP_RETRY_MAYFAIL what is a heavy one from a time consuming point of view.
> > What we would like to avoid.
> 
> Not that I object to this use but I think it would be much better to use
> it based on actual data. Going along with it right away might become a
> future burden to make any changes in this aspect later on due to lack of 
> exact reasoning. General rule of thumb for __GFP_RETRY_MAYFAIL is really
> try as hard as it can get without being really disruptive (like OOM
> killing something). And your wording didn't really give me that
> impression.
> 
Initially i proposed just to go with GFP_NOWAIT flag. But later on there
was a discussion about a fallback path, that uses synchronize_rcu() can be
slow, thus minimizing its hitting would be great. So, here we go with a
trade off.

Doing it hard as __GFP_RETRY_MAYFAIL can do, is not worth(IMHO), but to have some
light-wait requests would be acceptable. That is why __GFP_NORETRY was proposed.

There were simple criterias we discussed which we would like to achieve:

a) minimize a fallback hitting;
b) avoid of OOM involving;
c) avoid of dipping into the emergency reserves. See kvfree_rcu: Use __GFP_NOMEMALLOC for single-argument kvfree_rcu()

--
Vlad Rezki
