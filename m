Return-Path: <SRS0=efVp=7L=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052C3C433E0
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 14:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0EF207F5
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 14:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590760949;
	bh=jboWdieI7iFp1rpneZBaX90NHx5TQzh4MghY5RexMJE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=c0q5SYgPOcTxIdU8bfCPXnY2X+IDO4SdO/LfkN5S96pFneh6PPYkfy1wr2vT/jTgS
	 gE0Ksn8j9ZbD18KiTGL2bana8yr/fchAON4T5cx0vVtdZGVBVKpzDU9XHs/JCcgYdV
	 6f8nxldayILBFP+5JNLAR5T+xCJaXkz14LT6eEpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgE2OC3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 May 2020 10:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgE2OC3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 May 2020 10:02:29 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBBC620707;
        Fri, 29 May 2020 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590760949;
        bh=jboWdieI7iFp1rpneZBaX90NHx5TQzh4MghY5RexMJE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AwerKJm7rYuen+5zU+J2jkZzKnPY1dzfpRGir1cVzkNId9Cf5o1CZKeP95vv3++Gr
         rq02zr9oxYbVdIRUeWe7pkX7b5nmrv0dcj6RDgVFF/mqHAY0bYG8mGZghGpHlEPkJQ
         OTqMNjbeiZJ2PHNELZxMjVhzHO6AyfSmFUmUFhjM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C62183522683; Fri, 29 May 2020 07:02:28 -0700 (PDT)
Date:   Fri, 29 May 2020 07:02:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: next-20200528 - build error in kernel/rcu/refperf.c
Message-ID: <20200529140228.GZ2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <538911.1590725791@turing-police>
 <9d8b13db-9d77-416d-e283-9ea509ce43d1@infradead.org>
 <543040.1590729879@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <543040.1590729879@turing-police>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 29, 2020 at 01:24:39AM -0400, Valdis Klētnieks wrote:
> On Thu, 28 May 2020 21:48:18 -0700, Randy Dunlap said:
> 
> > > ERROR: modpost: "__aeabi_uldivmod" [kernel/rcu/refperf.ko] undefined!
> 
> Gaah.  And the reason I didn't spot Paul's post while grepping my linux-kernel
> mailbox is because *that* thread had a different undefined reference:
> 
> > > > > > > m68k-linux-ld: kernel/rcu/refperf.o: in function `main_func':
> > > > > > > >> refperf.c:(.text+0x762): undefined reference to `__umoddi3'
> 
> > Paul has already responded: (unfortunately)
> >
> > "So I am restricting to 64BIT for the time being.  Yeah, I know, lazy of
> > me.  ;-)"
> 
> It's the sort of issue that's well into "as long as it gets mostly fixed before
> it hits Linus's tree" territory.   I've seen lots of far worse work-arounds in
> the years since the 2.5.47 kernel. :)

Fair enough!

Also as noted on the other thread, in this case, doing this 64-bit
division the hard way shouldn't be a problem:  The performance test is
finished and nothing else is happening.  So I have to wonder whether it
would be possible to detect this based on some sort of link-time checking,
presumably in conjunction with -O0 to avoid confusing the whitelist with
compiler optimizations.

That would allow use of C-language "/" and "%" while still allowing
gratuitous uses to be questioned.

Hey, I can dream, can't I?  ;-)

							Thanx, Paul
