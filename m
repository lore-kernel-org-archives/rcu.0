Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019C1C2BB48
	for <rcu@archiver.kernel.org>; Tue, 15 Dec 2020 20:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0B9922C7D
	for <rcu@archiver.kernel.org>; Tue, 15 Dec 2020 20:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgLOUsU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Dec 2020 15:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgLOUsL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Dec 2020 15:48:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA134C06179C
        for <rcu@vger.kernel.org>; Tue, 15 Dec 2020 12:47:30 -0800 (PST)
Date:   Tue, 15 Dec 2020 21:47:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608065249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UrR9ge5CHOlUN2madyX3mDtjeHz9enIXvBHiy3ILHqk=;
        b=OI145IVkmFIeymTa/xXjtRbRbuAVzsK/jqNyKxqJA+1FGUvkednPKqzaZFLE1Sn04xcFhs
        wW+WWZXsYQiPXxc05mN4HslkdxDgyTv+Xj8x2JNGPB9YDMKlrcL5BFUerOzaR8IhDV6V8p
        o50eyNQAzwsj6NmAgOa8iMpTM9thd3BinQZMze28m7M9fGW9Ck7c5dh7ePnwiLeCh/cNzK
        vs6qdi8mJPJQhjJO3hHEW60AGykxRfz7x11KIPRmrGuTjzskHd2+UqP2kMWI2nyJIQg2Yk
        9jBldaYG0upHavU0X8K6unU9CcDX5E9lTphvG6IixPbbTaEeb/1X23tkWG9qiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608065249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UrR9ge5CHOlUN2madyX3mDtjeHz9enIXvBHiy3ILHqk=;
        b=dSRXGBWxPNjJ0KVVuNYo6DwQfUWHddhX52aXdDL0xYCDVE9WzYvR8cGk+d1/uAX0BfSEBl
        YweWMBRvI5vUvrCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Scott Wood <swood@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/5] A few smaller RCU related patches from the RT tree
Message-ID: <20201215204727.3z4p7oodbpepgr6i@linutronix.de>
References: <20201215141649.796472-1-bigeasy@linutronix.de>
 <20201215180106.GC2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201215180106.GC2657@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-12-15 10:01:06 [-0800], Paul E. McKenney wrote:
> On Tue, Dec 15, 2020 at 03:16:44PM +0100, Sebastian Andrzej Siewior wrote:
> > Hi,
> >=20
> > I know the timming of this regarding the merge window is bad. I meant to
> > send them for days=E2=80=A6
>=20
> Not a problem!
>=20
> However, unless any of these are urgent, I plan to submit them not into
> this merge window, but rather into the v5.12 merge window.  (I don't
> see any of them being urgent, but I could well be missing something.)

perfect, thank you.

> I have done my usual wordsmithing, so if any of you see anything I messed
> up, please don't keep it a secret.

I'm going to backport them into my RT queue tomorrow and I promise not
keep a secret :)

> I also updated #2 and #3 to change kernel-parameters.txt accordingly.

Thank you.

> 							Thanx, Paul

Sebastian
