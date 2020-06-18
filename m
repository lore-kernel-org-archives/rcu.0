Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AF1C433E1
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 03:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4924F21707
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 03:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592450305;
	bh=/e5onVeNdL2f+5wUE0aYjX768ASF0U0+EB+OQwnYxXo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=zGZoDHIlMMyQPsCwNGvrGhegsdpVucLJCNYKUkjNRuJUM3/UO2NhMQXz4W3k+34Rv
	 ZOl/AueqV9hyKKRiJ+VIsh4k+W3NkTN/PsNpBFNyKWhCh0r1A18u0d2ZMEJbreukDK
	 ak7agQEs5KfdgJVEDyZdYimZeBp8DxA9g1IEyxUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgFRDSY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Jun 2020 23:18:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgFRDSY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Jun 2020 23:18:24 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D52921655;
        Thu, 18 Jun 2020 03:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592450303;
        bh=/e5onVeNdL2f+5wUE0aYjX768ASF0U0+EB+OQwnYxXo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tU3P/Y/reT2d07dhYZ2jW7nhgGZYh4JFnH+OZG1DlZc3JCGG57U4hRnHIon1ryoga
         0iKovYcrB/prWr8KkcrzsYvrBtM5wE1A5bG/FDLJMINEVqGhr0m6tjmFdgVT1LwMXb
         4c5O9ztjb/P9RGHPYLmVBop+GWFrnfWFaPDZaMaE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6504C3523400; Wed, 17 Jun 2020 20:18:23 -0700 (PDT)
Date:   Wed, 17 Jun 2020 20:18:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200618031823.GQ2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200525214800.93072-1-urezki@gmail.com>
 <20200525214800.93072-10-urezki@gmail.com>
 <20200617234609.GA10087@paulmck-ThinkPad-P72>
 <20200618005214.GN8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618005214.GN8681@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jun 17, 2020 at 05:52:14PM -0700, Matthew Wilcox wrote:
> On Wed, Jun 17, 2020 at 04:46:09PM -0700, Paul E. McKenney wrote:
> > > +	// Handle two first channels.
> > > +	for (i = 0; i < FREE_N_CHANNELS; i++) {
> > > +		for (; bkvhead[i]; bkvhead[i] = bnext) {
> > > +			bnext = bkvhead[i]->next;
> > > +			debug_rcu_bhead_unqueue(bkvhead[i]);
> > > +
> > > +			rcu_lock_acquire(&rcu_callback_map);
> > > +			if (i == 0) { // kmalloc() / kfree().
> > > +				trace_rcu_invoke_kfree_bulk_callback(
> > > +					rcu_state.name, bkvhead[i]->nr_records,
> > > +					bkvhead[i]->records);
> > > +
> > > +				kfree_bulk(bkvhead[i]->nr_records,
> > > +					bkvhead[i]->records);
> > > +			} else { // vmalloc() / vfree().
> > > +				for (j = 0; j < bkvhead[i]->nr_records; j++) {
> > > +					trace_rcu_invoke_kfree_callback(
> > > +						rcu_state.name,
> > > +						bkvhead[i]->records[j], 0);
> > > +
> > > +					vfree(bkvhead[i]->records[j]);
> > > +				}
> > > +			}
> > > +			rcu_lock_release(&rcu_callback_map);
> > 
> > Not an emergency, but did you look into replacing this "if" statement
> > with an array of pointers to functions implementing the legs of the
> > "if" statement?  If nothing else, this would greatly reduced indentation.
> 
> I don't think that replacing direct function calls with indirect function
> calls is a great suggestion with the current state of play around branch
> prediction.
> 
> I'd suggest:
> 
>  			rcu_lock_acquire(&rcu_callback_map);
> 			trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
> 				bkvhead[i]->nr_records, bkvhead[i]->records);
>  			if (i == 0) {
>  				kfree_bulk(bkvhead[i]->nr_records,
>  					bkvhead[i]->records);
>  			} else {
>  				for (j = 0; j < bkvhead[i]->nr_records; j++) {
>  					vfree(bkvhead[i]->records[j]);
>  				}
>  			}
>  			rcu_lock_release(&rcu_callback_map);
> 
> But I'd also suggest a vfree_bulk be added.  There are a few things
> which would be better done in bulk as part of the vfree process
> (we batch them up already, but i'm sure we could do better).

I suspect that he would like to keep the tracing.

It might be worth trying the branches, given that they would be constant
and indexed by "i".  The compiler might well remove the indirection.

The compiler guys brag about doing so, which of course might or might
not have any correlation to a given compiler actually doing so.  :-/

Having a vfree_bulk() might well be useful, but I would feel more
confidence in that if there were other callers of kfree_bulk().

But again, either way, future work as far as this series is concerned.

							Thanx, Paul
