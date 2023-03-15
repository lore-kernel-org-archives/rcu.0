Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180B2C61DA4
	for <rcu@archiver.kernel.org>; Wed, 15 Mar 2023 19:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjCOTOd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Mar 2023 15:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjCOTOc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Mar 2023 15:14:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7249B2F6;
        Wed, 15 Mar 2023 12:14:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFBBF61120;
        Wed, 15 Mar 2023 19:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE03C433D2;
        Wed, 15 Mar 2023 19:14:17 +0000 (UTC)
Date:   Wed, 15 Mar 2023 15:14:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Message-ID: <20230315151415.2534e11c@gandalf.local.home>
In-Reply-To: <20230201150815.409582-1-urezki@gmail.com>
References: <20230201150815.409582-1-urezki@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed,  1 Feb 2023 16:08:06 +0100
"Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> This small series is based on Paul's "dev" branch. Head is 6002817348a1c610dc1b1c01ff81654cdec12be4
> it renames a single argument of k[v]free_rcu() to its new k[v]free_rcu_mightsleep() name.
> 
> 1.
> The problem is that, recently we have run into a precedent when
> a user intended to give a second argument to kfree_rcu() API but
> forgot to do it in a code so a call became as a single argument
> of kfree_rcu() API.
> 
> 2.
> Such mistyping can lead to hidden bags where sleeping is forbidden.
> 
> 3.
> _mightsleep() prefix gives much more information for which contexts
> it can be used for.

My honest opinion is that I hate that name "kvfree_rcu_mightsleep()" ;-)

As I honestly don't know why it might sleep.

I didn't care about the name before, but now that it's touching code I
maintain I do care ;-)

Why not call it:

 kvfree_rcu_synchronize()

?

As that is much more descriptive of what it does. Especially since these
ugly names are popping up in my code because kvfree_rcu() replaced a
rcu_synchronize() in the first place.

-- Steve
