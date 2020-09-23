Return-Path: <SRS0=jKPx=DA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D316C4363D
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 03:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 020052193E
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 03:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600833099;
	bh=IRvofdC9p6whOD7WsodxEGJiMATxLVmtshgV275e4jQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=TqedwAJXd/6+Lr1/wJfQnRYQczlCvTZ8z0tFDpjpoocoD3glN/7NQAlPBEAImNIOo
	 c3I9Cdy8HjRGcAPqvnXGTXtBwfCXqoS1oA5OtuiVPw62ghfNwZ4sUyXQl5mX1Lwinw
	 nIJpTnwCRZnG68RmeEbVEwlmIYAwpP1M/gI89a+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgIWDvi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Sep 2020 23:51:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIWDvi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Sep 2020 23:51:38 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 280FB2076E;
        Wed, 23 Sep 2020 03:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600833098;
        bh=IRvofdC9p6whOD7WsodxEGJiMATxLVmtshgV275e4jQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vsogR3ZO3YdR45MojtUn/yl2z1OajglLzDtS59i67WXtAm7r/tuH0OTivNzJzlvau
         3tQpIbd9PAjFEZKL24QfpbEJpRq5lnC3G9snj80ai/7JIj1PUDVe91nQcd+HXkr8WM
         zpk8dNHt8t94i+WvLW5pqJ9TZGRcmUmQdgZ2k9mA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E22F535231BA; Tue, 22 Sep 2020 20:51:37 -0700 (PDT)
Date:   Tue, 22 Sep 2020 20:51:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH 2/2] locktorture: call percpu_free_rwsem() to do
 percpu-rwsem cleanup
Message-ID: <20200923035137.GN29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200917135910.137389-1-houtao1@huawei.com>
 <20200917135910.137389-3-houtao1@huawei.com>
 <20200922232426.GL29330@paulmck-ThinkPad-P72>
 <fe8c274e-efa4-04ec-0d95-d7c49ec4dd83@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe8c274e-efa4-04ec-0d95-d7c49ec4dd83@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 23, 2020 at 10:24:20AM +0800, Hou Tao wrote:
> Hi Paul,
> 
> > On 2020/9/23 7:24, Paul E. McKenney wrote:
> snip
> 
> >> Fix it by adding an exit hook in lock_torture_ops and
> >> use it to call percpu_free_rwsem() for percpu rwsem torture
> >> before the module is removed, so we can ensure rcu_sync_func()
> >> completes before module exits.
> >>
> >> Also needs to call exit hook if lock_torture_init() fails half-way,
> >> so use ctx->cur_ops != NULL to signal that init hook has been called.
> > 
> > Good catch, but please see below for comments and questions.
> > 
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>  kernel/locking/locktorture.c | 28 ++++++++++++++++++++++------
> >>  1 file changed, 22 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> >> index bebdf98e6cd78..e91033e9b6f95 100644
> >> --- a/kernel/locking/locktorture.c
> >> +++ b/kernel/locking/locktorture.c
> >> @@ -74,6 +74,7 @@ static void lock_torture_cleanup(void);
> >>   */
> >>  struct lock_torture_ops {
> >>  	void (*init)(void);
> >> +	void (*exit)(void);
> > 
> > This is fine, but why not also add a flag to the lock_torture_cxt
> > structure that is set when the ->init() function is called?  Perhaps
> > something like this in lock_torture_init():
> > 
> > 	if (cxt.cur_ops->init) {
> > 		cxt.cur_ops->init();
> > 		cxt.initcalled = true;
> > 	}
> > 
> 
> You are right. Add a new field to indicate the init hook has been
> called is much better than reusing ctx->cur_ops != NULL to do that.
> 
> >>  	int (*writelock)(void);
> >>  	void (*write_delay)(struct torture_random_state *trsp);
> >>  	void (*task_boost)(struct torture_random_state *trsp);
> >> @@ -571,6 +572,11 @@ void torture_percpu_rwsem_init(void)
> >>  	BUG_ON(percpu_init_rwsem(&pcpu_rwsem));
> >>  }
> >>  
> >> +static void torture_percpu_rwsem_exit(void)
> >> +{
> >> +	percpu_free_rwsem(&pcpu_rwsem);
> >> +}
> >> +
> snip
> 
> >> @@ -828,6 +836,12 @@ static void lock_torture_cleanup(void)
> >>  	cxt.lrsa = NULL;
> >>  
> >>  end:
> >> +	/* If init() has been called, then do exit() accordingly */
> >> +	if (cxt.cur_ops) {
> >> +		if (cxt.cur_ops->exit)
> >> +			cxt.cur_ops->exit();
> >> +		cxt.cur_ops = NULL;
> >> +	}
> > 
> > The above can then be:
> > 
> > 	if (cxt.initcalled && cxt.cur_ops->exit)
> > 		cxt.cur_ops->exit();
> > 
> > Maybe you also need to clear cxt.initcalled at this point, but I don't
> > immediately see why that would be needed.
> > 
> Because we are doing cleanup, so I think reset initcalled to false is OK
> after the cleanup is done.

Maybe best to try it both ways and see how each really works?

We might each have our opinions, but the computer's opinion is the one
that really counts.  ;-)

> >>  	torture_cleanup_end();
> >>  }
> >>  
> >> @@ -835,6 +849,7 @@ static int __init lock_torture_init(void)
> >>  {
> >>  	int i, j;
> >>  	int firsterr = 0;
> >> +	struct lock_torture_ops *cur_ops;
> > 
> > And then you don't need this extra pointer.  Not that this pointer is bad
> > in and of itself, but using (!cxt.cur_ops) to indicate that the ->init()
> > function has not been called is an accident waiting to happen.
> > 
> > And the changes below are no longer needed.
> > 
> > Or am I missing something subtle?
> > 
> Thanks for your suggestion. Will send v2.

Looking forward to seeing it!

							Thanx, Paul
