Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C777C3DA7D
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 15:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjAEPqE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Jan 2023 10:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjAEPqC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Jan 2023 10:46:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AC410BB;
        Thu,  5 Jan 2023 07:46:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C9DEB81B22;
        Thu,  5 Jan 2023 15:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E65C433D2;
        Thu,  5 Jan 2023 15:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672933558;
        bh=jOgKAbukbrjdYiUUmVYlAD25dxO8wgbG9gGqqgI0av4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qSiDOAWv1/A3nr7wJuhdGMInKqir0Z2ZdM5Z9IhITI3s73KtWJ7M2GgUZdqdLRbw2
         +ND7WcOyNHgIaLzCXSa0CB53rQeLggtabKelMBgaxf1t1KK6m+uRetQ7LT9PdIbTBQ
         hpB2FaakyO+X6PvIKMLKQm1jwgeL+68NwIAPNJFGfxFTN+8Q2E3BdJH+ooHj6E2oW7
         7tAndcn61xjD1cyV/4gEH+7D0+bhqak2exlWaLI9J+veX8Fv3A3v9TeJE4LrqoH8dY
         S+zjC2XaW0HkHToMP8QuYWwz68nMZG+Y9eJ8P8Ejg01lad1x/76t/aClv0WRPFSZmV
         QGaE31oqTSwJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7F9115C029A; Thu,  5 Jan 2023 07:45:58 -0800 (PST)
Date:   Thu, 5 Jan 2023 07:45:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH rcu 21/27] fs/quota: Remove "select SRCU"
Message-ID: <20230105154558.GV4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-21-paulmck@kernel.org>
 <20230105113015.6f3ikdgmnhweoish@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105113015.6f3ikdgmnhweoish@quack3>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 05, 2023 at 12:30:15PM +0100, Jan Kara wrote:
> On Wed 04-01-23 16:38:07, Paul E. McKenney wrote:
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > Kconfig statements.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Jan Kara <jack@suse.com>
> > ---
> >  fs/quota/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> 
> Sure. You can add:
> 
> Acked-by: Jan Kara <jack@suse.cz>

Thank you, Jan!  I will apply both on my next rebase.

> 								Honza
> 
> > 
> > diff --git a/fs/quota/Kconfig b/fs/quota/Kconfig
> > index b59cd172b5f97..d5a85a8062d05 100644
> > --- a/fs/quota/Kconfig
> > +++ b/fs/quota/Kconfig
> > @@ -6,7 +6,6 @@
> >  config QUOTA
> >  	bool "Quota support"
> >  	select QUOTACTL
> > -	select SRCU
> >  	help
> >  	  If you say Y here, you will be able to set per user limits for disk
> >  	  usage (also called disk quotas). Currently, it works for the
> > -- 
> > 2.31.1.189.g2e36527f23
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
