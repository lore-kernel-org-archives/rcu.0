Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D759AC3DA7D
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 16:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjAEQBu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Jan 2023 11:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbjAEQBt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Jan 2023 11:01:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268291B9ED;
        Thu,  5 Jan 2023 08:01:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE524B81B31;
        Thu,  5 Jan 2023 16:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86758C433D2;
        Thu,  5 Jan 2023 16:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672934505;
        bh=dqzzCpQpScLvEkchsLcOAdymPX5QNqFLx6G6sOzZM0E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iAjbkeOPjmzPX0/bDAcJh89SdWtd5/OYBg5UtkPeh+3O/1tp6k7Y8PYWBKhwTsTM7
         FcOtSvPBc3PTGeSV+DkgGQWozm1oPe3uopd2xHemSmXYqvaFYs89cIMg/V+uwBhdbE
         MgsnzC12O0lffUMceqc16NGSKFGxa9lfDe0P4h2ss9xZw0hYnjFYHl3k+/3KDrhCUZ
         pxlioZV44gCHF69SLBprLPALSrkTrOgGI2o3uioQ8C7sJXkSF/WoDifQAxRlFJiH4y
         B8xkxG8d1llk8BnWLKkgVCQZgT/IcALR06cQw3CSKPeyW2BV8u9PwkMslhxPxM/Svu
         MZVe+OeHPqIHA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 21BF95C029A; Thu,  5 Jan 2023 08:01:45 -0800 (PST)
Date:   Thu, 5 Jan 2023 08:01:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org
Subject: Re: (subset) [PATCH rcu 0/27] Unconditionally enable SRCU
Message-ID: <20230105160145.GY4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <167293383749.9409.12809142428621928168.b4-ty@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167293383749.9409.12809142428621928168.b4-ty@kernel.dk>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 05, 2023 at 08:50:37AM -0700, Jens Axboe wrote:
> 
> On Wed, 04 Jan 2023 16:37:59 -0800, Paul E. McKenney wrote:
> > This series removes Kconfig "select" clauses and #ifdef directives that
> > are no longer necessary give that SRCU is now unconditionally enabled,
> > courtesy of new-age printk() requirements.  Finally, the SRCU Kconfig
> > option is removed entirely.
> > 
> > 1.	arch/x86: Remove "select SRCU".
> > 
> > [...]
> 
> Applied, thanks!
> 
> [07/27] block: Remove "select SRCU"
>         commit: b2b50d572135c5c6e10c2ff79cd828d5a8141ef6

Thank you, Jens!  I will drop this one on my next rebase.

							Thanx, Paul
