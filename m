Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E9FC433EF
	for <rcu@archiver.kernel.org>; Thu, 25 Nov 2021 13:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349950AbhKYNeH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 25 Nov 2021 08:34:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348505AbhKYNcH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 25 Nov 2021 08:32:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60F3A604DC;
        Thu, 25 Nov 2021 13:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637846935;
        bh=yqiqGbuyTjJTG0oblRRU3rs5NLfBTBZCOCZce5YSkZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhyd8RgHCVgmy0Y/SxVKJ60pGso4EW0WK5oEJH3gkMsgsfmzBrBo/4hIvGb1jCI7D
         efSli2X2qafiyBWijtRCk3QoDt9qruAKO+Y6US2FdDbez5K1Nx6/H0pK46QLQ0ry3V
         WNznP8n5gmDfyJ3SDtlbZbDeV12Hk6EGUSweVee1BI60TK53+xOvHF0894AwpYzQsN
         R9QCzwpZ+cYXEDRXv6qR7gqlsvJHHXNdfja2j+dyOdh5mvJLnQ84PwvGXj7FClGizI
         6UJUL4milykd9zr/Gm/m9r5TBTe9863Zbhx4jZE7TDPCbsfLHoZEWSnS8BHASSULRi
         54M+FmhXTDS7Q==
Date:   Thu, 25 Nov 2021 14:28:53 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20211125132853.GA509134@lothringen>
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-6-frederic@kernel.org>
 <20211125004720.GV641268@paulmck-ThinkPad-P17-Gen-1>
 <20211125044132.GA105778@lapt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125044132.GA105778@lapt>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 24, 2021 at 08:41:32PM -0800, Yury Norov wrote:
> On Wed, Nov 24, 2021 at 04:47:20PM -0800, Paul E. McKenney wrote:
> > On Tue, Nov 23, 2021 at 01:37:07AM +0100, Frederic Weisbecker wrote:
> > > If a user wants to boot without any CPU in offloaded mode initially but
> > > with the possibility to offload them later using cpusets, provide a way
> > > to simply pass an empty "rcu_nocbs" kernel parameter which will enforce
> > > the creation of dormant nocb kthreads.
> > 
> > Huh.  This would have been a use for Yury Norov's "none" bitmask
> > specifier.  ;-)
> > 
> > I pulled this one in with the usual wordsmithing.
> > 
> > 							Thanx, Paul
> 
> I think 'rcu_nocbs=,' should work as 'none'. But I admit that it looks
> awkward. The following patch adds clear 'none' semantics to the parser.
> If you like it, I think you may drop non-documentation part of this
> patch.

I don't have real objection, but I fear that "rcu_nocbs=none" might be
interpretated as rcu_nocbs is entirely deactivated, whereas "rcu_nocbs"
alone makes it clear that we are turning something on.

We can support both though.

Thanks.
