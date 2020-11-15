Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1F8C2D0E4
	for <rcu@archiver.kernel.org>; Sun, 15 Nov 2020 20:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A02204EF
	for <rcu@archiver.kernel.org>; Sun, 15 Nov 2020 20:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zxopXdlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgKOUL0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 15 Nov 2020 15:11:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbgKOULZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 15 Nov 2020 15:11:25 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF76D204EF;
        Sun, 15 Nov 2020 20:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605471084;
        bh=OI/7/u1Bbzu2/RAJTagBeE4Y9AXETwmpVhZIwcp8ULI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=zxopXdlIkfHQqMDZbHTk8eObs8O0w46DnMQEaHHCar0auTMkyAZeJJSh+akt1aTXa
         A69tyCgNM0/Myv6fXeD4v7uZURQ0NeKoFFj95mOL7hYSW+jxd4pSDMZRGnGf5gJoAJ
         okY2PWp+cmdqmhBAGEhWrw5EgYE1t45CyFQw8zzw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 875063522ABD; Sun, 15 Nov 2020 12:11:24 -0800 (PST)
Date:   Sun, 15 Nov 2020 12:11:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     rcu@vger.kernel.org
Subject: Re: SRCU question
Message-ID: <20201115201124.GL3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201112201547.GF3365678@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112201547.GF3365678@moria.home.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 12, 2020 at 03:15:47PM -0500, Kent Overstreet wrote:
> Hi to Paul & the rcu mailing list,
> 
> I've got a problem I'm trying to figure out if I can adapt SRCU for.
> 
> Within bcachefs, currently struct btree obects, and now also btree_cached_key,
> aren't freed until the filesystem is torn down, because btree iterators contain
> pointers to them and will drop and retake locks (iff a sequence number hasn't
> changed) without holding a ref. With the btree key cache code, this is now
> something I need to fix.
> 
> What I plan on doing is having struct btree_trans (container for btree
> iterators) hold an srcu read lock while it's alive. But, I don't want to just
> use call_srcu to free the btree/btree_cached_key objects, because btree trans
> objects can at times be fairly long lived and the existing code can reuse these
> objects for other btree nodes/btree cached keys immediately. Freeing them with
> call_srcu() would break that; I could have my callback function check if the
> object has been reused before freeing, but I'd still have a problem when the
> object gets freed a second time before the first call_scru() has finished.
> 
> What I'm wondering is if the SRCU code has a well defined notion of a clock that
> I could make use of. What I would like to do is, instead of doing call_srcu() to
> free the object - just mark that object with the current SRCU context time, and
> then when my shrinkers run they can free objects that haven't been reused and
> are old enough according the the current SRCU time.
> 
> Thoughts?

An early prototype is available on -rcu [1].  The Tree SRCU version
seems to be reasonably reliable, but I do not yet trust the Tiny SRCU
implementation.  So please avoid !SMP&&!PREEMPT if you would like to
give it a try.  Unless you -really- like helping me find bugs, in which
case full speed ahead!!!

Here is the API:

unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)

	Returns a "cookie" that can be thought of as a snapshot of your
	"clock" above.	(SRCU calls it a "grace-period sequence number".)
	Also ensures that enough future grace periods happen to eventually
	make the grace-period sequence number reach the cookie.

bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)

	Given a cookie from start_poll_synchronize_srcu(), returns true if
	at least one full SRCU grace period has elapsed in the meantime.
	Given finite SRCU readers in a well-behaved kernel, the following
	code will complete in finite time:

		cookie = start_poll_synchronize_srcu(&my_srcu);
		while (!poll_state_synchronize_srcu(&my_srcu, cookie))
			schedule_timeout_uninterruptible(1);

unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp)

	Like start_poll_synchronize_srcu(), except that it does not start
	any grace periods.  This means that the following code is -not-
	guaranteed to complete:

		cookie = get_state_synchronize_srcu(&my_srcu);
		while (!poll_state_synchronize_srcu(&my_srcu, cookie))
			schedule_timeout_uninterruptible(1);

	Use this if you know that something else will be starting the
	needed SRCU grace periods.  This might also be useful if you
	had items that were likely to be reused before the SRCU grace
	period elapsed, so that you avoid burning CPU on SRCU grace
	periods that prove to be unnecessary.  Or if you don't want
	to have more than (say) 100 SRCU grace periods per seconds,
	in which case you might use a timer to start the grace periods.
	Or maybe you don't bother starting the SRCU grace period until
	some sort of emergency situation has arisen.  Or...

	OK, maybe you don't need it, but I do need it for rcutorture,
	so here it is anyway.

All of these can be invoked anywhere that call_srcu() can be invoked.

Does this look like it will work for you?

							Thanx, Paul

[1] git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
