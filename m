Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77242EE49AB
	for <rcu@archiver.kernel.org>; Tue, 22 Aug 2023 23:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjHVXyH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Aug 2023 19:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjHVXyH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Aug 2023 19:54:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB63E50
        for <rcu@vger.kernel.org>; Tue, 22 Aug 2023 16:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=AVy2H1FdD3dG+6kybHJG5MjuofGHgPFZmsfKLf+wcZQ=; b=FPII5SomaO258ZVT1vm4WJVDNf
        zhP2R5bZ+njRcniwUsUt3/lLDHxKRR4kc4Y1bXxWNuJnwtn0VMcuyqBWu404ZdpLHtZeFyLxXUxtX
        B9yLmItXxyPd8hDsQGZhW7yrbcvZ/W4ojY+qkRklDJVbJhrn8uSFjJBwGrfH0uWxYzMUuf4Ee12ed
        1sCsVCrcffayjBH4f50q38OaNmerzu4Tf/vecGs1sXrtfeF54h3WAqdrjtufu5ZYKDlhSGmCuFgPv
        QRwMzDcecShy3/ml+VGCUlZ+xWUamUJVeVRrH6M/WxS6ukSTtc+C9OEDQLfLo95tkZpEJIyrtKE8Y
        yOmUUNeA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYbCC-001dMO-S7; Tue, 22 Aug 2023 23:54:00 +0000
Date:   Wed, 23 Aug 2023 00:54:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Describe listRCU read-side guarantees
Message-ID: <ZOVKmIDCcHGT8haM@casper.infradead.org>
References: <20230822200402.159177-1-willy@infradead.org>
 <CAEXW_YQ=-EqhuR-B8gqRzKxiwYNjayCwhNmE270OyXEaxDLhqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQ=-EqhuR-B8gqRzKxiwYNjayCwhNmE270OyXEaxDLhqQ@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 22, 2023 at 07:28:34PM -0400, Joel Fernandes wrote:
> On Tue, Aug 22, 2023 at 4:04 PM Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> >
> > More explicitly state what is, and what is not guaranteed to those
> > who iterate a list while protected by RCU.
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  Documentation/RCU/listRCU.rst | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
> > index bdc4bcc5289f..aff1394f6d93 100644
> > --- a/Documentation/RCU/listRCU.rst
> > +++ b/Documentation/RCU/listRCU.rst
> > @@ -8,6 +8,18 @@ One of the most common uses of RCU is protecting read-mostly linked lists
> >  that all of the required memory ordering is provided by the list macros.
> >  This document describes several list-based RCU use cases.
> >
> > +When iterating a list while holding the rcu_read_lock(), writers may
> > +modify the list.  The reader is guaranteed to see all of the elements
> > +which were added to the list before they acquired the rcu_read_lock()
> > +and are still on the list when they drop the rcu_read_unlock().
> > +Elements which are added to, or removed from the list may or may not
> > +be seen.  If the writer calls list_replace_rcu(), the reader may see
> > +either the old element or the new element; they will not see both,
> > +nor will they see neither.
> 
> Until here,
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> > +There is no equivalent of list_for_each_entry_reverse(); RCU lists
> > +may only be walked forwards.
> > +
> 
> Is there a need to mention that? If it changes in the future then the
> docs go stale.

I don't know if there's a need to mention it.  It was something I noticed
while reviewing the code that I didn't see documented anywhere.

I don't really care; happy to send a v2 without it, or you can just
apply the first paragraph.
