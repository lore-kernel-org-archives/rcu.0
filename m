Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C024C2D0E4
	for <rcu@archiver.kernel.org>; Sun, 15 Nov 2020 20:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E43CF20DD4
	for <rcu@archiver.kernel.org>; Sun, 15 Nov 2020 20:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oG3pdk/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgKOUgF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 15 Nov 2020 15:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKOUgF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 15 Nov 2020 15:36:05 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DAFC0613CF
        for <rcu@vger.kernel.org>; Sun, 15 Nov 2020 12:36:04 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id q5so14738120qkc.12
        for <rcu@vger.kernel.org>; Sun, 15 Nov 2020 12:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YYKczJqMFndpNNStZpBBynpDxqg/zBKJGa1TcL1NcyY=;
        b=oG3pdk/6KpsALh91Ik10axMQA3XccHwrNc0b7t1HKX3Zo3ke0wYAMsvO1E94eaMaEe
         46qaIr1TKz4h6bWmcwHUhyJ2rZsrPPeTOtapgnttEHaoOgJkdII3p6IpTW3rAeEw08yU
         IQc01W56Qxp2rZ0YMwgJCngDJmqOCNJV/8ndoV6SP9tIAH9ZU1Yej1a9aPdWOz0/tMZZ
         EkweR8zB+9Ihxzqa65h/wpDO/JCdh/I22HepTsKPgHAbiEbz0U7EqBUqdzBJwDL3aJGp
         ZmrX5EFuH5D3yebw9pWd3zV6EKhhbnaWTdoFdKIgC3itdJkK7H7a86U2WsgdLbl3McJW
         9EPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YYKczJqMFndpNNStZpBBynpDxqg/zBKJGa1TcL1NcyY=;
        b=UnFaQcZ11WQ4SctMZbXYvL+MKPpzWayJnTLjKczCijLEtNkCqlui4fFCHWgrGqGOqx
         1U2lN5OK1tTqUX4SmPMO7Pt/pOE2EwpALl1KAiVqNA9ef67IpwQnO3g3HnDZvTgAozCX
         K+EBnfjA8KQ8Ow9hu5Tu6pcSHWEuUPZX4tSO8VGmfFVA7BI6U5hshRH0FleUGo2NNX39
         cUPuL7UhoWqqxO8rDUsWWl84bMOkbdOdYshW9hMuG5h4d+dC9GeAloqJkb2MXI0Vx0t0
         yWOpHABa/3nDE6E91fxvXw5qlY4mOfwsdh6fIxYwZwGkVHorsDMwUXGsN2d0f4R1HPXA
         xnlw==
X-Gm-Message-State: AOAM530zjWcNxX26Gi7Gi5OsNeAMbdRlVKukFxZuEz/AjwOEw+Fyhc5b
        cOEWjAMoAwbe+x3LraaXNQnPoJuBCVxH
X-Google-Smtp-Source: ABdhPJxxlrDroYP19SIIsXznZsBWbFz08GqRi/PXfWF3guIj4XkMg3hRinuZDhrmRTgGDU3M1ta2NA==
X-Received: by 2002:a37:e40b:: with SMTP id y11mr12105279qkf.29.1605472564090;
        Sun, 15 Nov 2020 12:36:04 -0800 (PST)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id j25sm11378920qtk.79.2020.11.15.12.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 12:36:03 -0800 (PST)
Date:   Sun, 15 Nov 2020 15:35:51 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org
Subject: Re: SRCU question
Message-ID: <20201115203551.GA3655723@moria.home.lan>
References: <20201112201547.GF3365678@moria.home.lan>
 <20201115201124.GL3249@paulmck-ThinkPad-P72>
 <20201115202017.GA8197@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115202017.GA8197@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Nov 15, 2020 at 12:20:17PM -0800, Paul E. McKenney wrote:
