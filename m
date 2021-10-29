Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA278C433F5
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 20:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55306101E
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 20:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhJ2U2T (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhJ2U2S (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 Oct 2021 16:28:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF71660E76;
        Fri, 29 Oct 2021 20:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635539149;
        bh=STlM7O3Rk5eiSPghOKcQ5f7XOTS8/G0fi20ETv2vLYI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=REvZzcDTleLgyrhcYt7077KtySPOlkhJC6Hk/bcQBdPTA2GmRVmR5hkp5wPbhzwWW
         o+p5mr43WokccCAygXxoFjLAhrCcofna48lcU5VyMb2qYZ1+/nRA5mf6U7ItjLIds0
         8kjxKndiz2rMaGbTigUi2PDyIeWZcB2ghIb/PqZUwiqNq3BlsENVMLSYyx5x8Is7Wy
         Z0ltjMr29FXJqKT4Ku/gAaPXTMDseACmCK2VUfKpM9CW68Jc9gDpCVVNgh8A0vaHsK
         Deqws9G442tGGmkh8rvkJLGlfcagVHoaIpDojAjh7do0aQMCcP5HLF24Jt1JKgMsRT
         x9OMTVjO1cR+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 27A1E5C051B; Fri, 29 Oct 2021 13:25:48 -0700 (PDT)
Date:   Fri, 29 Oct 2021 13:25:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Akira Yokosawa <akiyks@gmail.com>, neilb@suse.de, corbet@lwn.net,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Add refcount analogy to What is RCU
Message-ID: <20211029202548.GU880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211028190336.GI880162@paulmck-ThinkPad-P17-Gen-1>
 <ac66a5f3-da2a-db13-1e6f-d498108dab95@gmail.com>
 <20211029145657.GR880162@paulmck-ThinkPad-P17-Gen-1>
 <YXwR7M6DEgUCe0JL@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXwR7M6DEgUCe0JL@casper.infradead.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 29, 2021 at 04:23:24PM +0100, Matthew Wilcox wrote:
> On Fri, Oct 29, 2021 at 07:56:57AM -0700, Paul E. McKenney wrote:
> > > > -:ref:`7.	FULL LIST OF RCU APIs <7_whatisRCU>`
> > > > +:ref:`7.	ANALOGY WITH REFERENCE COUNTING <7_whatisRCU>'                                                             `  (:ref:`...`)
> > 
> > I confess .rst confusion.  I am not sure what this string is supposed
> > to replace nor what the "..." is supposed to be.  So could you please
> > send me a fixup patch for this change so that I can squash that patch
> > into Neil's original?
> 
> The trailing ' needs to be a `, like every other line in this section.

Got it, thank you both!  I will fix this locally.

							Thanx, Paul
