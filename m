Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D262C433E1
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 18:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4768220791
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 18:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597342783;
	bh=cfInR/OZAxeRgA8RzoeKAMdghNKfDdv6HwmgA9ad9+k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ALfhC3VozM0efMc6kpz2XbKUnUZWl2gZGjEJqy+zY0+kJ/T9vvoCgf/W7ZiZVLeTU
	 ur6RbEX/2XZxH/mK+qdb/3nCmCzrpHwYcuGSklkDJgIfZnw4eYEBN7jcEZHZkzzv2I
	 EwsU6J9SKj6R56H+TwaXbC5UEoM9XKgHcVq82tLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgHMSTn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgHMSTm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 14:19:42 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CEAF20791;
        Thu, 13 Aug 2020 18:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597342782;
        bh=cfInR/OZAxeRgA8RzoeKAMdghNKfDdv6HwmgA9ad9+k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cOGBbPUcESc3UDV3corQXFmjW5/b/ogDrYRtB27/uEabXMGjPYmxMm7bZqQhQ8K6a
         7gS+N2v+0sqwu4A2IhlRDHS0GbdnRr5p2YiZONQ5mehuQ39yyOGWcnmVJqc1DEwtyZ
         hPXe8zjhjJYX1koB3hZq4kYKZXwWLa5xO/hp3RLI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E2CF5352279C; Thu, 13 Aug 2020 11:19:41 -0700 (PDT)
Date:   Thu, 13 Aug 2020 11:19:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chao Zhou <chaozhou1018@gmail.com>
Cc:     rcu@vger.kernel.org
Subject: Re: Allow multiple GP misses before Panic
Message-ID: <20200813181941.GD4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAJdzfEd6nf9xBw7w26EdsM5ukpDEhKNc0L6PW7SKKJDCgtt+Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJdzfEd6nf9xBw7w26EdsM5ukpDEhKNc0L6PW7SKKJDCgtt+Sg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 13, 2020 at 10:22:09AM -0700, Chao Zhou wrote:
> Hi,
> 
> Some RCU stalls are transient and a system is fully capable to recover
> after that, but we do want Panic after certain amount of GP misses.
> 
> Current module parameter rcu_cpu_stall_panic only turn on/off Panic,
> and 1 GP miss will trigger Panic when it is enabled.
> 
> Plan to add a module parameter for users to fine-tune how many GP
> misses are allowed before Panic.
> 
> To save our precious time, a diff has been tested on our systems and
> it works and solves our problem in transient RCU stall events.
> 
> Your insights and guidance is highly appreciated.

Please feel free to post a patch.  I could imagine a number of things
you might be doing from your description above:

1.	Having a different time for panic, so that (for example) an
	RCU CPU stall warning appears at 21 seconds (in mainline), and
	if the grace period still has not ended at some time specified
	by some kernel parameter.  For example, one approach would be
	to make the existing panic_on_rcu_stall sysctl take an integer
	instead of a boolean, and to make that integer specify how old
	the stall-warned grace period must be before panic() is invoked.

2.	Instead use the number of RCU CPU stall warning messages to
	trigger the panic, so that (for example), the panic would happen
	on the tenth message.  Again, the panic_on_rcu_stall sysctl
	might be used for this.

3.	Like #2, but reset the count every time a new grace period
	starts.  So if the panic_on_rcu_stall sysctl was set to
	ten, there would need to be ten RCU CPU stall warnings for
	the same grace period before panic() was invoked.

Of the above three, #1 and #3 seem the most attractive, with a slight
preference for #1.

Or did you have something else in mind?

							Thanx, Paul
