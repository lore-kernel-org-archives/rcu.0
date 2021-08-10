Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B01C4338F
	for <rcu@archiver.kernel.org>; Tue, 10 Aug 2021 18:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ABC460527
	for <rcu@archiver.kernel.org>; Tue, 10 Aug 2021 18:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbhHJSUv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232466AbhHJSUj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 Aug 2021 14:20:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1FA760724;
        Tue, 10 Aug 2021 18:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628619616;
        bh=VNhoF4DKiz90uuvdpHoB+AGd6rm+6fOeCpgR3CD4raw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=p6wm1jwaxLHiOXhkwwzrtYSHMMLlIIYdYL+4bwl/Q7cXF+g6jrM0W+EjTvAFfqIoh
         PDyT7F8rXu8vPb61jHGjtiFIODAfiUBQ2hM9kt8+SRNBaa5u+NmXbv6yd9bRGzKvhq
         T+sK1t7CYB6kFuodhAF2AJ41hn3O3C9bJ9QFmppbgir2R7yNnXm67EcxSqdQDaCkGL
         1vCHY5gAkg7sbdCosbWRTtpXvTRbl68gTJEdWUADmi2ht8MA1KawOYoXhYU0p8Hr9W
         p0TUgDmysIDsUBp7FY2kp+cWlBDuidZyVLo1lLgTDUeCDMocfzheLvUHCvb1b8APEK
         v7XnpIjxdGQkg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9F46A5C039B; Tue, 10 Aug 2021 11:20:16 -0700 (PDT)
Date:   Tue, 10 Aug 2021 11:20:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 31/38] rcu: Replace deprecated CPU-hotplug functions.
Message-ID: <20210810182016.GI4126399@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210803141621.780504-1-bigeasy@linutronix.de>
 <20210803141621.780504-32-bigeasy@linutronix.de>
 <20210803160021.GR4397@paulmck-ThinkPad-P17-Gen-1>
 <87fsvhsc7y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsvhsc7y.ffs@tglx>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 10, 2021 at 02:42:09PM +0200, Thomas Gleixner wrote:
> On Tue, Aug 03 2021 at 09:00, Paul E. McKenney wrote:
> > On Tue, Aug 03, 2021 at 04:16:14PM +0200, Sebastian Andrzej Siewior wrote:
> >> The functions get_online_cpus() and put_online_cpus() have been
> >> deprecated during the CPU hotplug rework. They map directly to
> >> cpus_read_lock() and cpus_read_unlock().
> >> 
> >> Replace deprecated CPU-hotplug functions with the official version.
> >> The behavior remains unchanged.
> >> 
> > I have queued this one and 35/38 (rcutorture) for v5.16.  If you would
> > prefer to send them some other route, please let me know and:
> 
> 5.15 would be appreciated so we can get rid of the old interface around
> rc1.

Fair enough!  I have rebased to pull those two patches into my v5.15 pile.

							Thanx, Paul
