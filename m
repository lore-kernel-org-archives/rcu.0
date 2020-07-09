Return-Path: <SRS0=ITGo=AU=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B263DC433DF
	for <rcu@archiver.kernel.org>; Thu,  9 Jul 2020 13:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA212076A
	for <rcu@archiver.kernel.org>; Thu,  9 Jul 2020 13:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgGINJz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:09:55 -0400
Received: from sym2.noone.org ([178.63.92.236]:33974 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgGINJz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 9 Jul 2020 09:09:55 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4B2c355l5mzvjc1; Thu,  9 Jul 2020 15:09:53 +0200 (CEST)
Date:   Thu, 9 Jul 2020 15:09:52 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: fix kerneldoc comments in rcuupdate.h
Message-ID: <20200709130952.o6huqi7s4ktmehhe@distanz.ch>
References: <20200702162557.30734-1-tklauser@distanz.ch>
 <20200702170604.GT9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702170604.GT9247@paulmck-ThinkPad-P72>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul

On 2020-07-02 at 19:06:04 +0200, Paul E. McKenney <paulmck@kernel.org> wrote:
> On Thu, Jul 02, 2020 at 06:25:57PM +0200, Tobias Klauser wrote:
> > Fix the kerneldoc comments for rcu_read_unlock_bh(),
> > rcu_read_unlock_sched() and rcu_head_after_call_rcu() so they e.g. get
> > properly linked in the API documentation.
> > 
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> 
> The addition of the second "*" is clearly needed, good eyes and thank you!
> But where do these entries link to?  As in does adding the "()" link
> somewhere else, and if so, where?  If it instead links to the entry
> created by the corresponding docbook comment, is that really helpful?
> 
> What am I missing here?

I've sent v2 of the patch [1] which amends the commit message to mention
which the "()" were added.

[1] https://lore.kernel.org/rcu/20200709130559.25588-1-tklauser@distanz.ch/

As noted in the previous message [2], adding the "()" doesn't change
anything with regards to whether a link gets created and where it points
to. Thus, I mentiond in the v2 commit message that this is only for
consistency with kerneldoc comments of other functions in the same file.

[2] https://lore.kernel.org/rcu/20200702194306.uc4sumrk7ahuk23l@distanz.ch/

Thanks
Tobias
