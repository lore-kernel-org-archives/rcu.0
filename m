Return-Path: <SRS0=YgaY=B7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131C3C433DF
	for <rcu@archiver.kernel.org>; Fri, 21 Aug 2020 14:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D222063A
	for <rcu@archiver.kernel.org>; Fri, 21 Aug 2020 14:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598019654;
	bh=ZXmVyx5QFVKAvqTqimNvpT9Bc6KMuQhIlD8OWpmp78E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Di8FiTJgUgvn0MkhmAGXntgI1F67Ug8H+/6DEoezpF6/Yr05bAIFGm3uL4boagQTW
	 p6SAdPNtqS7C1pGxJr/I4BHtKyX/bI0up5v64C8ojw6c6haP/36Y0yXSdKiUNGyXfB
	 pa8bOgY1QwqajONFdI6hUhCOCC1cJwMT9qXWt4zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgHUOUv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgHUOUv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 21 Aug 2020 10:20:51 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24746204FD;
        Fri, 21 Aug 2020 14:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598019651;
        bh=ZXmVyx5QFVKAvqTqimNvpT9Bc6KMuQhIlD8OWpmp78E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uN0aoTmjSzo5LfQe5MgNHU/o7/Pwjf6OG+mPuaDoQ8CCSRvrLMkztKHrEnmz80xhP
         kjqzTwo7h0DX46Itv6/MP/P7m4op1HNKDKHrqgYfcfzsWmdsZIxD2z9IDAmSZVdEJZ
         JHRSF+ErvDmMbN59vSlKMoy59uBNQVVmDtZnDtnU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 020C235227D4; Fri, 21 Aug 2020 07:20:50 -0700 (PDT)
Date:   Fri, 21 Aug 2020 07:20:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: RCU: Remove stray ()
Message-ID: <20200821142050.GE2855@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200821010900.6362-1-chris.packham@alliedtelesis.co.nz>
 <20200821010900.6362-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821010900.6362-3-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 21, 2020 at 01:09:00PM +1200, Chris Packham wrote:
> A reference to srcu_read_lock_held() had an extra (). Remove it,
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Good eyes, but someone beat you to this one.

							Thanx, Paul

> ---
>  Documentation/RCU/lockdep.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/lockdep.rst b/Documentation/RCU/lockdep.rst
> index f1fc8ae3846a..cc860a0c296b 100644
> --- a/Documentation/RCU/lockdep.rst
> +++ b/Documentation/RCU/lockdep.rst
> @@ -49,7 +49,7 @@ checking of rcu_dereference() primitives:
>  		is invoked by both RCU-sched readers and updaters.
>  	srcu_dereference_check(p, c):
>  		Use explicit check expression "c" along with
> -		srcu_read_lock_held()().  This is useful in code that
> +		srcu_read_lock_held().  This is useful in code that
>  		is invoked by both SRCU readers and updaters.
>  	rcu_dereference_raw(p):
>  		Don't check.  (Use sparingly, if at all.)
> -- 
> 2.28.0
> 
