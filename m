Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E90C4332F
	for <rcu@archiver.kernel.org>; Thu, 24 Nov 2022 16:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKXQMk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 24 Nov 2022 11:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKXQMh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 24 Nov 2022 11:12:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C0243878
        for <rcu@vger.kernel.org>; Thu, 24 Nov 2022 08:12:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C969DB82847
        for <rcu@vger.kernel.org>; Thu, 24 Nov 2022 16:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88456C433C1;
        Thu, 24 Nov 2022 16:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669306350;
        bh=3+MI5oif+NBXXClhivJ7armMjdOaZB2npSLJpYBm89E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=P8eH1VmdmmE8khfOhTJ4BfkMgyOghyZudj2FmavqBjWtFhQa3T04yAWk17+R+3UiH
         F1VfVRglwodDuudKyMrru+kIhbQ1q6GA5ReByYYLO3b1o7phfWPG1L314ehRbm6DXL
         e2veZg0bcgkzDouzeOQEWQIs5HaHIjJTvFZK6ZW3LAdJTrYwzluHr1G8bEYD/CEUFs
         Yu4fCWAiinjpNXUa6ZXatJfvd2MpxSsXMSj1K2As8pE9xvQBhh62Va3d3LZSQB31M3
         HXuwdOBaoce8z9Umk9lCv++bIBhLsJewmJLXtMN/pVVKOM5yiC7uXxXbR+cqihTL3A
         w09jrVo2YQrOw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 302F05C094A; Thu, 24 Nov 2022 08:12:30 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:12:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: SRCU use from different contexts
Message-ID: <20221124161230.GR4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221123114645.3aowv3hw4hxqr2ed@quack3>
 <20221124002128.GN4001@paulmck-ThinkPad-P17-Gen-1>
 <20221124101853.aavgchwtwz5qt42q@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124101853.aavgchwtwz5qt42q@quack3>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 24, 2022 at 11:18:53AM +0100, Jan Kara wrote:
> On Wed 23-11-22 16:21:28, Paul E. McKenney wrote:
> > On Wed, Nov 23, 2022 at 12:46:45PM +0100, Jan Kara wrote:
> > > Hello!
> > > 
> > > We were pondering with Amir about some issues with fsnotify subsystem and
> > > as a building block we would need a mechanism to make sure write(2) has
> > > completed. For simplicity we could imagine it like a sequence
> > > 
> > > write(2)
> > >   START
> > >   do stuff to perform write
> > >   END
> > > 
> > > and we need a mechanism to wait for all processes that already passed START
> > > to reach END. Ideally without blocking new writes while we wait for the
> > > pending ones. Now this seems like a good task for SRCU. We could do:
> > > 
> > > write(2)
> > >   srcu_read_lock(&sb->s_write_rcu);
> > >   do stuff to perform write
> > >   srcu_read_unlock(&sb->s_write_rcu);
> > > 
> > > and use synchronize_srcu(&sb->s_write_rcu) for waiting.
> > > 
> > > But the trouble with writes is there are things like aio or io_uring where
> > > the part with srcu_read_lock() happens from one task (the submitter) while
> > > the part with srcu_read_unlock() happens from another context (usually worker
> > > thread triggered by IRQ reporting that the HW has finished the IO).
> > > 
> > > Is there any chance to make SRCU work in a situation like this? It seems to
> > > me in principle it should be possible to make this work but maybe there are
> > > some implementation constraints I'm missing... 
> > 
> > The srcu_read_lock_notrace() and srcu_read_unlock_notrace() functions
> > will work for this, though that is not their intended purpose.  Plus you
> > might want to trace these functions, which, as their names indicate, is
> > not permitted.  I assume that you do not intend to use these functions
> > from NMI handlers, though that really could be accommodated.  (But why
> > would you need that?)
> > 
> > So how about srcu_down_read() and srcu_up_read(), as shown in the
> > (untested) patch below?
> 
> Great, that looks exactly like what we need! Thanks for the quick reply!
> 
> > Note that you do still need to pass the return value from srcu_down_read()
> > into srcu_up_read().  I am guessing that io_uring has a convenient place
> > that this value can be placed.  No idea about aio.
> 
> Sure, we know about the need to pass the return value but we can handle
> that :)

Very good, and looking forward to seeing a Tested-by.  ;-)

							Thanx, Paul
