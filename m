Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C59BC433FE
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 17:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB01223C8E
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 17:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbgLIR75 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Dec 2020 12:59:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730721AbgLIR75 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Dec 2020 12:59:57 -0500
Date:   Wed, 9 Dec 2020 09:59:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607536756;
        bh=8sM2aGR0RHBZfW1NngwzFo47cupDQcvozNvQD103Fts=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PizATpkuznwPVPKW0PBMROo2xDQ++syQfPuvuAfXp05bOloBgW3pK9kCGXaiwSgPY
         nujEM+tLNALs4QKTXWSOOclFBBE8G3Kyf8aUSRBvATcu68KbPoqGYdCHFWWiz0uen5
         ZvFqiUjzz83H2TNSKMLyzdHljR94w/CPeYMgMCoJpqIN/k/rbv2rxlErEQ0TyeSr3M
         M/9q8/FhC+7zNOHiDmOrgIqa3Jck7qAJIdJwvfcfSNIYiAWXYzyl4NlrTBeGYDHdmT
         0YtPuTpOSJK1E4zVUmbEme4fMdpZdmMyahZmllKZsdd0Rf/1FxR2L1ABa1eEWZaARX
         a9w6mpO7OH1iQ==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
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
Subject: Re: [PATCH v2 sl-b 1/5] mm: Add mem_dump_obj() to print source of
 memory block
Message-ID: <20201209175916.GE2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
 <20201209011303.32737-1-paulmck@kernel.org>
 <20201209081710.GA17642@infradead.org>
 <20201209145702.GA2657@paulmck-ThinkPad-P72>
 <20201209175306.GC25719@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209175306.GC25719@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 09, 2020 at 05:53:06PM +0000, Christoph Hellwig wrote:
> On Wed, Dec 09, 2020 at 06:57:02AM -0800, Paul E. McKenney wrote:
> > On Wed, Dec 09, 2020 at 08:17:10AM +0000, Christoph Hellwig wrote:
> > > Your two new exports don't actually seem to get used in modular code
> > > at all in this series.
> > 
> > Indeed, and I either need to remove the exports or make my test code in
> > kernel/rcu/rcuscale.o suitable for upstreaming.  Or find the appropriate
> > mm/slab selftest location.
> 
> I'd rather not export something like this which pokes deep into
> internals.  That being said I've been working on off on a
> EXPORT_SYMBOL_FOR() that just exports a symbol to one specific module.
> Hopefully I'll finish it for the next merge window, and with that
> I'd feel much more comfortable with an export.

That would be really useful!  I have a number of symbols that should
only be used by a few specific in-tree modules, independent of this
patch series.

For my part, I will see if there is a good mm-related location for this
sort of selftest.

							Thanx, Paul
