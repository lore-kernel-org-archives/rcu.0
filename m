Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF05DC433EF
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 21:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC598601FA
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 21:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239902AbhIPVGi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Sep 2021 17:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232910AbhIPVGh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Sep 2021 17:06:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 337B5601FA;
        Thu, 16 Sep 2021 21:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631826316;
        bh=AkobYtN5HIa1iJgs8s8u+AClEI8eA7MfgsSb9e1n0GE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iRSAWRr5ktz/JjoOw0rhwb5BapT7Zt3xSn/ZrVYDKHRTLGZhaR64aivdcs/ud1Rju
         nv0LnAcKDdY3UMbScSbm6NAR6ORNQNeqBP682bWcMGPmtJtOBIl9KVb+L6XIT5MTj0
         R56blhbj5ixFmFMHokwrE4BOp15k1buB/lE6zN4tEe0m3QT7pTYm/otagAW6leh7/q
         gnQVvhPKefHRqAF7gNGzCcO/cE/39ydM9vFB+I97qC/doxmhO84V66gXXrfNfB4FVC
         xR+ii5gkbKej6MzFTtm1JkfK6+rWSDriBRj6WGq0XAjcnh5MpPrOfsGr5p8SVuj5aS
         rdvOJbovur3cQ==
Date:   Thu, 16 Sep 2021 23:05:14 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        urezki@gmail.com, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        joel@joelfernandes.org
Subject: Re: [PATCH 2/4] rcu: Remove useless WRITE_ONCE() on
 rcu_data.exp_deferred_qs
Message-ID: <20210916210514.GA40064@lothringen>
References: <20210916121048.36623-1-frederic@kernel.org>
 <20210916121048.36623-3-frederic@kernel.org>
 <20210916164340.GF4156@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916164340.GF4156@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 16, 2021 at 09:43:40AM -0700, Paul E. McKenney wrote:
> On Thu, Sep 16, 2021 at 02:10:46PM +0200, Frederic Weisbecker wrote:
> > This variable is never written nor read remotely. Remove this confusion.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/rcu/tree_exp.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index f3947c49eee7..4266610b4587 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -255,7 +255,7 @@ static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
> >   */
> >  static void rcu_report_exp_rdp(struct rcu_data *rdp)
> >  {
> > -	WRITE_ONCE(rdp->exp_deferred_qs, false);
> > +	rdp->exp_deferred_qs = false;
> 
> Are you sure that this can never be invoked from an interrupt handler?
> And that rdp->exp_deferred_qs is never read from an interrupt handler?
> If either can happen, then the WRITE_ONCE() does play a role, right?

Well, the only effect I can imagine is that it can partly prevent from an
interrupt to report concurrently the quiescent state during the few
instructions before we mask interrupts and lock the node.

That's a micro performance benefit that avoid a second call to
rcu_report_exp_cpu_mult() with the extra locking and early exit.

But then that racy interrupt can still happen before we clear exp_deferred_qs.
In this case __this_cpu_cmpxchg() would have been more efficient.

Thanks.

> 							Thanx, Paul
> 
> >  	rcu_report_exp_cpu_mult(rdp->mynode, rdp->grpmask, true);
> >  }
> >  
> > -- 
> > 2.25.1
> > 
