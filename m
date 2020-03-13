Return-Path: <SRS0=Iwfc=46=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53B7C4CECE
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 19:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91911206EB
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 19:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584129486;
	bh=p6hRYh/5g1+rnqKlC74CdLefoTR8g5NmUJKw9TYLsro=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=HeomF2fktaVfIapSDZ6P3Osags36KGsCSbLD1H2pjBZ+jqLWVPI66Ty3skzZHc/Xj
	 f6zYcSyrqrjSyLU9TeLWcVP+eToThxawyZYtyhVhnRSMNwxesarKrRsftFUAevVP88
	 cqCwYxlbAKMdIhqsri00PY1+qLjfQGihEk8goKxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCMT6G (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgCMT6G (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Mar 2020 15:58:06 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8DA5206E2;
        Fri, 13 Mar 2020 19:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584129485;
        bh=p6hRYh/5g1+rnqKlC74CdLefoTR8g5NmUJKw9TYLsro=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cuVu8P8y6xMIhoPl+xrUUy0O89eOY3vo3UEoMWyC+87CBGU+RfOgpBn61iR1fFYdL
         chSPKCTLXfqjiuwRoPcr2dNG6wct5oVD1PH0FyLbrKwbd9n5gw0nTz4PtcXf/lzYmB
         xxO2ptqD0AhFZF5lEoENknWqSSJV/6+4BzSP3fr0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 74678352272E; Fri, 13 Mar 2020 12:58:05 -0700 (PDT)
Date:   Fri, 13 Mar 2020 12:58:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     George Spelvin <lkml@SDF.ORG>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Subject: Re: Is there a reason we don't have kvfree_rcu()?
Message-ID: <20200313195805.GA3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200312162730.GB11889@SDF.ORG>
 <20200312181138.GI3199@paulmck-ThinkPad-P72>
 <20200312191009.GA27429@pc636>
 <20200313050659.GA22938@SDF.ORG>
 <20200313135400.GQ3199@paulmck-ThinkPad-P72>
 <20200313165219.GA1384@SDF.ORG>
 <20200313181917.GY3199@paulmck-ThinkPad-P72>
 <20200313184641.GA14782@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313184641.GA14782@SDF.ORG>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 13, 2020 at 06:46:41PM +0000, George Spelvin wrote:
> On Fri, Mar 13, 2020 at 11:19:17AM -0700, Paul E. McKenney wrote:
> > Another approach would be to terminate with a NULL pointer, or with the
> > end of the array, as the case may be.
> 
> That's the basic idea, but you want to be able to append a pointer
> in O(1) time, and a simple null-termination requires a linear search.

Fair point!

> It's obfuscation for negligible gain, however, so I'm sorry I
> bothered mentioning it.

I am with you on keeping it simple, especially initially, all evidence
to the contrary notwithstanding.

							Thanx, Paul
