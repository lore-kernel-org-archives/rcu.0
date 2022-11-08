Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC4BC4332F
	for <rcu@archiver.kernel.org>; Tue,  8 Nov 2022 19:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiKHT1b (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Nov 2022 14:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiKHT1a (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Nov 2022 14:27:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D4F2228E;
        Tue,  8 Nov 2022 11:27:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A3711CE1CA3;
        Tue,  8 Nov 2022 19:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38D7C433D6;
        Tue,  8 Nov 2022 19:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667935645;
        bh=rq7F0InOrMlwRw7encxZx6osS6nmIJqGkHa4eG3AHBs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Z70DYLiV/aCtv/CcfdJmewvu0TANLJLK+uksgfMpk0zXwUZsxRTN7BUr/g96lbZUN
         5prjjCiRPv/q0twL04hzyOx+9c2IA6lGYzeHgMB7hqYLAmQfeI2LtqDhV2DjjNIw5T
         kIZMVenm4AsmmFfdT5853m/vqRPpc/geTUtNWEhS4vTrmtAy+9RAZkMY7MiZItj+sO
         7xkjP+3IzAFp22Q759nzXo83Pjaki9wvga8cDm1YO0Rgb+WdSMMxx8arp6VkAANN9L
         adOXni8EJE2UuuYe5Dh0iP4Ylv+AmWSaGhlK4buTdwddRu1NgDYyc+3vuAPJCMpgIm
         8TNqH7HrJvZ0w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3A6D65C1E87; Tue,  8 Nov 2022 11:27:24 -0800 (PST)
Date:   Tue, 8 Nov 2022 11:27:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v3 01/40] rcu: implement lockdep_rcu_enabled for
 !CONFIG_DEBUG_LOCK_ALLOC
Message-ID: <20221108192724.GI3907045@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-2-john.ogness@linutronix.de>
 <20221107180157.GL28461@paulmck-ThinkPad-P17-Gen-1>
 <87h6za602y.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6za602y.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 07, 2022 at 08:29:01PM +0106, John Ogness wrote:
> On 2022-11-07, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >> Provide an implementation for debug_lockdep_rcu_enabled() when
> >> CONFIG_DEBUG_LOCK_ALLOC is not enabled. This allows code to check
> >> if rcu lockdep debugging is available without needing an extra
> >> check if CONFIG_DEBUG_LOCK_ALLOC is enabled.
> >> 
> >> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> >
> > If you would like me to take this one, please let me know.
> 
> Yes, it would be great if you would carry this in the rcu tree. This
> printk series is already relying on the rcu tree for the NMI-safe
> work. Thanks!

Very good, I have queued it.  It is currently on -rcu branch "dev",
but will find its way to srcunmisafe.2022.10.21a in the next day or two.

							Thanx, Paul
