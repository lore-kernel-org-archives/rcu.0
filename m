Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B18BC3DA66
	for <rcu@archiver.kernel.org>; Wed, 23 Aug 2023 21:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbjHWVWw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Aug 2023 17:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237502AbjHWVW1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Aug 2023 17:22:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADAC10DD
        for <rcu@vger.kernel.org>; Wed, 23 Aug 2023 14:22:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02A9665851
        for <rcu@vger.kernel.org>; Wed, 23 Aug 2023 21:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CC5C433C8;
        Wed, 23 Aug 2023 21:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692825742;
        bh=Q1R+RGB0IhrJB6NbIFmV1MDAlfXY2ePcA4m95KC5IoU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kcwoxU56T70Sovyw2MeNztdJi6Tuivca46exJx3UOtntt7Tnr9daVAGooemyv7tYs
         zJOrNqFvkJ1OjCc6FRHEpsZc/X0ZntBjgpFxIofxGgXhWPfNktc021iaMN+swLyCEY
         MfWj6Yj9zhjzVZywsqscJBzgDhus9jeVeMUyUFEqgHLRkBWBeoEcWOZIgvF1WIJlWB
         xI5R27isHqniSyYX3xZioBbgJOXYvzysrhc34q6qucIM4SYq7g+/UPXDZQO/5CmAH3
         Q3E7nZOBdDwFWJ6YAYQnES5kBZMLc/vOo+KUp/4cgWzRWFUn1xIWFtkIz5r1rRXKa/
         wZL1lXYrJJ3jg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CD10CCE02EE; Wed, 23 Aug 2023 14:22:21 -0700 (PDT)
Date:   Wed, 23 Aug 2023 14:22:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Matthew Wilcox <willy@infradead.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Describe listRCU read-side guarantees
Message-ID: <77c1847d-4744-4d16-bdd4-ae59a9afe9d6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230822200402.159177-1-willy@infradead.org>
 <CAEXW_YQ=-EqhuR-B8gqRzKxiwYNjayCwhNmE270OyXEaxDLhqQ@mail.gmail.com>
 <ZOVKmIDCcHGT8haM@casper.infradead.org>
 <CAEXW_YRcEE5v+6=NWUE8aEVQA+m0aXvjVNtRNc5U28gHxDSTAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YRcEE5v+6=NWUE8aEVQA+m0aXvjVNtRNc5U28gHxDSTAA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 23, 2023 at 09:24:21AM -0400, Joel Fernandes wrote:
> On Tue, Aug 22, 2023 at 7:54 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Aug 22, 2023 at 07:28:34PM -0400, Joel Fernandes wrote:
> > > On Tue, Aug 22, 2023 at 4:04 PM Matthew Wilcox (Oracle)
> > > <willy@infradead.org> wrote:
> > > >
> > > > More explicitly state what is, and what is not guaranteed to those
> > > > who iterate a list while protected by RCU.
> > > >
> > > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > ---
> > > >  Documentation/RCU/listRCU.rst | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
> > > > index bdc4bcc5289f..aff1394f6d93 100644
> > > > --- a/Documentation/RCU/listRCU.rst
> > > > +++ b/Documentation/RCU/listRCU.rst
> > > > @@ -8,6 +8,18 @@ One of the most common uses of RCU is protecting read-mostly linked lists
> > > >  that all of the required memory ordering is provided by the list macros.
> > > >  This document describes several list-based RCU use cases.
> > > >
> > > > +When iterating a list while holding the rcu_read_lock(), writers may
> > > > +modify the list.  The reader is guaranteed to see all of the elements
> > > > +which were added to the list before they acquired the rcu_read_lock()
> > > > +and are still on the list when they drop the rcu_read_unlock().
> > > > +Elements which are added to, or removed from the list may or may not
> > > > +be seen.  If the writer calls list_replace_rcu(), the reader may see
> > > > +either the old element or the new element; they will not see both,
> > > > +nor will they see neither.
> > >
> > > Until here,
> > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >
> > > > +There is no equivalent of list_for_each_entry_reverse(); RCU lists
> > > > +may only be walked forwards.
> > > > +
> > >
> > > Is there a need to mention that? If it changes in the future then the
> > > docs go stale.
> >
> > I don't know if there's a need to mention it.  It was something I noticed
> > while reviewing the code that I didn't see documented anywhere.
> >
> > I don't really care; happy to send a v2 without it, or you can just
> > apply the first paragraph.
> 
> That sounds good to me, Paul do you want to apply it with my Review
> tag and without the last para?

Here you two go, and thank you both!

							Thanx, Paul

------------------------------------------------------------------------

commit 06f9695d1b62163036581722f29fef2d93aa7909
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Tue Aug 22 21:04:02 2023 +0100

    rcu: Describe listRCU read-side guarantees
    
    More explicitly state what is, and what is not guaranteed to those
    who iterate a list while protected by RCU.
    
    [ paulmck: Apply Joel Fernandes feedback. ]
    
    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
    Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
index bdc4bcc5289f..ed5c9d8c9afe 100644
--- a/Documentation/RCU/listRCU.rst
+++ b/Documentation/RCU/listRCU.rst
@@ -8,6 +8,15 @@ One of the most common uses of RCU is protecting read-mostly linked lists
 that all of the required memory ordering is provided by the list macros.
 This document describes several list-based RCU use cases.
 
+When iterating a list while holding the rcu_read_lock(), writers may
+modify the list.  The reader is guaranteed to see all of the elements
+which were added to the list before they acquired the rcu_read_lock()
+and are still on the list when they drop the rcu_read_unlock().
+Elements which are added to, or removed from the list may or may not
+be seen.  If the writer calls list_replace_rcu(), the reader may see
+either the old element or the new element; they will not see both,
+nor will they see neither.
+
 
 Example 1: Read-mostly list: Deferred Destruction
 -------------------------------------------------
