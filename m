Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86304C433DF
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 18:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5342F2083B
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 18:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hifGhXI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgFRSh4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgFRShz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 14:37:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC8FC06174E;
        Thu, 18 Jun 2020 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ddwW9UoXI/MN9HL8fzF1g7jZ0jnk2+UjDMVeOqLWnjM=; b=hifGhXI39S1oGvllZSeocYr/9q
        usv3HGVu7eu7nctGWTyCePuHTwwA/GcMxnB9TSd+iIOwVI6pHHzBfZWAb85vWO9JpoL5ToFsq2y82
        eV54oVNGlHHO9pkg/6e2NdQrnY6FR68GeJA6fcxynQkjjxibFkoCKZPjxCJdBDxcmQ4FEr58WutBE
        ySTcBdUEwVgZeXE3BcBZ3HknKVby29ktak1hpUTQB+91OSW2j9avEKU4x42rWUfpmxQ42MxSA/tC8
        kuFKPieWdHRzpj01WEYgSji6CNZoMDhzVbzKnhJL95yVn6ZipUVnzbXgNsntgESDTbpY/EVfrJFLs
        Kdp1o38A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlzQ7-0000Wp-E8; Thu, 18 Jun 2020 18:37:51 +0000
Date:   Thu, 18 Jun 2020 11:37:51 -0700
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
Message-ID: <20200618183751.GT8681@bombadil.infradead.org>
References: <20200525214800.93072-1-urezki@gmail.com>
 <20200525214800.93072-10-urezki@gmail.com>
 <20200617234609.GA10087@paulmck-ThinkPad-P72>
 <20200618172504.GA14613@pc636>
 <20200618173206.GS2723@paulmck-ThinkPad-P72>
 <20200618175623.GA14865@pc636>
 <20200618181541.GS8681@bombadil.infradead.org>
 <20200618182333.GA15082@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618182333.GA15082@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 08:23:33PM +0200, Uladzislau Rezki wrote:
> > +void vfree_bulk(size_t count, void **addrs)
> > +{
> > +	unsigned int i;
> > +
> > +	BUG_ON(in_nmi());
> > +	might_sleep_if(!in_interrupt());
> > +
> > +	for (i = 0; i < count; i++) {
> > +		void *addr = addrs[i];
> > +		kmemleak_free(addr);
> > +		if (addr)
> > +			__vfree(addr);
> > +	}
> > +}
> > +EXPORT_SYMBOL(vfree_bulk);
> > +
> >
> Can we just do addrs[i] all over the loop?
> 
> Also, we can just call vfree() instead that has all checking we
> need: NMI, kmemleak, might_sleep.

Of course we _can_.  But would we want to?  This way, we only do these
checks once instead of once per pointer, which is rather the point
of batching.

I might actually go further and hoist the in_interrupt() check into
this function ... I suspect the RCU code always runs in_interrupt()
and so we always call vfree_deferred().
