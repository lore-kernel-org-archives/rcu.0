Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23316C433DF
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 20:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E98D620890
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 20:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="edEwuhbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgFRUi0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgFRUi0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 16:38:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DECC06174E;
        Thu, 18 Jun 2020 13:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5WocLv3zCm4O1IL+nMGo7H1sMvF1lavd5wB71baAHqM=; b=edEwuhbUl9Bbthw+xr8A7tYPh+
        iFiUNDguLz/YjmmG+LxrKC2wOt7WUGeXH82zqJhA3xPZ+ByL3hT8Eqig5mwDDvrhPliiUqfD+SFas
        lIk+PItTBspVGlZyXp7AL5RkbrXPZZbJHQLq+YRXGoP+odN0HALXowb8u4xDZr+gIOAbr8Qa2hkG5
        RlknbQiJ2Mxg/Tf0Ou4ID8vfHS2SFglVuO10sJpHftxgO4gbfFN8VBwsRAu//saUv1cyLVcyuLIWd
        Wv+kfnbZuQe4IbVg1GEA16uhoSjd75bMuVfOW18wM50dzZEEismISD9RPg3so/wfu1kMiA9GI+NQi
        /We2KN2w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jm1Ij-0007OB-GB; Thu, 18 Jun 2020 20:38:21 +0000
Date:   Thu, 18 Jun 2020 13:38:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200618203821.GU8681@bombadil.infradead.org>
References: <20200525214800.93072-1-urezki@gmail.com>
 <20200525214800.93072-10-urezki@gmail.com>
 <20200617234609.GA10087@paulmck-ThinkPad-P72>
 <20200618005214.GN8681@bombadil.infradead.org>
 <20200618031823.GQ2723@paulmck-ThinkPad-P72>
 <20200618173520.GC14613@pc636>
 <20200618175719.GT2723@paulmck-ThinkPad-P72>
 <20200618183448.GA15136@pc636>
 <20200618190359.GU2723@paulmck-ThinkPad-P72>
 <20200618203557.GB16976@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618203557.GB16976@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 10:35:57PM +0200, Uladzislau Rezki wrote:
> On Thu, Jun 18, 2020 at 12:03:59PM -0700, Paul E. McKenney wrote:
> but i do not have a strong opinion here, even though i tend to
> say that it would be odd. Having just vfree_bulk(), i think
> would be enough, as a result the code will look like:
> 
> <snip>
>     trace_rcu_invoke_kfree_bulk_callback(
>         rcu_state.name, bkvhead[i]->nr_records,
>             bkvhead[i]->records);
>     if (i == 0)
>         kfree_bulk(bkvhead[i]->nr_records,
>             bkvhead[i]->records);
>     else
>         vfree_bulk(bkvhead[i]->nr_records,
>             bkvhead[i]->records);
> <snip>
> 
> Matthew, what is your thought?

That was my thinking too.  If we had a kvfree_bulk(), I would expect it to
handle a mixture of vfree and kfree, but you've segregated them already.
So I think this is better.
