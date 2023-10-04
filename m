Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EE4E936E7
	for <rcu@archiver.kernel.org>; Wed,  4 Oct 2023 21:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjJDV1f (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Oct 2023 17:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjJDV1f (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Oct 2023 17:27:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCCC90;
        Wed,  4 Oct 2023 14:27:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD68C433C7;
        Wed,  4 Oct 2023 21:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696454852;
        bh=McDwHeyXhnUOJ8z4rwgYdReeRma5yLjZTuGvtKXX6cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uGzgSUTdPDTr9aMaAwt6yrpcNZpDhu6cFOGMJC/dnwt40MT3KMR3Ugq6fARuXr3d0
         fqSA3/v7247UTCG+pVEvkuKYQpF95j412KKLcBLkRjVtvVXPnvQK7LaKZhPD0aqahX
         RmG2ITWQDVaf4hSrGCJcLOlfj6PfFtlkotjvGAkj1UJ/m21oCoDPISOg1wF+xgzXZ9
         6+7rLUBx+0RzOdU2yuN+2P5HP4pvdxW5vGLjGM4ftEaf1B7fV4caxxGxZi/VDziLW9
         C5Qiv4xowh6dVDNMyJl+rlxy7m1Z8IqcAVwy2w9iuvBfZr+j7nHYO9hCTYKU+zNty/
         qWtRc+HROYGdg==
Date:   Wed, 4 Oct 2023 23:27:29 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yong He <zhuangel570@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/5] srcu fixes
Message-ID: <ZR3YwR4FriKP_Pab@localhost.localdomain>
References: <20231003232903.7109-1-frederic@kernel.org>
 <f214737a-6856-455f-ac86-9f7ec605b902@paulmck-laptop>
 <1d21ceee-56d3-4784-9e6f-0a766c773833@paulmck-laptop>
 <811d08e3-efb8-4398-8fbc-6b5d030afb15@paulmck-laptop>
 <ZR0yMdyoA5biYYxg@lothringen>
 <77322b72-1d95-46c6-9837-1d811b36336c@paulmck-laptop>
 <02d3ae63-8e52-4931-acf6-32ef69a6511a@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02d3ae63-8e52-4931-acf6-32ef69a6511a@paulmck-laptop>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Le Wed, Oct 04, 2023 at 09:47:04AM -0700, Paul E. McKenney a écrit :
> > The 10-hour 40-CPU SRCU-P run and pair of 10-hour 16-CPU SRCU-N runs
> > completed without failure.  The others had some failures, but I need
> > to look and see if any were unexpected.  In the meantime, I started a
> > two-hour 40-CPU SRCU-P run and a pair of one-hour 16-CPU SRCU-N runs on
> > just that first commit.  Also servicing SIGSHOWER and SIGFOOD.  ;-)
> 
> And the two-hour 40-CPU SRCU-P run and a pair of two-hour 16-CPU SRCU-N
> runs (on only the first commit) completed without incident.
> 
> The other set of overnight full-stack runs had only tick-stop errors,
> so I started a two-hour set on the first commit.
> 
> So far so good!

Very nice!

As for the tick-stop error, see the upstream fix:

   1a6a46477494 ("timers: Tag (hr)timer softirq as hotplug safe")

Thanks!
