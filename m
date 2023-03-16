Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672FFC6FD1D
	for <rcu@archiver.kernel.org>; Thu, 16 Mar 2023 02:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjCPCwn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Mar 2023 22:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCPCwn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Mar 2023 22:52:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFFBCC31D;
        Wed, 15 Mar 2023 19:52:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B87BCCE1B57;
        Thu, 16 Mar 2023 02:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77B8C4339B;
        Thu, 16 Mar 2023 02:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678935155;
        bh=prdki508d/EU/CpUXuGD3FLz5/5n+Prl1V2uM5NYBCk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rgQWzBhv+PjlBOQ+ocMGed7LcVLcP+mu+tTe/3HauyJLE8SIVvux25lL4cwTTuP0z
         HI++FKfhEI2bfNKd8r0p3phml68fpHJUD97QgHRRKyNnHUgJGOiktsWjJJ+mjsV6FX
         VuxUY1Td9LOy0Ug2sriZGgxuMWKTHWkTtjyQcT/ZrUE2hr8HWOV+xTFm5u32q27U2B
         k8Gqz4eE+wpD8CqTyA1k1aUH4DrYBg5mFjt0rEYVPn5lrWbhI/MgfvuaBNrs42YPz6
         jwP3WJRd7IkwAoOpFPovTs7mpW6k16t2GGUALTGXLuYObWqjoQXAGJcVFZjznIdW9K
         yBiq3JL3L/JVQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 69C2B1540395; Wed, 15 Mar 2023 19:52:35 -0700 (PDT)
Date:   Wed, 15 Mar 2023 19:52:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Message-ID: <72a817c7-52fe-4a2d-8191-6f134ecfecaf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230315151415.2534e11c@gandalf.local.home>
 <e5a1815b-65b5-55ca-9773-ec04378d53c0@kernel.dk>
 <ZBIbloFMm5xRsjfn@pc636>
 <20230315153448.6914f85b@gandalf.local.home>
 <CAEXW_YTLFQ3-LApyCPNNx7Tn2ovFr8YUXL=1WVCm+rE2hRKE8g@mail.gmail.com>
 <20230315162840.106a5b4f@gandalf.local.home>
 <CAEXW_YTNNJJftsg1QRvhUCRoZpKa3SM6=-0M-cukCGt5=G+row@mail.gmail.com>
 <20230316012516.GK860405@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316012516.GK860405@mit.edu>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 15, 2023 at 09:25:16PM -0400, Theodore Ts'o wrote:
> On Wed, Mar 15, 2023 at 06:08:19PM -0400, Joel Fernandes wrote:
> > 
> > I am doubtful there may be a future where it does not sleep. Why?
> > Because you need an rcu_head *somewhere*.
> 
> I think the real problem was that this won't sleep:
> 
>    kfree_rcu(ptr, rhf);
> 
> While this *could* sleep:
> 
>    kfree_rcu(ptr);
> 
> So the the original sin was to try to make the same mistake that C++
> did --- which is to think that it's good to have functions that have
> the same name but different function signatures, and in some cases,
> different semantic meanings because they have different implementations.

Guilty to charges as read.  ;-)

> Personally, this is why I refuse to use C++ for any of my personal
> projects --- this kind of "magic" looks good, but it's a great way to
> potentially shoot yourself (or worse, your users) in the foot.
> 
> So separating out the two-argument kfree_rcu() from the one-argument
> kfree_rcu(), by renaming the latter to something else is IMHO, a
> Really F***** Good Idea.  So while, sure, kfree_rcu_mightsleep() might
> be a little awkward, the name documents the potential landmind
> involved with using that function, that's a good thing.  Because do
> you really think users will always conscientiously check the
> documentation and/or the implementation before using the interface?  :-)
> 
> If you hate that name, one other possibility is to try to use the
> two-argument form kfree_rcu() and arrange to *have* a rcu_head in the
> structure.  That's going to be better from a performance perspective,
> and thus kinder to the end user than using rcu_synchronize().

The original reason for single-argument kvfree_rcu() was to avoid
the need for that rcu_head.  The use case was a small data structure
with an extremely high population.

							Thanx, Paul
