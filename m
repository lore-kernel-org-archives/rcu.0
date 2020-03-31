Return-Path: <SRS0=gdpO=5Q=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9448CC43331
	for <rcu@archiver.kernel.org>; Tue, 31 Mar 2020 17:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC2C2137B
	for <rcu@archiver.kernel.org>; Tue, 31 Mar 2020 17:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585676946;
	bh=7YB6ND8mrDeGDIhLt1OHuowTw1wah86m08QhZkfLdrg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=EqD2KdwmU3CGtu15omoUStpyQ81yrBBescbhqw28Y8Yd4epgNcDUINA1xfbdVDwy6
	 GoUj8TAtrvZGh7ZV0hdLrlD3+wgfJyyhF8PyfVDFttO9UhYsAFpF1ko3wakMnDDPLa
	 kP0zJv1wbEBhxBias+yfhpCBIY3xiSTfk23VaUWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgCaRtG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgCaRtF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 Mar 2020 13:49:05 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04076212CC;
        Tue, 31 Mar 2020 17:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585676945;
        bh=7YB6ND8mrDeGDIhLt1OHuowTw1wah86m08QhZkfLdrg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cYgWjwN1R88kTK3yT2gG1k3SpiZ9Vz0fYzWRtS56ooUUeRv4wJ+zDEmlu3P8LJOWP
         h8OEYSp4AikI9nTg/2BD2m4OiX2DEGbbakpNo75tOVvcmM9QGxkB+itppGyk5tKydr
         bh3+XF8WM7K0qL2ikOs7IigsYlsGE+HIoUSRWE8Q=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 72EED35226C3; Tue, 31 Mar 2020 10:49:04 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:49:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200331174904.GN19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331140433.GA26498@pc636>
 <20200331150911.GC236678@google.com>
 <20200331160119.GA27614@pc636>
 <20200331170232.GA28413@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331170232.GA28413@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Mar 31, 2020 at 07:02:32PM +0200, Uladzislau Rezki wrote:
> > >
> > > Paul was concerned about following scenario with hitting synchronize_rcu():
> > > 1. Consider a system under memory pressure.
> > > 2. Consider some other subsystem X depending on another system Y which uses
> > >    kfree_rcu(). If Y doesn't complete the operation in time, X accumulates
> > >    more memory.
> > > 3. Since kfree_rcu() on Y hits synchronize_rcu() a lot, it slows it down.
> > >    This causes X to further allocate memory, further causing a chain
> > >    reaction.
> > > Paul, please correct me if I'm wrong.
> > > 
> > I see your point and agree that in theory it can happen. So, we should
> > make it more tight when it comes to rcu_head attachment logic.
> > 
> Just adding more thoughts about such concern. Even though in theory we
> can run into something like that. But also please note, that under high
> memory pressure it also does not mean that (X) will always succeed with
> further infinite allocations, so memory pressure is something common.
> As soon as the situation becomes slightly better we do our work much
> efficient.
> 
> Practically, i was trying to simulate memory pressure to hit synchronize_rcu()
> on my test system. By just simulating head-less freeing(for any object) and
> by always dynamic attaching path. So i could trigger it, but that was really
> hard to achieve and it happened only few times. So that was not like a constant
> hit. What i got constantly were:
> 
> - System got recovered and proceed with "normal" path;
> - The OOM hit as a final step, when the system is run out of memory fully.
> 
> So, practically i have not seen massive synchronize_rcu() hit.

Understood, but given the attractive properties of headless kfree_rcu(),
it is not unreasonable to expect its usage to remain low.  In addition,
memory-pressure scenarios can be quite involved.  Finally, as Joel
pointed out offlist, the per-CPU cached structure acts as a small
portion of kfree_rcu()-specific reserved memory, so you guys have at
least partially addressed parts of my concerns already.

I am not at all a fan of using GFP_MEMALLOC because kfree_rcu()
is sufficiently low-level to be in the business of ensuring its own
forward progress.

							Thanx, Paul
