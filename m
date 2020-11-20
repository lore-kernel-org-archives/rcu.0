Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41CBC5519F
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 14:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D39D2236F
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 14:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mv+xTalB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgKTOyp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 09:54:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgKTOyp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 09:54:45 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B923A22272;
        Fri, 20 Nov 2020 14:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605884084;
        bh=7C1fRZemS8FZMGXIoHL9vdeV20V7I1dBALzbsQrQD/8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Mv+xTalB902H1VwsRGpKFs+b938Nfv1OpoF4yJ1llxa4lXbBBsUWgfNDOpSruefd3
         3byytN0xSTSwyG+gZ+RYCr670N+t6npP7R+e9QprBUZkHwlD9IGfSk7IKr7c62bUlT
         AF45OUkd6kECLgnz/6tX2eBNWNku1zJOxIYSwutg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5B8EC3522A6E; Fri, 20 Nov 2020 06:54:44 -0800 (PST)
Date:   Fri, 20 Nov 2020 06:54:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Zhang, Qiang" <qiang.zhang@windriver.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] rcu: kasan: record and print kvfree_call_rcu call stack
Message-ID: <20201120145444.GI1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201118035309.19144-1-qiang.zhang@windriver.com>
 <20201119214934.GC1437@paulmck-ThinkPad-P72>
 <CACT4Y+bas5xfc-+W+wkpbx6Lw=9dsKv=ha83=hs1pytjfK+drg@mail.gmail.com>
 <20201120143440.GF1437@paulmck-ThinkPad-P72>
 <CACT4Y+ZNBRaVOK4zjv7WyyJKeS54OL8212EtjQHshYDeOVmCGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZNBRaVOK4zjv7WyyJKeS54OL8212EtjQHshYDeOVmCGQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 20, 2020 at 03:44:04PM +0100, Dmitry Vyukov wrote:
> On Fri, Nov 20, 2020 at 3:34 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Nov 20, 2020 at 09:51:15AM +0100, Dmitry Vyukov wrote:
> > > On Thu, Nov 19, 2020 at 10:49 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Wed, Nov 18, 2020 at 11:53:09AM +0800, qiang.zhang@windriver.com wrote:
> > > > > From: Zqiang <qiang.zhang@windriver.com>
> > > > >
> > > > > Add kasan_record_aux_stack function for kvfree_call_rcu function to
> > > > > record call stacks.
> > > > >
> > > > > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> > > >
> > > > Thank you, but this does not apply on the "dev" branch of the -rcu tree.
> > > > See file:///home/git/kernel.org/rcutodo.html for more info.
> > > >
> > > > Adding others on CC who might have feedback on the general approach.
> > > >
> > > >                                                         Thanx, Paul
> > > >
> > > > > ---
> > > > >  kernel/rcu/tree.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index da3414522285..a252b2f0208d 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -3506,7 +3506,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > > >               success = true;
> > > > >               goto unlock_return;
> > > > >       }
> > > > > -
> > > > > +     kasan_record_aux_stack(ptr);
> > > > >       success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
> > > > >       if (!success) {
> > > > >               run_page_cache_worker(krcp);
> > >
> > > kvfree_call_rcu is intended to free objects, right? If so this is:
> >
> > True, but mightn't there still be RCU readers referencing this object for
> > some time, as in up to the point that the RCU grace period ends?  If so,
> > won't adding this cause KASAN to incorrectly complain about those readers?
> >
> > Or am I missing something here?
> 
> kvfree_call_rcu does not check anything, not poison the object for
> future accesses (it is also called in call_rcu which does not
> necessarily free the object).
> It just notes the current stack to provide in reports later.
> The problem is that the free stack is pointless for objects freed by
> rcu. In such cases we want call_rcu/kvfree_call_rcu stack in
> use-after-free reports.

OK, sounds good, thank you!

I will take this patch with your ack and Uladzislau's reviewed-by.
I had to forward-port this to -rcu brach "dev", and along the way I
updated the commit log to make Dmitry's point above, so please let me
know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 3ce23b2df528877623ffc9c9cc2b6885eb3ae9db
Author: Zqiang <qiang.zhang@windriver.com>
Date:   Fri Nov 20 06:53:11 2020 -0800

    rcu: Record kvfree_call_rcu() call stack for KASAN
    
    This commit adds a call to kasan_record_aux_stack() in kvfree_call_rcu()
    in order to record the call stack of the code that caused the object
    to be freed.  Please note that this function does not update the
    allocated/freed state, which is important because RCU readers might
    still be referencing this object.
    
    Acked-by: Dmitry Vyukov <dvyukov@google.com>
    Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Signed-off-by: Zqiang <qiang.zhang@windriver.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1d956f9..4aa7745 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3514,6 +3514,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		return;
 	}
 
+	kasan_record_aux_stack(ptr);
 	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
 	if (!success) {
 		run_page_cache_worker(krcp);
