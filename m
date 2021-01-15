Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6271C433DB
	for <rcu@archiver.kernel.org>; Fri, 15 Jan 2021 18:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 920B421D7A
	for <rcu@archiver.kernel.org>; Fri, 15 Jan 2021 18:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733116AbhAOSzc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 15 Jan 2021 13:55:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729147AbhAOSzb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 15 Jan 2021 13:55:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03BED21D7A;
        Fri, 15 Jan 2021 18:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610736891;
        bh=3nnubeEI0xseEwRL/nl1oqeiEPuHEudJ0BHZbkrzU8A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VJc4sEEUNMsOeTpGwtzoqH3bxcc8MgNd5Vm/NHbFLjl0mnNri4CkK1aLv3TCSypjJ
         aXZSgjwGMtvudB2ciC2ti5G4jJATJqsbAZRaljutyJt4miv8yPrfpHwZvwtdICZGs/
         5Qi9CqqspHqoJ6LhduDu/8geppmR/6pL2Fj1RfMP/abDsM5G2eZeYmXaE7TsDt54Ju
         myc+r9cFVWe1Fq+h9msnm7XnXj/QvFfORHa3w4q/YskG4mncawKFt2u0JHyABgIfTP
         zJ7VKrJQZCbghNVfQouFufA4Jo5pALSlRLyuyqk0611iAWqz73kENqmf91VeRRlEF9
         0xqpZMB5AcZHQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C9027352162B; Fri, 15 Jan 2021 10:54:50 -0800 (PST)
Date:   Fri, 15 Jan 2021 10:54:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: better document kfree_rcu()
Message-ID: <20210115185450.GM2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <2ec9a8bc8b411b04e2f541b285cc0a133a6d94de.1610608910.git.mchehab+huawei@kernel.org>
 <20210114113619.GA49982@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114113619.GA49982@pc638.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 14, 2021 at 12:36:19PM +0100, Uladzislau Rezki wrote:
> On Thu, Jan 14, 2021 at 08:22:02AM +0100, Mauro Carvalho Chehab wrote:
> > After changeset 5130b8fd0690 ("rcu: Introduce kfree_rcu() single-argument macro"),
> > kernel-doc now emits two warnings:
> > 
> > 	./include/linux/rcupdate.h:884: warning: Excess function parameter 'ptr' description in 'kfree_rcu'
> > 	./include/linux/rcupdate.h:884: warning: Excess function parameter 'rhf' description in 'kfree_rcu'
> > 
> > What's happening here is that some macro magic was added in order
> > to call two different versions of kfree_rcu(), being the first one
> > with just one argument and a second one with two arguments.
> > 
> > That makes harder to document the kfree_rcu() arguments, which
> > also reflects on the documentation text.
> > 
> > In order to make clearer that this macro accepts optional
> > arguments, by using macro concatenation, changing its
> > definition from:
> > 	#define kfree_rcu kvfree_rcu
> > 
> > to:
> > 	#define kfree_rcu(ptr, rhf...) kvfree_rcu(ptr, ## rhf)
> > 
> > That not only helps kernel-doc to understand the macro arguemnts,
> > but also provides a better C definition that makes clearer that
> > the first argument is mandatory and the second one is optional.
> > 
> > Fixes: 5130b8fd0690 ("rcu: Introduce kfree_rcu() single-argument macro")
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  include/linux/rcupdate.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index bd04f722714f..5cc6deaa5df2 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -881,7 +881,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
> >   * The BUILD_BUG_ON check must not involve any function calls, hence the
> >   * checks are done in macros here.
> >   */
> > -#define kfree_rcu kvfree_rcu
> > +#define kfree_rcu(ptr, rhf...) kvfree_rcu(ptr, ## rhf)
> >  
> >  /**
> >   * kvfree_rcu() - kvfree an object after a grace period.
> > -- 
> > 2.29.2
> > 
> I think it is fair enough. I checked the "kernel-doc" and after this
> change it does not detect any violations which are in question.
> 
> Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Queued, thank you both!

							Thanx, Paul
