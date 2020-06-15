Return-Path: <SRS0=TgV7=74=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AEBC433DF
	for <rcu@archiver.kernel.org>; Mon, 15 Jun 2020 20:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C7FD207D3
	for <rcu@archiver.kernel.org>; Mon, 15 Jun 2020 20:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592253570;
	bh=2+d8H2ywb+0qKARzrvVBm2CI7cwKXvv7iW6tH0Dy0JM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=E2jEAB6DVyzjo8mKaUT6OMGbRwJriBj1v7f2o2LH+NW5KGnV+PIbrkKzftgR3s7+R
	 CRIJ2t2SdqMD6TB5A6ksMS3hDab1Qk31NeYq4CJRkW8XEyO2r6/5yBTjqr6sXmPOAB
	 Pf6gOu7TtW3XyZ8eonoQYLYUAV+V/IbXlSSTnZC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbgFOUja (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730943AbgFOUj3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 15 Jun 2020 16:39:29 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B7562078E;
        Mon, 15 Jun 2020 20:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592253569;
        bh=2+d8H2ywb+0qKARzrvVBm2CI7cwKXvv7iW6tH0Dy0JM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0sgqzxpn+vbStGQyYcnJfrRm07ezVEf7CHxezj6jvDiFVYSiGLjHzA3rTTeqDM2w6
         90XAl3nXJ2OH30d6vZS9clyMLqro2D8fdnL145Lq0ZP7IJyZuend/Finhepf0yGIuA
         jHIPFIWROHDiV7ZziaxaGdL9kSJtC6RkHLlgkqOA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 853D235218F0; Mon, 15 Jun 2020 13:39:29 -0700 (PDT)
Date:   Mon, 15 Jun 2020 13:39:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, rcu@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] <linux/rculist.h>: fix kernel-doc notation & warning
Message-ID: <20200615203929.GQ2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <477ac099-e272-b873-fccf-c68c5b729fe9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <477ac099-e272-b873-fccf-c68c5b729fe9@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Jun 14, 2020 at 08:45:07PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix a kernel-doc warning due to missing a beginning '*' on the
> comment line.
> 
> ../include/linux/rculist.h:515: warning: bad line:                           [@right ][node2 ... ]
> 
> Fixes: 35fc0e3b0bd5 ("rculist: Add hlists_swap_heads_rcu")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: rcu@vger.kernel.org

Good eyes, but I took Mauro's similar patch.

							Thanx, Paul

> ---
>  include/linux/rculist.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-58-rc1.orig/include/linux/rculist.h
> +++ lnx-58-rc1/include/linux/rculist.h
> @@ -512,7 +512,7 @@ static inline void hlist_replace_rcu(str
>   * @right: The hlist head on the right
>   *
>   * The lists start out as [@left  ][node1 ... ] and
> -                          [@right ][node2 ... ]
> + *                        [@right ][node2 ... ]
>   * The lists end up as    [@left  ][node2 ... ]
>   *                        [@right ][node1 ... ]
>   */
> 
