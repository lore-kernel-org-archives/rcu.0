Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F35C2D0E4
	for <rcu@archiver.kernel.org>; Sat, 21 Nov 2020 01:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6B624124
	for <rcu@archiver.kernel.org>; Sat, 21 Nov 2020 01:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rT5oEdJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgKUBMz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 20:12:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgKUBMz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 20:12:55 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D05D24101;
        Sat, 21 Nov 2020 01:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605921174;
        bh=KzFDwcBJhD0pOjqa0425Ms5+L0+225sTe32C3oVRTS0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rT5oEdJ4+RmqmzRUk43XHmmeDB/LURwejU25VZVf3igQtNwOMQbJxzIfH3Yref+rj
         pbG4JGfg9WytGoO1D9Nnb0PbMBFNR6u/iIdBc5s4jkW0hatNS/P6DwAvTNzS7h4NO+
         baPDzTILy0tLjbV+tW4R2pG8aUqkkBsDx3PNAsIg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 72EAA3522A6E; Fri, 20 Nov 2020 17:12:54 -0800 (PST)
Date:   Fri, 20 Nov 2020 17:12:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 0/5] Provide SRCU polling grace-period
 interfaces
Message-ID: <20201121011254.GS1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201117004017.GA7444@paulmck-ThinkPad-P72>
 <20201121005809.GA16795@paulmck-ThinkPad-P72>
 <20201120200553.625ee073@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120200553.625ee073@oasis.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 20, 2020 at 08:05:53PM -0500, Steven Rostedt wrote:
> On Fri, 20 Nov 2020 16:58:09 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > 	OK, maybe no one needs it, but rcutorture does need it, so here
> > 	it is anyway.
> 
> Ah, so there was a use case. I was scratching my head a bit before
> reading this ;-)

Indeed, the overhead of start_poll_synchronize_srcu() is a killer for
some parts of rcutorture, plus those parts don't care if no grace period
gets started...

							Thanx, Paul
