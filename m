Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812C7C433DF
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 00:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F8F520897
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 00:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="idD2mC8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgFRAwb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Jun 2020 20:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgFRAwa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Jun 2020 20:52:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F8AC06174E;
        Wed, 17 Jun 2020 17:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wnZd+othysjnKDvkqRAupou7YHZYy91X+uiucxvLQzg=; b=idD2mC8FmOi79TIHBN/2QGTXQN
        58eJlL9b8Pt7orugy3GXFfZ0Y1z9ctqX84GeV6mS8Bu3N+JxLsuO/6BO9yVyPogsKU0mY27n3ngUM
        nSrxTf0GDjrS1RFsH9kN8kfYLMia00z9NAq9Y+PyH5d+4cKU0DWYjoXadDBvrMtgbjY+2uakqrrOT
        cDjZ1dE9++v66981aYKhdondTpA3cea311tr3nr2vshADsxubI5gQCRd5NSURC8ELrYxYjL/QQsih
        jJ1X0vo6j80+OGG2nBV0rz/vcOwJKkAFa2MKrhxyqbzRQNuRTgZvWHTyDLnT6XCmpvhiiKWYfCcUl
        U9cxNT4w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlims-0003ww-V7; Thu, 18 Jun 2020 00:52:14 +0000
Date:   Wed, 17 Jun 2020 17:52:14 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200618005214.GN8681@bombadil.infradead.org>
References: <20200525214800.93072-1-urezki@gmail.com>
 <20200525214800.93072-10-urezki@gmail.com>
 <20200617234609.GA10087@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617234609.GA10087@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jun 17, 2020 at 04:46:09PM -0700, Paul E. McKenney wrote:
> > +	// Handle two first channels.
> > +	for (i = 0; i < FREE_N_CHANNELS; i++) {
> > +		for (; bkvhead[i]; bkvhead[i] = bnext) {
> > +			bnext = bkvhead[i]->next;
> > +			debug_rcu_bhead_unqueue(bkvhead[i]);
> > +
> > +			rcu_lock_acquire(&rcu_callback_map);
> > +			if (i == 0) { // kmalloc() / kfree().
> > +				trace_rcu_invoke_kfree_bulk_callback(
> > +					rcu_state.name, bkvhead[i]->nr_records,
> > +					bkvhead[i]->records);
> > +
> > +				kfree_bulk(bkvhead[i]->nr_records,
> > +					bkvhead[i]->records);
> > +			} else { // vmalloc() / vfree().
> > +				for (j = 0; j < bkvhead[i]->nr_records; j++) {
> > +					trace_rcu_invoke_kfree_callback(
> > +						rcu_state.name,
> > +						bkvhead[i]->records[j], 0);
> > +
> > +					vfree(bkvhead[i]->records[j]);
> > +				}
> > +			}
> > +			rcu_lock_release(&rcu_callback_map);
> 
> Not an emergency, but did you look into replacing this "if" statement
> with an array of pointers to functions implementing the legs of the
> "if" statement?  If nothing else, this would greatly reduced indentation.

I don't think that replacing direct function calls with indirect function
calls is a great suggestion with the current state of play around branch
prediction.

I'd suggest:

 			rcu_lock_acquire(&rcu_callback_map);
			trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
				bkvhead[i]->nr_records, bkvhead[i]->records);
 			if (i == 0) {
 				kfree_bulk(bkvhead[i]->nr_records,
 					bkvhead[i]->records);
 			} else {
 				for (j = 0; j < bkvhead[i]->nr_records; j++) {
 					vfree(bkvhead[i]->records[j]);
 				}
 			}
 			rcu_lock_release(&rcu_callback_map);

But I'd also suggest a vfree_bulk be added.  There are a few things
which would be better done in bulk as part of the vfree process
(we batch them up already, but i'm sure we could do better).

