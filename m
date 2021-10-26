Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1AEC433F5
	for <rcu@archiver.kernel.org>; Tue, 26 Oct 2021 14:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5004361039
	for <rcu@archiver.kernel.org>; Tue, 26 Oct 2021 14:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhJZOI6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 26 Oct 2021 10:08:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231493AbhJZOI4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 26 Oct 2021 10:08:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDA956103C;
        Tue, 26 Oct 2021 14:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635257193;
        bh=ZzD40Angatb9WKJIB9PLKZoFb4YiYIHNUINS1DX4/Ng=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=r00TIpUZmQmYGSxW5DdMBMLTk8k4m5P/+u8CgiXSXdP2EephzSeNVSHAQw9qm/ZNE
         RLDaY3lTwxTB5SgA0p+H8IFiBt4OVoECpm2Sx5dPmIhZJipphw/Bpw66X4u/zMbKn3
         0jIj5OrlrN0v5ZAk6YlPs4qVfjaaTFWov3MPyEg6GTjyFAAgbjMJ+KqWZTsE8tPAvW
         5Ey08E/9vhkoXwvW1jE1YcvB+zO236izT26Fotl+s35wlohu2It22j7a+NSr9PtGDm
         3W8fvxXetD6P6sU5V4tMh1xURFfBmJ+Lb2NsJai7X7bX0ho0BcdAARSAq8DNIFoG9q
         aox1+4S2mM+CQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2A6965C0D48; Tue, 26 Oct 2021 07:06:32 -0700 (PDT)
Date:   Tue, 26 Oct 2021 07:06:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     "dave@stgolabs.net" <dave@stgolabs.net>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] refscale: always log the error message
Message-ID: <20211026140632.GV880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211025032658.22889-1-lizhijian@cn.fujitsu.com>
 <20211025032658.22889-3-lizhijian@cn.fujitsu.com>
 <5f4c53e4-34aa-98f6-343f-0de18df830f2@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f4c53e4-34aa-98f6-343f-0de18df830f2@fujitsu.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 25, 2021 at 06:12:40AM +0000, lizhijian@fujitsu.com wrote:
> 
> 
> On 25/10/2021 11:26, Li Zhijian wrote:
> > Generally, error message should be logged anyhow.
> >
> > Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> > ---
> >   kernel/rcu/refscale.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> > index a4479f00dcdc..f055d168365a 100644
> > --- a/kernel/rcu/refscale.c
> > +++ b/kernel/rcu/refscale.c
> > @@ -58,8 +58,8 @@ do {											\
> >   	}										\
> >   } while (0)
> >   
> > -#define VERBOSE_SCALEOUT_ERRSTRING(s, x...) \
> > -	do { if (verbose) pr_alert("%s" SCALE_FLAG "!!! " s, scale_type, ## x); } while (0)
> > +#define SCALEOUT_ERRSTRING(s, x...) \
> > +	do { pr_alert("%s" SCALE_FLAG "!!! " s, scale_type, ## x); } while (0)
> >   
> >   MODULE_LICENSE("GPL");
> >   MODULE_AUTHOR("Joel Fernandes (Google) <joel@joelfernandes.org>");
> > @@ -651,7 +651,7 @@ static int main_func(void *arg)
> >   	result_avg = kzalloc(nruns * sizeof(*result_avg), GFP_KERNEL);
> >   	buf = kzalloc(800 + 64, GFP_KERNEL);
> >   	if (!result_avg || !buf) {
> > -		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
> > +		SCALEOUT_ERRSTRING("out of memory");
> 
> '\n' should be added to the last to flush it.

And there might well be other missing "\n" instances in similar messages
in rcuscale.c, rcutorture.c, scftorture.c, locktorture.c, and torture.c.
Please feel free to send a patch for each file needing this help.

I queued your other three patches for v5.17 (not this coming merge window,
but the one after that), thank you!  I did wordsmith the commit logs,
so please check to see if I messed anything up.

							Thanx, Paul

> >   		goto oom_exit;
> >   	}
> >   	if (holdoff)
> > @@ -837,7 +837,7 @@ ref_scale_init(void)
> >   	reader_tasks = kcalloc(nreaders, sizeof(reader_tasks[0]),
> >   			       GFP_KERNEL);
> >   	if (!reader_tasks) {
> > -		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
> > +		SCALEOUT_ERRSTRING("out of memory");
> ditto
> 
> Thanks
> Zhijian
> >   		firsterr = -ENOMEM;
> >   		goto unwind;
> >   	}
