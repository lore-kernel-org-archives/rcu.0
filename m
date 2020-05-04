Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A36C28CBC
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 00:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E233D2071C
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 00:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588552188;
	bh=+8YMjNEnF13cfXYrgUz2M00Bbq7+zsq09cXVIuNAnd0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Pp03F8/DyGblakRO3+LWAgaeNO5+1G+reKpTVb2U3w1+xk5qcsUyloG9kXFYyBBsZ
	 eOwrYw0E/3vBfgmiec0p49mHoKPyRmJ8xIXG47M04Gqsvczu+absviaffsa6ztYvUQ
	 hdq88WFu5BaW+bdZGEtd8U+gK7qC3w8TAaulu+UI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgEDA3s (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 3 May 2020 20:29:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgEDA3s (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 3 May 2020 20:29:48 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE00D206F0;
        Mon,  4 May 2020 00:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588552188;
        bh=+8YMjNEnF13cfXYrgUz2M00Bbq7+zsq09cXVIuNAnd0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=yoEUGLfrEMPffUKUyVUzwfbqtjC/vMc+F2OEMPtkgCwGyyCBWG8Pr9x7xpZLZnWuC
         OsBEVOdcvkf5UbDd9OgHxVe+iZbKl1FOOGDdE/M/oG921PnhFyoLNwzagL4FFH5e6Z
         yz1GtpSyo7uHOVTibgczPNHg7chq/gauhjhB5aBg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CCCBA3520D7D; Sun,  3 May 2020 17:29:47 -0700 (PDT)
Date:   Sun, 3 May 2020 17:29:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 20/24] rcu/tree: Make kvfree_rcu() tolerate any alignment
Message-ID: <20200504002947.GG2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-21-urezki@gmail.com>
 <20200501230052.GG7560@paulmck-ThinkPad-P72>
 <20200504002437.GA212435@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504002437.GA212435@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, May 03, 2020 at 08:24:37PM -0400, Joel Fernandes wrote:
> On Fri, May 01, 2020 at 04:00:52PM -0700, Paul E. McKenney wrote:
> > On Tue, Apr 28, 2020 at 10:58:59PM +0200, Uladzislau Rezki (Sony) wrote:
> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > 
> > > Handle cases where the the object being kvfree_rcu()'d is not aligned by
> > > 2-byte boundaries.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/tree.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 501cac02146d..649bad7ad0f0 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2877,6 +2877,9 @@ struct kvfree_rcu_bulk_data {
> > >  #define KVFREE_BULK_MAX_ENTR \
> > >  	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
> > >  
> > > +/* Encoding the offset of a fake rcu_head to indicate the head is a wrapper. */
> > > +#define RCU_HEADLESS_KFREE BIT(31)
> > 
> > Did I miss the check for freeing something larger than 2GB?  Or is this
> > impossible, even on systems with many terabytes of physical memory?
> > Even if it is currently impossible, what prevents it from suddenly
> > becoming all too possible at some random point in the future?  If you
> > think that this will never happen, please keep in mind that the first
> > time I heard "640K ought to be enough for anybody", it sounded eminently
> > reasonable to me.
> > 
> > Besides...
> > 
> > Isn't the offset in question the offset of an rcu_head struct within
> > the enclosing structure? If so, why not keep the current requirement
> > that this be at least 16-bit aligned, especially given that some work
> > is required to make that alignment less than pointer sized?  Then you
> > can continue using bit 0.
> > 
> > This alignment requirement is included in the RCU requirements
> > documentation and is enforced within the __call_rcu() function.
> > 
> > So let's leave this at bit 0.
> 
> This patch is needed only if we are growing the fake rcu_head. Since you
> mentioned in a previous patch in this series that you don't want to do that,
> and just rely on availability of the array of pointers or synchronize_rcu(),
> we can drop this patch. If we are not dropping that earlier patch, let us
> discuss more.

Dropping it sounds very good to me!

							Thanx, Paul
