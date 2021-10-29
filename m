Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007E3C433F5
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 15:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D262A60187
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 15:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhJ2P12 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 Oct 2021 11:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJ2P12 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 Oct 2021 11:27:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D4CC061570;
        Fri, 29 Oct 2021 08:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oXBMTf176qxUC8dBa4fkpUcLNbUNxA3GgrBwpCjXHoY=; b=fAHNa7vVzGMrow5xnQYLjbfBMD
        4zJGfVnb3o3KIe3wf9FK7H66MCObf4IJ/ncmQp8VtkurbpplClyFrhwbi1UhxGWSlXHBZVQwUpuEl
        MhsuTdVSDsDrlyhXGUZST0eilVkmYChyi2M4LOUiZ5P2rQco15MLAaXJ/TlkvIwLJwxbfooOmDVLc
        q5VC5G1CegaF1mMQ4f+ulHNPK5mzmbZCdHoRX9qxeJh2VYs8ZuYXKi7ClhGC/F0qxK1Tvb+1z/lZ7
        EI3AXDUo/JsNkTvLE34MMphPaB/FDD7+3UiM9hC7iIFM16hCjNE0fsbbm85k9zzzfIVMYH/lNSREq
        /kuYISug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgTj2-001jhk-QV; Fri, 29 Oct 2021 15:23:37 +0000
Date:   Fri, 29 Oct 2021 16:23:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Akira Yokosawa <akiyks@gmail.com>, neilb@suse.de, corbet@lwn.net,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Add refcount analogy to What is RCU
Message-ID: <YXwR7M6DEgUCe0JL@casper.infradead.org>
References: <20211028190336.GI880162@paulmck-ThinkPad-P17-Gen-1>
 <ac66a5f3-da2a-db13-1e6f-d498108dab95@gmail.com>
 <20211029145657.GR880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029145657.GR880162@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 29, 2021 at 07:56:57AM -0700, Paul E. McKenney wrote:
> > > -:ref:`7.	FULL LIST OF RCU APIs <7_whatisRCU>`
> > > +:ref:`7.	ANALOGY WITH REFERENCE COUNTING <7_whatisRCU>'                                                             `  (:ref:`...`)
> 
> I confess .rst confusion.  I am not sure what this string is supposed
> to replace nor what the "..." is supposed to be.  So could you please
> send me a fixup patch for this change so that I can squash that patch
> into Neil's original?

The trailing ' needs to be a `, like every other line in this section.

