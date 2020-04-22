Return-Path: <SRS0=2A48=6G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9868FC54FCB
	for <rcu@archiver.kernel.org>; Wed, 22 Apr 2020 13:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 756CB2077D
	for <rcu@archiver.kernel.org>; Wed, 22 Apr 2020 13:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587562134;
	bh=NNiOPClwlL2Uf3TxN760MALFoiDiNkVe+JxJE9jpMJA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=2FNS3QahQDOPPKHLbmrSL4XcJBxPBDuqxVfHoPddIm32g39mzsb/Z1TOC35zRx0TQ
	 giig91r/dvGInItumNRwO0E0/Ro73mX4TWaew/NDV2dSpyRkJsV+O8dWf/FAvYqrCP
	 dwfDQlY48W6OHs2sIVeUL1KjAc1Gnux3n7C1eQwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgDVN2y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:28:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgDVN2x (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 22 Apr 2020 09:28:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DAE02076E;
        Wed, 22 Apr 2020 13:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587562133;
        bh=NNiOPClwlL2Uf3TxN760MALFoiDiNkVe+JxJE9jpMJA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ee9UfwH+/6GStN9KA6DLYc1cHHAmnpD9Nm6IdVpx3Cm6vn1AoC7F2XjKoi/Yui94A
         Z0ZPaWUW9qyi+AYQsiv5F8o4BBl5LWBUbOSy5kx7XGqcA7TOlNVIsOOHYa/5QTi0ra
         hyf+LsEV1BTOquW0lcQ04ISkeylaN79S4TNXp42E=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6FB323523118; Wed, 22 Apr 2020 06:28:53 -0700 (PDT)
Date:   Wed, 22 Apr 2020 06:28:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     joel@joelfernandes.org
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH rcu/dev -fixes 2/4] rcu/tree: Skip entry into the page
 allocator for PREEMPT_RT
Message-ID: <20200422132853.GM17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200420153837.194532-1-joel@joelfernandes.org>
 <20200420153837.194532-3-joel@joelfernandes.org>
 <20200422103536.GA16263@pc636>
 <51A69C78-FDD4-4A15-8969-EEA17CBA5BBD@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51A69C78-FDD4-4A15-8969-EEA17CBA5BBD@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 22, 2020 at 09:18:41AM -0400, joel@joelfernandes.org wrote:
> 
> 
> On April 22, 2020 6:35:36 AM EDT, Uladzislau Rezki <urezki@gmail.com> wrote:
> >On Mon, Apr 20, 2020 at 11:38:35AM -0400, Joel Fernandes (Google)
> >wrote:
> >> To keep kfree_rcu() path working on raw non-preemptible sections,
> >> prevent the optional entry into the allocator as it uses sleeping
> >locks.
> >> In fact, even if the caller of kfree_rcu() is preemptible, this path
> >> still is not, as krcp->lock is a raw spinlock as done in previous
> >> patches. With additional page pre-allocation in the works, hitting
> >this
> >> return is going to be much less likely soon so just prevent it for
> >now
> >> so that PREEMPT_RT does not break. Note that page allocation here is
> >an
> >> optimization and skipping it still makes kfree_rcu() work.
> >> 
> >> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >> Co-developed-by: Uladzislau Rezki <urezki@gmail.com>
> >> Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
> >> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >> ---
> >>  kernel/rcu/tree.c | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >> 
> >> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >> index cf68d3d9f5b81..cd61649e1b001 100644
> >> --- a/kernel/rcu/tree.c
> >> +++ b/kernel/rcu/tree.c
> >> @@ -3092,6 +3092,18 @@ kfree_call_rcu_add_ptr_to_bulk(struct
> >kfree_rcu_cpu *krcp,
> >>  		if (!bnode) {
> >>  			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
> >>  
> >> +			/*
> >> +			 * To keep this path working on raw non-preemptible
> >> +			 * sections, prevent the optional entry into the
> >> +			 * allocator as it uses sleeping locks. In fact, even
> >> +			 * if the caller of kfree_rcu() is preemptible, this
> >> +			 * path still is not, as krcp->lock is a raw spinlock.
> >> +			 * With additional page pre-allocation in the works,
> >> +			 * hitting this return is going to be much less likely.
> >> +			 */
> >> +			if (IS_ENABLED(CONFIG_PREEMPT_RT))
> >> +				return false;
> >> +
> >>  			bnode = (struct kfree_rcu_bulk_data *)
> >>  				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> >>  		}
> >This will not be correctly working by just reverting everything to the
> >"rcu_head path" for CONFIG_PREEMPT_RT kernel. We need to preallocate at
> >least once. I can add caching on top of this series to address it.
> 
> I discussed with Vlad offline, this patch is fine for mainline as we
> don't have headless support yet. So this patch is good. Future patches
> adding caching will also add the headless support after additional
> caching, so skipping the allocation here is ok.

Sounds good!

But would one of the realtime guys be willing to give a Tested-by?

							Thanx, Paul

> Thanks.
> 
> - Joel
> 
> 
> 
> 
> >--
> >Vlad Rezki
> 
> -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
