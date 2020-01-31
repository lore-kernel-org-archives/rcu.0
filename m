Return-Path: <SRS0=c3Ty=3U=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51046C3F68F
	for <rcu@archiver.kernel.org>; Fri, 31 Jan 2020 04:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278C32082E
	for <rcu@archiver.kernel.org>; Fri, 31 Jan 2020 04:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580445743;
	bh=vrX3/6pwu1fAAx+7ajC/iDE0rq9jlf4ifOVKqF5c5jw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=bPbW3PNQbB/+p3RZ2PVBGJuGdEPl95fp/BOElfGgFA7PrsER5RL8XCvrkS+cYCxuG
	 AJVkdzzg39Dk7ayoWEOABDV8NFoHsVogS7VkRc4Jb3QFc4fzVXzh8LTm3zK8aZUY0w
	 Mc+RnnXVcgofmKJEejvTlrk7a2lYYD32FI4tbaXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgAaEmW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Jan 2020 23:42:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgAaEmW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Jan 2020 23:42:22 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09E2620705;
        Fri, 31 Jan 2020 04:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580445742;
        bh=vrX3/6pwu1fAAx+7ajC/iDE0rq9jlf4ifOVKqF5c5jw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lwIbH048z9e6sY/ayc2ASfw0Wd7frbTi30V5UKrUdKj0zv+olj7kg7mgLrGgzZJT5
         tJlTjr5OWbHUh7gLSws93FvQjpEP7bVzZIj9MxJ9E9ZuulILEwk44YVye/dcK8CZ84
         4zopYZKcxjAmg3sQAjGpR4mgiJZHggT4MvGow9aA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AF9303521386; Thu, 30 Jan 2020 20:42:21 -0800 (PST)
Date:   Thu, 30 Jan 2020 20:42:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Jules Irenge <jbi.octave@gmail.com>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        jiangshanlai@gmail.com, mathieu.desnoyers@efficios.com,
        rostedt@goodmis.org, josh@joshtriplett.org, rcu@vger.kernel.org
Subject: Re: [PATCH 2/2] rcu/nocb: Add missing annotation for
 rcu_nocb_bypass_unlock()
Message-ID: <20200131044221.GN2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <0/2>
 <cover.1580337836.git.jbi.octave@gmail.com>
 <59087bdc398a69ac743ee3e5cfa0bd26495881e3.1580337836.git.jbi.octave@gmail.com>
 <20200131005952.GD83200@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131005952.GD83200@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 31, 2020 at 08:59:52AM +0800, Boqun Feng wrote:
> On Thu, Jan 30, 2020 at 12:30:09AM +0000, Jules Irenge wrote:
> > Sparse reports warning at rcu_nocb_bypass_unlock()
> > 
> > warning: context imbalance in rcu_nocb_bypass_unlock() - unexpected unlock
> > 
> > The root cause is a missing annotation of rcu_nocb_bypass_unlock()
> > which causes the warning.
> > 
> > Add the missing __releases(&rdp->nocb_bypass_lock) annotation.
> > 
> > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> 
> Acked-by: Boqun Feng <boqun.feng@gmail.com>

Applied, thank you both!

							Thanx, Paul

> > ---
> >  kernel/rcu/tree_plugin.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 9d21cb07d57c..8783d19a58b2 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -1553,6 +1553,7 @@ static bool rcu_nocb_bypass_trylock(struct rcu_data *rdp)
> >   * Release the specified rcu_data structure's ->nocb_bypass_lock.
> >   */
> >  static void rcu_nocb_bypass_unlock(struct rcu_data *rdp)
> > +	__releases(&rdp->nocb_bypass_lock)
> >  {
> >  	lockdep_assert_irqs_disabled();
> >  	raw_spin_unlock(&rdp->nocb_bypass_lock);
> > -- 
> > 2.24.1
> > 
