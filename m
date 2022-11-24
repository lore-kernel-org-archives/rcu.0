Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564D7C4321E
	for <rcu@archiver.kernel.org>; Thu, 24 Nov 2022 10:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiKXKTN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 24 Nov 2022 05:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiKXKS7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 24 Nov 2022 05:18:59 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBBA114B99
        for <rcu@vger.kernel.org>; Thu, 24 Nov 2022 02:18:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E56F81F749;
        Thu, 24 Nov 2022 10:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669285133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/jzW6pwbPXfSKtrbtJDjR4CYoBaw2nRwrQk9+q3B1HE=;
        b=FE6KqvkELLSp/Vd8+7BJMxPLn+l003jWfZc2A8MbdtDDg7FpVj5HdQiJfmvglxIAV/Y5Xj
        2h2nRzP7NK1RAxobaX4sCuaXgtQiR5Ta2pfv2Yee+cTdtjaDuYw5LF7VE9qMjBe9FsUQ5D
        Gr7o2r+EKoQmV9xbeWl7ThSxJBy013o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669285133;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/jzW6pwbPXfSKtrbtJDjR4CYoBaw2nRwrQk9+q3B1HE=;
        b=Z9Q863KBrUkA7eMyC2AxkeMmnhZ8mKidBy+ITsRF2/SVseqIsv35ag9+pkPfdq/wJS566A
        yB9HH/epq0lVc3Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7C1513488;
        Thu, 24 Nov 2022 10:18:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r3iiNA1Ff2NwPQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 24 Nov 2022 10:18:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 70657A070B; Thu, 24 Nov 2022 11:18:53 +0100 (CET)
Date:   Thu, 24 Nov 2022 11:18:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, rcu@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: SRCU use from different contexts
Message-ID: <20221124101853.aavgchwtwz5qt42q@quack3>
References: <20221123114645.3aowv3hw4hxqr2ed@quack3>
 <20221124002128.GN4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124002128.GN4001@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed 23-11-22 16:21:28, Paul E. McKenney wrote:
> On Wed, Nov 23, 2022 at 12:46:45PM +0100, Jan Kara wrote:
> > Hello!
> > 
> > We were pondering with Amir about some issues with fsnotify subsystem and
> > as a building block we would need a mechanism to make sure write(2) has
> > completed. For simplicity we could imagine it like a sequence
> > 
> > write(2)
> >   START
> >   do stuff to perform write
> >   END
> > 
> > and we need a mechanism to wait for all processes that already passed START
> > to reach END. Ideally without blocking new writes while we wait for the
> > pending ones. Now this seems like a good task for SRCU. We could do:
> > 
> > write(2)
> >   srcu_read_lock(&sb->s_write_rcu);
> >   do stuff to perform write
> >   srcu_read_unlock(&sb->s_write_rcu);
> > 
> > and use synchronize_srcu(&sb->s_write_rcu) for waiting.
> > 
> > But the trouble with writes is there are things like aio or io_uring where
> > the part with srcu_read_lock() happens from one task (the submitter) while
> > the part with srcu_read_unlock() happens from another context (usually worker
> > thread triggered by IRQ reporting that the HW has finished the IO).
> > 
> > Is there any chance to make SRCU work in a situation like this? It seems to
> > me in principle it should be possible to make this work but maybe there are
> > some implementation constraints I'm missing... 
> 
> The srcu_read_lock_notrace() and srcu_read_unlock_notrace() functions
> will work for this, though that is not their intended purpose.  Plus you
> might want to trace these functions, which, as their names indicate, is
> not permitted.  I assume that you do not intend to use these functions
> from NMI handlers, though that really could be accommodated.  (But why
> would you need that?)
> 
> So how about srcu_down_read() and srcu_up_read(), as shown in the
> (untested) patch below?

Great, that looks exactly like what we need! Thanks for the quick reply!

> Note that you do still need to pass the return value from srcu_down_read()
> into srcu_up_read().  I am guessing that io_uring has a convenient place
> that this value can be placed.  No idea about aio.

Sure, we know about the need to pass the return value but we can handle
that :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
