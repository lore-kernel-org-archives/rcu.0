Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98670C56201
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 14:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355FB2224C
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 14:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWXHsH0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgKTOel (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 09:34:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgKTOel (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 09:34:41 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70B8322272;
        Fri, 20 Nov 2020 14:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605882880;
        bh=B1Br1hULK/WfkFwsjA8lmXos2eMfvYj83MqhQeXBjl4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pWXHsH0z0tux3KEnuNcTrE3ucHEpE+pUQMklPccP2WXiqkkOH0m2mUgQJgPZ8ExHy
         tJp9JqoBj1RnqPZ9o6q2SuJHhvMdB7WVfTUOthKoiRNGsq2YUml+EU87WJLPcrCoy+
         L+PBKCnrxbusCvFrlxTyXYcpyEAV5XcE6E2xob4s=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 11AC83522A6E; Fri, 20 Nov 2020 06:34:40 -0800 (PST)
Date:   Fri, 20 Nov 2020 06:34:40 -0800
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
Message-ID: <20201120143440.GF1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201118035309.19144-1-qiang.zhang@windriver.com>
 <20201119214934.GC1437@paulmck-ThinkPad-P72>
 <CACT4Y+bas5xfc-+W+wkpbx6Lw=9dsKv=ha83=hs1pytjfK+drg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bas5xfc-+W+wkpbx6Lw=9dsKv=ha83=hs1pytjfK+drg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 20, 2020 at 09:51:15AM +0100, Dmitry Vyukov wrote:
> On Thu, Nov 19, 2020 at 10:49 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Nov 18, 2020 at 11:53:09AM +0800, qiang.zhang@windriver.com wrote:
> > > From: Zqiang <qiang.zhang@windriver.com>
> > >
> > > Add kasan_record_aux_stack function for kvfree_call_rcu function to
> > > record call stacks.
> > >
> > > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> >
> > Thank you, but this does not apply on the "dev" branch of the -rcu tree.
> > See file:///home/git/kernel.org/rcutodo.html for more info.
> >
> > Adding others on CC who might have feedback on the general approach.
> >
> >                                                         Thanx, Paul
> >
> > > ---
> > >  kernel/rcu/tree.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index da3414522285..a252b2f0208d 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3506,7 +3506,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >               success = true;
> > >               goto unlock_return;
> > >       }
> > > -
> > > +     kasan_record_aux_stack(ptr);
> > >       success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
> > >       if (!success) {
> > >               run_page_cache_worker(krcp);
> 
> kvfree_call_rcu is intended to free objects, right? If so this is:

True, but mightn't there still be RCU readers referencing this object for
some time, as in up to the point that the RCU grace period ends?  If so,
won't adding this cause KASAN to incorrectly complain about those readers?

Or am I missing something here?

						Thanx, Paul

> Acked-by: Dmitry Vyukov <dvyukov@google.com>
