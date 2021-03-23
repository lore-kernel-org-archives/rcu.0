Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF98C433DB
	for <rcu@archiver.kernel.org>; Tue, 23 Mar 2021 16:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF1C619C0
	for <rcu@archiver.kernel.org>; Tue, 23 Mar 2021 16:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhCWQqG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233317AbhCWQpt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 23 Mar 2021 12:45:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3A8E61992;
        Tue, 23 Mar 2021 16:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616517948;
        bh=PsikL/oh28lMsUHE2XYeQLegL588LmV4SQccoHleLD0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UegLFAeh26fLIPQxGxkz5c1ZjqQaYXNCIB6G2GN77qSsb4o9GeiP8Qi2kD9v4tAQm
         DlnTqXF3e9IYJ0B+9tabF1aAiHibzKxiEuryZ+ik7XBe9SuGnPqwT6G/pREQrKxTFo
         MOhkOxQalBybbXecCXmjiFIu8sj9dAMF2D4w+aYGLX3ATUxvFs/BIeHsPkG4PxQb2E
         I14fFD4b56Fu7bNd/+aEVn2j3BXe8cvdohs/Am38I4jeyxUmL5Wh0i5McNttNszGQt
         DfU9cHAfyfdeMpdeIWtJSYMygUzfNY2CMbrSDz8XoJ+bZzOsJjRB6hBqzfalxBadbj
         3dvIxwpxdMLDQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 922F9352261C; Tue, 23 Mar 2021 09:45:48 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:45:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 2/3] rcu: Provide polling interfaces for
 Tiny RCU grace periods
Message-ID: <20210323164548.GZ2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
 <20210304002632.23870-2-paulmck@kernel.org>
 <20210321222855.GA863290@lothringen>
 <20210322154744.GM2696@paulmck-ThinkPad-P72>
 <20210322190035.GA874833@lothringen>
 <20210322194522.GO2696@paulmck-ThinkPad-P72>
 <20210323140207.GA890343@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323140207.GA890343@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Mar 23, 2021 at 03:02:07PM +0100, Frederic Weisbecker wrote:
> On Mon, Mar 22, 2021 at 12:45:22PM -0700, Paul E. McKenney wrote:
> > On Mon, Mar 22, 2021 at 08:00:35PM +0100, Frederic Weisbecker wrote:
> > > But poll_state_synchronize_rcu() checks that the gp_num has changed,
> > > which is not needed for cond_synchronize_rcu() since this it is
> > > only allowed to be called from a QS.
> > 
> > Good catch, and thank you!  Back to a single might_sleep() it is!
> 
> And then: Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thank you!  I will apply this on my next rebase.

							Thanx, Paul