> On Sun, Nov 15, 2020 at 12:11:24PM -0800, Paul E. McKenney wrote:
> > On Thu, Nov 12, 2020 at 03:15:47PM -0500, Kent Overstreet wrote:
> > > Hi to Paul & the rcu mailing list,
> > > 
> > > I've got a problem I'm trying to figure out if I can adapt SRCU for.
> > > 
> > > Within bcachefs, currently struct btree obects, and now also btree_cached_key,
> > > aren't freed until the filesystem is torn down, because btree iterators contain
> > > pointers to them and will drop and retake locks (iff a sequence number hasn't
> > > changed) without holding a ref. With the btree key cache code, this is now
> > > something I need to fix.
> > > 
> > > What I plan on doing is having struct btree_trans (container for btree
> > > iterators) hold an srcu read lock while it's alive. But, I don't want to just
> > > use call_srcu to free the btree/btree_cached_key objects, because btree trans
> > > objects can at times be fairly long lived and the existing code can reuse these
> > > objects for other btree nodes/btree cached keys immediately. Freeing them with
> > > call_srcu() would break that; I could have my callback function check if the
> > > object has been reused before freeing, but I'd still have a problem when the
> > > object gets freed a second time before the first call_scru() has finished.
> > > 
> > > What I'm wondering is if the SRCU code has a well defined notion of a clock that
> > > I could make use of. What I would like to do is, instead of doing call_srcu() to
> > > free the object - just mark that object with the current SRCU context time, and
> > > then when my shrinkers run they can free objects that haven't been reused and
> > > are old enough according the the current SRCU time.
> > > 
> > > Thoughts?
> > 
> > An early prototype is available on -rcu [1].  The Tree SRCU version
> > seems to be reasonably reliable, but I do not yet trust the Tiny SRCU
> > implementation.  So please avoid !SMP&&!PREEMPT if you would like to
> > give it a try.  Unless you -really- like helping me find bugs, in which
> > case full speed ahead!!!
> > 
> > Here is the API:
> > 
> > unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)
> > 
> > 	Returns a "cookie" that can be thought of as a snapshot of your
> > 	"clock" above.	(SRCU calls it a "grace-period sequence number".)
> > 	Also ensures that enough future grace periods happen to eventually
> > 	make the grace-period sequence number reach the cookie.
> > 
> > bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
> > 
> > 	Given a cookie from start_poll_synchronize_srcu(), returns true if
> > 	at least one full SRCU grace period has elapsed in the meantime.
> > 	Given finite SRCU readers in a well-behaved kernel, the following
> > 	code will complete in finite time:
> > 
> > 		cookie = start_poll_synchronize_srcu(&my_srcu);
> > 		while (!poll_state_synchronize_srcu(&my_srcu, cookie))
> > 			schedule_timeout_uninterruptible(1);
> > 
> > unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp)
> > 
> > 	Like start_poll_synchronize_srcu(), except that it does not start
> > 	any grace periods.  This means that the following code is -not-
> > 	guaranteed to complete:
> > 
> > 		cookie = get_state_synchronize_srcu(&my_srcu);
> > 		while (!poll_state_synchronize_srcu(&my_srcu, cookie))
> > 			schedule_timeout_uninterruptible(1);
> > 
> > 	Use this if you know that something else will be starting the
> > 	needed SRCU grace periods.  This might also be useful if you
> > 	had items that were likely to be reused before the SRCU grace
> > 	period elapsed, so that you avoid burning CPU on SRCU grace
> > 	periods that prove to be unnecessary.  Or if you don't want
> > 	to have more than (say) 100 SRCU grace periods per seconds,
> > 	in which case you might use a timer to start the grace periods.
> > 	Or maybe you don't bother starting the SRCU grace period until
> > 	some sort of emergency situation has arisen.  Or...
> > 
> > 	OK, maybe you don't need it, but I do need it for rcutorture,
> > 	so here it is anyway.
> > 
> > All of these can be invoked anywhere that call_srcu() can be invoked.
> > 
> > Does this look like it will work for you?

Yeah. My one quibble is, instead of having to call poll_state_synchronize_srcu()
on every cookie - would it be possible to get function that returns a cookie we
can compare against (i.e. with time_after())? I'm going to be use this in the
shrinker where we have to walk and check potentially tens of thousands of
objects.

> Oh, and due to historical inertia, Tiny SRCU's grace-period sequence
> number is only 16 bits.  I can change this easily, but I need to know
> that it is a real problem for you before I can do so.
> 
> The potential problem for you is that if you let a given cookie lie
> dormant for 16384 grace periods, it will take another 16385 grace
> periods for get_state_synchronize_srcu() to say that a grace period
> has elapsed.
> 
> In contrast, Tree SRCU's grace-period sequence number is either 32 bits
> or 64 bits, depending on the size of unsized long.

It's not something I'd lose sleep over, but I think it could be. If there isn't
memory pressure, then the shrinker won't be running and we won't be freeing the
objects with the oldest cookies, but freeing them internally will be creating
new grace periods - but if I make sure we're reusing objects in LIFO order would
also work against the shrinker actually being able to free any objects, so not
sure I want to do that...
