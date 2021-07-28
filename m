Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0054C4338F
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 20:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFCCE60F9B
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 20:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhG1Uh2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jul 2021 16:37:28 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:59393 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231126AbhG1Uh1 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 28 Jul 2021 16:37:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id E37912B011CF;
        Wed, 28 Jul 2021 16:37:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 28 Jul 2021 16:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=fm1; bh=S2P
        Y/gCouDsnhtUs0tus40I2EUyvx7oxWdFXqNb0GiY=; b=cxOaSAQGypolDmil1LN
        LNLJvZGseVYVizr8wghHvKh2+yXEYqcxDKTCZZSuBMkMAgWMQOjawQ+0nADZMLbm
        U+BA0BwU7Vo4XB5ZEhEGvtfkUsW24RNUmu+pw3DTo8oC1PW3yY7Q2Gbk5ox/rSUN
        iOVE9Qhu0UTEcDshVsiJqJgN87bbgeqc7kR0YECL8dAMgqeVARqKtiNZLHl9oshb
        AW9/6kg3j+SJaFxHS5J5gWf5C0ANHVIOOcvjnO0OR023O1f7AQPs/g63MOKqD5r2
        kYMsj1KeWc/GpkwS9gSFkGx5MJXGIhPf343+mxrX6kBf8OF2Mhgr3FrSkSUUHL5j
        75w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=S2PY/g
        CouDsnhtUs0tus40I2EUyvx7oxWdFXqNb0GiY=; b=A1o3esHeZKs+bKdjblmwPS
        ShVrlK5G8j/09UyQ5dt6pt1M5Vf1Xs4G6ehmba6X9XSSUdvP/y6+QZfLe5Z9TghM
        tHBhMD4qvdzlC4beQl+JTbDdDY8tNCQCfN0q5K95CXDFL9EDD29P93MQ4lcuZOqK
        ikUQNSNlDBg1I4HOe/b39LL3rGE++Nfb3/N6B8Tmb3YXqM7wbP+mfHK9ysM9dUEm
        JVRN/Nr4lA2uS7cmO80j5kdKzMxC9hGHXtcgrFjXxX+m/LpRsqkE7R3HPo8o7Rry
        gS1osYTpJ7vAO4LR8LJP3Y2imckOY3d3f/omFpD/IqXTvXn6aoKiIwtElunjaWkA
        ==
X-ME-Sender: <xms:AsABYRzBg7Bqraya8UyWCuNGPqCB17j_wP6NqtNZU5UMb7URM-XD5w>
    <xme:AsABYRR9Xh39Kne-LzyD6itHfdT62m2Bhx38vO-RECptA25GQ2y092PeA_Pt3OhXx
    Nl4GFmoR3e6huZ-5gE>
X-ME-Received: <xmr:AsABYbWRawO8zYRxCySsjZnsb68r2L2d2wH89ioK05dQMzyNxecjm9sr4K8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeelgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflohhshhcu
    vfhrihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgedtgfefgefhveeglefgfeeigeduueehkeektdeuueetgfehffev
    geeuieetheetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgh
X-ME-Proxy: <xmx:AsABYTgUdafyJniZ2VvXxPckDWmqbueE1booZM9baeEFybc88CcZHQ>
    <xmx:AsABYTCw5-xAceqcSduLBt6zZLtV5lKZTOQWLHlSFmXxtPEO3YcTzg>
    <xmx:AsABYcLAF5TQyxvHGbHNsfDndNa6xbGOqRI98JrWmYKUdV5BHh9dxg>
    <xmx:A8ABYVS6S37Qze8Ej66sKymIlWleB2YzncwEpJvx5uJoxv33od-xKG18lI1R5jam>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jul 2021 16:37:20 -0400 (EDT)
Date:   Wed, 28 Jul 2021 13:37:19 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 rcu 04/18] rcu: Weaken ->dynticks accesses and updates
Message-ID: <YQG//899pPl2JIWw@localhost>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org>
 <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 28, 2021 at 10:37:15AM -0700, Paul E. McKenney wrote:
> This change makes the memory ordering requirements
> more evident, and it might well also speed up the to-idle and from-idle
> fastpaths on some architectures.

Cleaning up the memory ordering requirements certainly seems worthwhile.
But is there any straightforward benchmark that might quantify the
"might well also speed up" here? How much does weakening the memory
ordering buy us, in practice?
