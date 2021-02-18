Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046EDC4332B
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 18:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA94764EB7
	for <rcu@archiver.kernel.org>; Thu, 18 Feb 2021 18:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhBRSvo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Feb 2021 13:51:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231248AbhBRSY7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Feb 2021 13:24:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49C0164DEC;
        Thu, 18 Feb 2021 18:24:18 +0000 (UTC)
Date:   Thu, 18 Feb 2021 13:24:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sangmoon Kim <sangmoon.kim@samsung.com>,
        neeraju <neeraju@codeaurora.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH] rcu/tree: Add a trace event for RCU stall warnings
Message-ID: <20210218132416.63602faf@gandalf.local.home>
In-Reply-To: <20210218170012.GS2743@paulmck-ThinkPad-P72>
References: <bf80e296-14bf-6f36-8952-416829d30e5a@codeaurora.org>
        <CGME20210218130056epcas1p21e5b2e873f8c3cb0aa6953473d4c416c@epcas1p2.samsung.com>
        <20210218125224.23739-1-sangmoon.kim@samsung.com>
        <1181485573.26616.1613657821155.JavaMail.zimbra@efficios.com>
        <20210218150628.GN2743@paulmck-ThinkPad-P72>
        <1315011925.26877.1613663453242.JavaMail.zimbra@efficios.com>
        <20210218170012.GS2743@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, 18 Feb 2021 09:00:12 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> OK, I will bite.  ;-)

Do I turn into a wearwolf?

> 
> Can the saving of console into trace buffers be easily enabled and
> disabled within the code?

Well, we do have this for ftrace:

 echo 'enable_event:printk:console' > events/rcu/rcu_stall_warning/trigger

Would enable the printk console to be traced to the ring buffer once the
stall is triggered, and not before hand.

>  If so, does enabling and disabling nest?

It has a disable as well, but unfortunately its global and does not nest.
We could always implement a percpu trigger that can nest though.

-- Steve
