Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EE8C77B73
	for <rcu@archiver.kernel.org>; Sun, 30 Apr 2023 22:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjD3Wuq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 30 Apr 2023 18:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjD3Wuq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 30 Apr 2023 18:50:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589071BF
        for <rcu@vger.kernel.org>; Sun, 30 Apr 2023 15:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E954B60C89
        for <rcu@vger.kernel.org>; Sun, 30 Apr 2023 22:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53170C433D2;
        Sun, 30 Apr 2023 22:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682895044;
        bh=3g0CIz7HdF6c+jvvx4avkPu/+/MlcK3zaq0Hjsd7AyU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ez7q//DU6a90ptViE7sTes0fcKWCq2lmtuHRFkiKU5iTwCjIIPj5HggLrBExEhyna
         y2IOgM0cTZt5G6Gu3zbY2Ig7cvCM8OcvBNYBVoz0PSGnvUPj5BaA2JKpMeITN/cHRr
         8sD4NI/+/aVdXalucsTgitGjVAgrfynVuXABqcF+Wj6oOCXWQuBbQz8ZBbcr8+X3an
         Yv3Eoqn7ZBQGmMHjO6/seCo2QXgVXPzfOJ1PS80AXT9KfO6mtzue9oAdzFhwigw28r
         a21iCNwL5VMrPfgnrBXZexOQxVLWg86yPEk8jSxcAWuhbVkWp7pAM65zaWH2JTJ3wu
         llMVZhXumrpFw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DF45015405A6; Sun, 30 Apr 2023 15:50:43 -0700 (PDT)
Date:   Sun, 30 Apr 2023 15:50:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>
Subject: Re: Exp GPs and rcu_read_unlock()
Message-ID: <ff9a2946-84e7-422b-a055-86b2dd1d1523@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAEXW_YSFm0XNMkfodBXVx-AsgJvcvGF+kmE+ZqU0Y=ehFJx+JQ@mail.gmail.com>
 <a8ffd9f6-5696-4e49-a91d-bd9954abeb21@paulmck-laptop>
 <CAEXW_YTecqGQu+h_u+esT4a7O=QUwg88q2K3h-oEiLq1x-qWWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YTecqGQu+h_u+esT4a7O=QUwg88q2K3h-oEiLq1x-qWWQ@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Apr 30, 2023 at 05:12:44PM -0400, Joel Fernandes wrote:
> On Sun, Apr 30, 2023 at 4:50 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Sun, Apr 30, 2023 at 03:56:11PM -0400, Joel Fernandes wrote:
> > > Hello,
> > > Quick question (for educational purpose) for anyone - why does
> > > PREEMPT=n kernel not want to get help from __rcu_read_unlock() for
> > > expedited grace periods?
> > >
> > > Basically, with PREEMPT=y kernels,  rcu_read_unlock_special.b.exp_hint
> > > is set to true, but for PREEMPT=n, no such thing is done. Furthermore,
> > > the __rcu_read_unlock() for PREEMPT=n does not help expedited GPs come
> > > to an end either.
> > >
> > > I am guessing the answer is, "no one cares about that", or "no one
> > > reported needing this", but if there is another reason why a PREEMPT=n
> > > kernel should not need it, do let me know :)
> >
> > Because PREEMPT=n kernels value fast rcu_read_unlock() more than they
> > value fast expedited grace periods.
> 
> Ok, makes sense.
> 
> > > To make it more interesting, it appears that CONFIG_PREEMPT=y where
> > > preemption is dynamically disabled, it _should_ have the  effect of
> > > helping expedited GPs as far as I can see. Which further seems a
> > > difference between booting PREEMPT=n versus PREEMPT=y + booting with
> > > preemption turned off via boot option.
> >
> > Yes, very much so!
> >
> > So if you care deeply about fast expedited grace periods and less
> > so about smallish rcu_read_unlock() slowdowns, but otherwise want
> > non-preemptibility, CONFIG_PREEMPT_DYNAMIC=y and dynamically selecting
> > non-preemptible operation might be your best choice.
> 
> Makes sense, thanks!

Of course, if this is to be advertised at all widely, it would be good
to actually measure it.

But what else is new?  ;-)

							Thanx, Paul
