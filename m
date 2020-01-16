Return-Path: <SRS0=/SR9=3F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD2CC33CAF
	for <rcu@archiver.kernel.org>; Thu, 16 Jan 2020 17:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A3924750
	for <rcu@archiver.kernel.org>; Thu, 16 Jan 2020 17:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196672;
	bh=qmjLCbfQKX13aq2gy6zUekqoctbef1EOkzCXBZbK+zg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=SFI6j0m/9AB1jvldk6rUB6J6xpQabKO2NqeulDB7St4G/6DlajZQ+3SfzPHGK2Er0
	 toUv0gGcBhTlABiPcA03OR1KQ6SCxwPJrYhiqfCsQKwY1BQ2fWhJ84hHTMTqXYO32L
	 bWtfAq4scEJvNDWN1JB5sVfhtzm1bEUQWQp0qa5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394185AbgAPRoc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:44:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394176AbgAPRoa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Jan 2020 12:44:30 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B51624761;
        Thu, 16 Jan 2020 17:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196670;
        bh=qmjLCbfQKX13aq2gy6zUekqoctbef1EOkzCXBZbK+zg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YTGwgwmWb32UjsVSCOMqIL6CkchqelmJN8BFTIXQr4OSEpqZDt56wJ0o5qv1EAKgE
         ksRUXljCc+Kjw3ijLCCBBrg1Ho5y4NbPDypw6sOII/drjZfXkrCX1TBH4zEBHSX/8z
         LmGtRQ32R8dTbPRynOJaw5II7Ucp5QoHpyJIYkXU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 851A735227B9; Thu, 16 Jan 2020 09:44:29 -0800 (PST)
Date:   Thu, 16 Jan 2020 09:44:29 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: support kfree_bulk() interface in
 kfree_rcu()
Message-ID: <20200116174429.GW2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191231122241.5702-1-urezki@gmail.com>
 <20200116011410.GC246464@google.com>
 <20200116024126.GS2935@paulmck-ThinkPad-P72>
 <20200116172753.GB23524@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116172753.GB23524@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 16, 2020 at 06:27:53PM +0100, Uladzislau Rezki wrote:
> On Wed, Jan 15, 2020 at 06:41:26PM -0800, Paul E. McKenney wrote:
> > On Wed, Jan 15, 2020 at 08:14:10PM -0500, Joel Fernandes wrote:
> > > On Tue, Dec 31, 2019 at 01:22:41PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > kfree_rcu() logic can be improved further by using kfree_bulk()
> > > > interface along with "basic batching support" introduced earlier.
> > > > 
> > > > The are at least two advantages of using "bulk" interface:
> > > > - in case of large number of kfree_rcu() requests kfree_bulk()
> > > >   reduces the per-object overhead caused by calling kfree()
> > > >   per-object.
> > > > 
> > > > - reduces the number of cache-misses due to "pointer chasing"
> > > >   between objects which can be far spread between each other.
> > > > 
> > > > This approach defines a new kfree_rcu_bulk_data structure that
> > > > stores pointers in an array with a specific size. Number of entries
> > > > in that array depends on PAGE_SIZE making kfree_rcu_bulk_data
> > > > structure to be exactly one page.
> > > > 
> > > > Since it deals with "block-chain" technique there is an extra
> > > > need in dynamic allocation when a new block is required. Memory
> > > > is allocated with GFP_NOWAIT | __GFP_NOWARN flags, i.e. that
> > > > allows to skip direct reclaim under low memory condition to
> > > > prevent stalling and fails silently under high memory pressure.
> > > > 
> > > > The "emergency path" gets maintained when a system is run out
> > > > of memory. In that case objects are linked into regular list
> > > > and that is it.
> > > > 
> > > > In order to evaluate it, the "rcuperf" was run to analyze how
> > > > much memory is consumed and what is kfree_bulk() throughput.
> > > > 
> > > > Testing on the HiKey-960, arm64, 8xCPUs with below parameters:
> > > > 
> > > > CONFIG_SLAB=y
> > > > kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1
> > > > 
> > > > 102898760401 ns, loops: 200000, batches: 5822, memory footprint: 158MB
> > > > 89947009882  ns, loops: 200000, batches: 6715, memory footprint: 115MB
> > > > 
> > > > rcuperf shows approximately ~12% better throughput(Total time)
> > > > in case of using "bulk" interface. The "drain logic" or its RCU
> > > > callback does the work faster that leads to better throughput.
> > > 
> > > Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > (Vlad is going to post a v2 which fixes a debugobjects bug but that should
> > > not have any impact on testing).
> > 
> > Very good!  Uladzislau, could you please add Joel's Tested-by in
> > your next posting?
> > 
> I will add for sure, with the a V2 version. Also, i will update the
> commit message by adding the results related to different slab cache
> usage, i mean with Joel's recent patch.

Sounds good, looking forward to it!

							Thanx, Paul
