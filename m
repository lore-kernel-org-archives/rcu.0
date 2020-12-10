Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303DDC4167B
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 03:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9502343F
	for <rcu@archiver.kernel.org>; Thu, 10 Dec 2020 03:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgLJD0Y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Dec 2020 22:26:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729542AbgLJD0Q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Dec 2020 22:26:16 -0500
Date:   Wed, 9 Dec 2020 19:25:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607570735;
        bh=xbEcoW3M2vQ+jrgz4f9vk0ksfGr4mLvgZcEgACBhBgM=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aWqJ9s2hC652Ab2xsf+4XvRlkctf5Nj4E5uuzxq+r0pyoGTTtT9WwZMWSoRaJSuCf
         SFeiAko1sWkBkTs+gzNBzeZuK4kbryn+gPucqsFk4GkKjGFJJs/Vvc7dFtAgAKP8lp
         eP384FK3zmbtFFGvKz97B6scEhLbpwEExiq1p7Vj4mDDDfq1fgWZMaHc1xwCffwqxW
         0vdunWXsmZ8Wy1iJWh1TfBf11qvkvxreI8Qmo4gInArrg3S7BJb1I9PVTMVz8FSRdV
         kJNujMoLN9HPaB/tX1fzXomY/qkHEvTcpazZ4+0dPdGOGYuyifLpnp2b/jkqU4CzHJ
         CeX8g2gM24/BQ==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        iamjoonsoo.kim@lge.com, andrii@kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2 sl-b 2/5] mm: Make mem_dump_obj() handle NULL and
 zero-sized pointers
Message-ID: <20201210032535.GR2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
 <20201209011303.32737-2-paulmck@kernel.org>
 <462f135a-f8e4-6291-6c1c-4fdd2e415462@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <462f135a-f8e4-6291-6c1c-4fdd2e415462@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 09, 2020 at 06:48:47PM +0100, Vlastimil Babka wrote:
> On 12/9/20 2:13 AM, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > This commit makes mem_dump_obj() call out NULL and zero-sized pointers
> > specially instead of classifying them as non-paged memory.
> > 
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Pekka Enberg <penberg@kernel.org>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: <linux-mm@kvack.org>
> > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Applied, thank you!

						Thanx, Paul

> > ---
> >  mm/util.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/util.c b/mm/util.c
> > index d0e60d2..8c2449f 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -985,7 +985,12 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
> >  void mem_dump_obj(void *object)
> >  {
> >  	if (!virt_addr_valid(object)) {
> > -		pr_cont(" non-paged (local) memory.\n");
> > +		if (object == NULL)
> > +			pr_cont(" NULL pointer.\n");
> > +		else if (object == ZERO_SIZE_PTR)
> > +			pr_cont(" zero-size pointer.\n");
> > +		else
> > +			pr_cont(" non-paged (local) memory.\n");
> >  		return;
> >  	}
> >  	if (kmem_valid_obj(object)) {
> > 
> 
