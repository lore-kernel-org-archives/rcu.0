Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AC8C4332F
	for <rcu@archiver.kernel.org>; Thu, 15 Dec 2022 21:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiLOVdy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Dec 2022 16:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLOVdx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Dec 2022 16:33:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE868164A5;
        Thu, 15 Dec 2022 13:33:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82A68B81BD9;
        Thu, 15 Dec 2022 21:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129D4C433D2;
        Thu, 15 Dec 2022 21:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671140030;
        bh=hJ5iqgm1GdV3GX3WP99vnbdxZys/wv6qdwFnAzEj01I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pkpnQLsoLob9PaTp2AKLede44mzd5JDlF43sQVYY9FP709piXsmb/d3LMXzYiieWD
         3w4Ai8odpv8jqScKRQNdNM8yBesvcrqkxhyc4Ni3Cyy22mPMKWEbWR/xnajOrIBxE8
         X7/ZqyZvfE3Q/7shTkZWW4y4o2oZC4/9HvvmQmT4mrUZPiDM5Gal2qsIDqYQ852Xjo
         kV6g8zJcTkKr+LM0fLlKr40kFUL76olwCuMbkyZrsDwHhdSeuJimHDY0IWT4KeAHkZ
         sN842dPRpaMfVbK0N2a2UQNsfPSksukGl5LGA12apn8hLk5lyBbjxuowcg+vrieK2R
         sHW2rNn6zujeQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A69095C1C5B; Thu, 15 Dec 2022 13:33:49 -0800 (PST)
Date:   Thu, 15 Dec 2022 13:33:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/2] rcu/kvfree: Carefully reset number of objects in krcp
Message-ID: <20221215213349.GP4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221214120630.379527-1-urezki@gmail.com>
 <20221215204022.GN4001@paulmck-ThinkPad-P17-Gen-1>
 <Y5uOnzBA7D30VUQY@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5uOnzBA7D30VUQY@pc636>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Dec 15, 2022 at 10:16:15PM +0100, Uladzislau Rezki wrote:
> On Thu, Dec 15, 2022 at 12:40:22PM -0800, Paul E. McKenney wrote:
> > On Wed, Dec 14, 2022 at 01:06:29PM +0100, Uladzislau Rezki (Sony) wrote:
> > > Problem. A schedule_delayed_monitor_work() relays on the
> > > number of pointers queued into krcp. Based on that number
> > > and threshold the work is rearmed with different delayed
> > > intervals, i.e. sooner or later.
> > > 
> > > There are three pipes where pointers can be placed. When
> > > any pipe is offloaded the krcp->count counter is set to
> > > zero - what is wrong. Because another pipes might not be
> > > empty.
> > > 
> > > Fix it by maintaining a counter individually per a pipe.
> > > In order to get a number of objects per a krcp introduce
> > > a krc_count() helper.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > 
> > Queued and pushed for further review and testing, and with the usual
> > wordsmithing.  Much better use of workqueue handlers, thank you!!!
> > 
> <snip>
>    This commit therefore maintains per-pipe counters, and introduces a a
>    krc_count() helper to access the aggregate value of those
>    counters.
> <snip>
> 
> a a ? :)

Good eyes!  I will fix on my next rebase.

							Thanx, Paul
