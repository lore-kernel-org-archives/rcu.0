Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B548C433DB
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 19:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BAEE64E2F
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 19:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhBRTik (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:38:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232185AbhBRTAH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Feb 2021 14:00:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4F7664EB4;
        Thu, 18 Feb 2021 18:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613674766;
        bh=omVaSGC/LJ1LP6KWA8BsYis+oFlRLuIF571sT5X5lzM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UyACli31Zq+ZTnhFjxQe+BBsTr9Laznb5BTMjq6Iy9cgaNDZVSrxsa2v9rey0TKWb
         VDUAI0NRxGlI2nATb/YyK8wWBFQZvcEIHl2jaqJaIVk7r1gKFOF3YTPSQ/hFyc6pKx
         Br68tNHxFjdWn7U3oUGTasyxslcpGtxet1B8xUQe4AgkIkj2AYH8YGHJAjUAoeSTjp
         ppc02K/dTFFJe1AEFr2gNpNOoXdXJrM8TzX42hF1rG5jeQSTJO23+NlhKCWWSgSV/F
         Wsk4AyVVfdZTqkfZvx1JHOgayUzXv0aJoe2EzykWCYYKebhMZCiLVrd4aw2EPErr5o
         XUsUlHK+zYdBw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6D79935226A0; Thu, 18 Feb 2021 10:59:26 -0800 (PST)
Date:   Thu, 18 Feb 2021 10:59:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sangmoon Kim <sangmoon.kim@samsung.com>,
        neeraju <neeraju@codeaurora.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH] rcu/tree: Add a trace event for RCU stall warnings
Message-ID: <20210218185926.GV2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <bf80e296-14bf-6f36-8952-416829d30e5a@codeaurora.org>
 <CGME20210218130056epcas1p21e5b2e873f8c3cb0aa6953473d4c416c@epcas1p2.samsung.com>
 <20210218125224.23739-1-sangmoon.kim@samsung.com>
 <1181485573.26616.1613657821155.JavaMail.zimbra@efficios.com>
 <20210218150628.GN2743@paulmck-ThinkPad-P72>
 <1315011925.26877.1613663453242.JavaMail.zimbra@efficios.com>
 <20210218170012.GS2743@paulmck-ThinkPad-P72>
 <20210218132416.63602faf@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218132416.63602faf@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Feb 18, 2021 at 01:24:16PM -0500, Steven Rostedt wrote:
> On Thu, 18 Feb 2021 09:00:12 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > OK, I will bite.  ;-)
> 
> Do I turn into a wearwolf?

Maybe even a wash-n-wear wolf.  ;-)

> > Can the saving of console into trace buffers be easily enabled and
> > disabled within the code?
> 
> Well, we do have this for ftrace:
> 
>  echo 'enable_event:printk:console' > events/rcu/rcu_stall_warning/trigger
> 
> Would enable the printk console to be traced to the ring buffer once the
> stall is triggered, and not before hand.
> 
> >  If so, does enabling and disabling nest?
> 
> It has a disable as well, but unfortunately its global and does not nest.
> We could always implement a percpu trigger that can nest though.

So Sangmoon could have a module react to an RCU CPU stall warning
tracepoint by turning on tracing of console messages.  If there was a
start-stop pair of RCU CPU stall warning tracepoints, he could turn it
off as well.

Not sure if that is what Sangmoon is looking for, but it is a possibility.

							Thanx, Paul
