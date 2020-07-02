Return-Path: <SRS0=c9Wv=AN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E296FC433E0
	for <rcu@archiver.kernel.org>; Thu,  2 Jul 2020 19:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48DC206E2
	for <rcu@archiver.kernel.org>; Thu,  2 Jul 2020 19:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgGBTnK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:43:10 -0400
Received: from sym2.noone.org ([178.63.92.236]:39166 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgGBTnK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Jul 2020 15:43:10 -0400
X-Greylist: delayed 11831 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jul 2020 15:43:09 EDT
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49yT642psHzvjc1; Thu,  2 Jul 2020 21:43:08 +0200 (CEST)
Date:   Thu, 2 Jul 2020 21:43:07 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: fix kerneldoc comments in rcuupdate.h
Message-ID: <20200702194306.uc4sumrk7ahuk23l@distanz.ch>
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

Adding the "()" doesn't change anything with regards to whether a link
gets created and where it points to, as far as I can tell. I mainly
changed these to be consistent with the kerneldoc comments for other
functions in the same file, which all use the "()" notation. Sorry, I
should have mentioned that in the commit message.

I can drop this part from the patch or send a patch with a revised
commit message if you prefer.

Thanks
Tobias
