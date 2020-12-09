Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592EBC433FE
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 17:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 271EC2076B
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 17:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgLIRx5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Dec 2020 12:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgLIRx5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Dec 2020 12:53:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8737FC0613CF;
        Wed,  9 Dec 2020 09:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fL27NHJJV4o8PPIFazAlhTrb/LmmYuac+t8OjbZn+1I=; b=NFu5MdxXrbYUn+dYqC7lYaYIxy
        tS8OKT7nzU72PAjOqUpTcLwWH7TJVo9HlBW+hHrZvOlVh4tXQpImBZ3coyvNKuj72XJzyq2FIDFas
        L6F5o3eE3+Fi2evfrHjJRSCK4cROrZsAvuO+1Cp4J8HiedF+GXWIeKNEY199cBW86e/qi9183/Gmu
        aqrB+pfEMZl7uREbVep5Pyg7jCxRDyc9pJBtGc8ihD60Gjcc5wPYILfejLpbO15bnwYQpFDxiH4DO
        7l9JI1ojkhcD1tdcxxQj31lObxUC9DYZWz+LT1ZPDjNgkQuCOcrqoAtG4nmXvDCl/Mjjz0M+R/+zE
        NVbVEQVw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kn3eE-0006pM-UG; Wed, 09 Dec 2020 17:53:07 +0000
Date:   Wed, 9 Dec 2020 17:53:06 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, iamjoonsoo.kim@lge.com,
        andrii@kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2 sl-b 1/5] mm: Add mem_dump_obj() to print source of
 memory block
Message-ID: <20201209175306.GC25719@infradead.org>
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
 <20201209011303.32737-1-paulmck@kernel.org>
 <20201209081710.GA17642@infradead.org>
 <20201209145702.GA2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209145702.GA2657@paulmck-ThinkPad-P72>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 09, 2020 at 06:57:02AM -0800, Paul E. McKenney wrote:
> On Wed, Dec 09, 2020 at 08:17:10AM +0000, Christoph Hellwig wrote:
> > Your two new exports don't actually seem to get used in modular code
> > at all in this series.
> 
> Indeed, and I either need to remove the exports or make my test code in
> kernel/rcu/rcuscale.o suitable for upstreaming.  Or find the appropriate
> mm/slab selftest location.

I'd rather not export something like this which pokes deep into
internals.  That being said I've been working on off on a
EXPORT_SYMBOL_FOR() that just exports a symbol to one specific module.
Hopefully I'll finish it for the next merge window, and with that
I'd feel much more comfortable with an export.
