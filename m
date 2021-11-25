Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ABDC433F5
	for <rcu@archiver.kernel.org>; Thu, 25 Nov 2021 15:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbhKYPML (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 25 Nov 2021 10:12:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230167AbhKYPKL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 25 Nov 2021 10:10:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B6A3610FB;
        Thu, 25 Nov 2021 15:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637852820;
        bh=NBk2ZywPpR9zMd+czkeAb2gbQb8w/M83yM/9BZa1Zpc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=W4ynoImd8V5wyJAe1zeOiRqEL2YIvlDymE5z3roFVcRqL8MpbGJUFUIw+/RThZVLF
         4Lk6R4FME68Cgb44BkKW3WwTPzvDvt5tkD5A7/NOIkI9vdFkE6dclI5NxXvf8nwUQp
         njW6oB8gEj+Pr8gPhU98O9zvk+uw1aiMTnK8YITJVhnR+3FLxIbZ7RBqwDVVNfZ31H
         2x2cCpr86o0LubhfZf/wQsMEGtqejad+5jjxnBLeGS7aXsGOSrMUZnrz5ZPv7MFSS0
         QB9pgZT0VolC9ygIWPrp0G8eBCMD7gGzJxT/JaSJLJgQ+ZPES3cetqPlbLXW5T3vo5
         dLWQab2E9vHUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F2B755C04B0; Thu, 25 Nov 2021 07:06:59 -0800 (PST)
Date:   Thu, 25 Nov 2021 07:06:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/6] rcu/nocb: Allow empty "rcu_nocbs" kernel parameter
Message-ID: <20211125150659.GE641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-6-frederic@kernel.org>
 <20211125004720.GV641268@paulmck-ThinkPad-P17-Gen-1>
 <20211125044132.GA105778@lapt>
 <20211125132853.GA509134@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125132853.GA509134@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 25, 2021 at 02:28:53PM +0100, Frederic Weisbecker wrote:
> On Wed, Nov 24, 2021 at 08:41:32PM -0800, Yury Norov wrote:
> > On Wed, Nov 24, 2021 at 04:47:20PM -0800, Paul E. McKenney wrote:
> > > On Tue, Nov 23, 2021 at 01:37:07AM +0100, Frederic Weisbecker wrote:
> > > > If a user wants to boot without any CPU in offloaded mode initially but
> > > > with the possibility to offload them later using cpusets, provide a way
> > > > to simply pass an empty "rcu_nocbs" kernel parameter which will enforce
> > > > the creation of dormant nocb kthreads.
> > > 
> > > Huh.  This would have been a use for Yury Norov's "none" bitmask
> > > specifier.  ;-)
> > > 
> > > I pulled this one in with the usual wordsmithing.
> > > 
> > > 							Thanx, Paul
> > 
> > I think 'rcu_nocbs=,' should work as 'none'. But I admit that it looks
> > awkward. The following patch adds clear 'none' semantics to the parser.
> > If you like it, I think you may drop non-documentation part of this
> > patch.
> 
> I don't have real objection, but I fear that "rcu_nocbs=none" might be
> interpretated as rcu_nocbs is entirely deactivated, whereas "rcu_nocbs"
> alone makes it clear that we are turning something on.

How about "rcu_nocbs=,"?  ;-)

							Thanx, Paul

> We can support both though.
> 
> Thanks.
