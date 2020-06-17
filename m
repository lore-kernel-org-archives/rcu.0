Return-Path: <SRS0=aJiN=76=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72001C433E0
	for <rcu@archiver.kernel.org>; Wed, 17 Jun 2020 04:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F9B20776
	for <rcu@archiver.kernel.org>; Wed, 17 Jun 2020 04:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592366777;
	bh=Oy3fB3QXCNvKlMuER779AVhdhvdtJnD3w0Ciw4/qba4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=iV06gLDTC8MpSkbB/LGmHOjw1J21NRSMPkTIXTi/fLvqu6l+/4XNemSbP6KWf7kHw
	 beWnRNLdNnoNYxCBicv77YCxTJ0IwmgLpZmKkw6DlNhB2SjxAX1lA5KgNuUeyLkkCw
	 +r5uR5IzhFNsh716nBU0up+JBFkGrTDaxqQiD5YA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbgFQEGQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Jun 2020 00:06:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgFQEGP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Jun 2020 00:06:15 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 170B120870;
        Wed, 17 Jun 2020 04:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592366775;
        bh=Oy3fB3QXCNvKlMuER779AVhdhvdtJnD3w0Ciw4/qba4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dM8DKor+3VFdk6W/JZErwj+A0rds1hZXtJXXuOVgfnucZVS91zIJBP8Jx6gojiIkK
         wGeZ4Wv0SYYzLpRqMAUUpvcKSE/v0NLw25djA5X2rHfyBhj8kylpj3Wmd/yvwXCvdg
         xb9mntCyPrrThG5mgcV7neZun7yUpKL5SWBfZrKs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ED5E235228E8; Tue, 16 Jun 2020 21:06:14 -0700 (PDT)
Date:   Tue, 16 Jun 2020 21:06:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>
Subject: Re: CPU trying to start a GP when no CBs were assigned new GP numbers
Message-ID: <20200617040614.GI2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAEXW_YTdapsuKbZz=oAGKEnaXW=VJHTnGuy1qymy-du8mmKNjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTdapsuKbZz=oAGKEnaXW=VJHTnGuy1qymy-du8mmKNjA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 16, 2020 at 08:24:37PM -0400, Joel Fernandes wrote:
> Hi,
> I am seeing something a bit strange with RCU where it is trying to
> start a GP twice from a CPU even though no new CB was queued on that
> CPU. It is quite possible that I'm missing something. Anyway, I wrote
> a patch to add some tracing when CBs are queued into the segcb. I am
> planning to post this trace patch later.
> 
> The trace in the link below shows CPU2 queuing around 5 CBs, which
> then gets accelerated at 5.192123. The GP thread running on CPU3
> starts a new GP. Now the CPU2 softirq runs again (roughly 1ms after
> the previous acceleration). The softirq runs probably because the GP
> thread is expecting a QS report from CPU 2.  When the CPU2's softirq
> runs though, it does an acceleration again which triggers a second new
> GP start. This seems a bit unnecessary AFAICS - because the need for
> GP *832 was already recorded which is all CPU2 should really be caring
> about right?
> 
> Here is the trace: https://pastebin.com/raw/AYGzu1g4

Assuming that the WAIT= and NEXT_READY= numbers are grace-period numbers,
this trace is expected behavior for two sets of callbacks, one that
arrived at CPU 2 by time 5.192121 and another that arrived between then
and time 5.193131.

So I have to ask...  What tells you that no callbacks arrived at CPU 2
during this interval?

On the other hand, if CPU 2 is offloaded, what you might be seeing is
the delayed drain of callbacks from the bypass.

							Thanx, Paul
