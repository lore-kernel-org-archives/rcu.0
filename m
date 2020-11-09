Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D503FC2D0A3
	for <rcu@archiver.kernel.org>; Mon,  9 Nov 2020 16:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DAD82074F
	for <rcu@archiver.kernel.org>; Mon,  9 Nov 2020 16:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604938808;
	bh=oqLUZkDJovPnphDNZNNfXtQR+B26RG6pDlvnApy5MHQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=pSdCBZtIKaaMS2rNP5z2RIRalA32Z5rikpMjmg2vCV9IzRzy3MhHmm7Xy+Tl6T6m6
	 ZeAsZfINEHDhRX/K5bY1Nelv+xIlP6jqDjukMQHvyiz9h596+XefgYs1y9NdVjUqwl
	 s/oBMvhjf9QL2mz6f/BjjHm7yv2oduxt04+3hM6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgKIQUH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 9 Nov 2020 11:20:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:48520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgKIQUH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 9 Nov 2020 11:20:07 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A53B1206CB;
        Mon,  9 Nov 2020 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604938806;
        bh=oqLUZkDJovPnphDNZNNfXtQR+B26RG6pDlvnApy5MHQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l3IWgbhDy1rVVerCwZSglLg4bgbYQHx6Y+06kRROZy1RDdKRBJBc6kV7DGkEMogP9
         Vc+YcT+TMAoNbHcpjY6+Cw56kQ2Wdxy9dvnBVBQZoxirIIcgntok2+dpUmNhpmbLux
         VLwYF784LhGFQoHxGF5twyWQ0kUZpwnzyl+DadoE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5012F352264D; Mon,  9 Nov 2020 08:20:06 -0800 (PST)
Date:   Mon, 9 Nov 2020 08:20:06 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/4] doc: Present the role of READ_ONCE()
Message-ID: <20201109162006.GJ3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201105230444.GA18574@paulmck-ThinkPad-P72>
 <20201105230510.18660-1-paulmck@kernel.org>
 <20201109122133.GL2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109122133.GL2594@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 09, 2020 at 01:21:33PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 05, 2020 at 03:05:07PM -0800, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > This commit adds an explanation of the special cases where READ_ONCE()
> > may be used in place of a member of the rcu_dereference() family.
> 
> I am confused, there is no actual difference between rcu_dereference()
> and READ_ONCE() today. So we _may_ use READ_ONCE() at all times.
> 
> Now granted, we probably don't want that, but that does leave me
> somewhat confused vs the wording here.

There is a difference from the viewpoint of both lockdep and sparse.

Or am I missing your point?

							Thanx, Paul
