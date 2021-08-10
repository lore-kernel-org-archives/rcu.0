Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDAAC4338F
	for <rcu@archiver.kernel.org>; Tue, 10 Aug 2021 12:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD31460EFF
	for <rcu@archiver.kernel.org>; Tue, 10 Aug 2021 12:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbhHJMmd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 Aug 2021 08:42:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43108 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbhHJMmd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 Aug 2021 08:42:33 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628599329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cbeuQ+pTY7f4sJoyAZniy7oFrq537KdWc4RkNmsQ86A=;
        b=Vwe3oMZgfMJF02R7vU2zsAQdTmDYBrLTan6yVsZK7rWoqsMaftGHHucHM7QEoTSDaFeG9d
        j8RXpuFdQ9037BFHzBatx94evGT6C0R/XDJxOitYcdNxVZejDndnkXa2cloxVRm8Nscw/g
        6COpJ1WKb2F8zHLw+a7hmPKuC4sC4Akz17Llu99G4Fk17DE1hfudsRi2y5vJFMwfFeJSXL
        B+Q0JP3iKH+r6iyQw8whHkPmHveA/3q01s+RLVQNIBpi7WVwDBqrXgh5UHl5erXQJAyk+u
        bkb+6WbKDD3/tMQPv0dT/Liq2jZRlbIvYLPWUCrb/p0E0L5bXbkAtORrpsIYtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628599329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cbeuQ+pTY7f4sJoyAZniy7oFrq537KdWc4RkNmsQ86A=;
        b=PHrU+3X3RJ6oDZV3ANd88lxskoQ2LOrAAPPTDj+dx/+ioBje3F84DnPRdxvgaoCWo6wc3I
        faryedL8hTipErCg==
To:     paulmck@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 31/38] rcu: Replace deprecated CPU-hotplug functions.
In-Reply-To: <20210803160021.GR4397@paulmck-ThinkPad-P17-Gen-1>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
 <20210803141621.780504-32-bigeasy@linutronix.de>
 <20210803160021.GR4397@paulmck-ThinkPad-P17-Gen-1>
Date:   Tue, 10 Aug 2021 14:42:09 +0200
Message-ID: <87fsvhsc7y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 03 2021 at 09:00, Paul E. McKenney wrote:
> On Tue, Aug 03, 2021 at 04:16:14PM +0200, Sebastian Andrzej Siewior wrote:
>> The functions get_online_cpus() and put_online_cpus() have been
>> deprecated during the CPU hotplug rework. They map directly to
>> cpus_read_lock() and cpus_read_unlock().
>> 
>> Replace deprecated CPU-hotplug functions with the official version.
>> The behavior remains unchanged.
>> 
> I have queued this one and 35/38 (rcutorture) for v5.16.  If you would
> prefer to send them some other route, please let me know and:

5.15 would be appreciated so we can get rid of the old interface around
rc1.

Thanks,

        tglx
