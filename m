Return-Path: <SRS0=TgV7=74=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AD0C433DF
	for <rcu@archiver.kernel.org>; Mon, 15 Jun 2020 20:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D692078E
	for <rcu@archiver.kernel.org>; Mon, 15 Jun 2020 20:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592253372;
	bh=I69UtMEb9hSxBtRqEXCmiR68nJKs/Zsp2r5qsnWd/io=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=HCQfswhQUqyMYNpgER8FLbVyKVIb1uMY0RKTibT6O4dGhh8RJS9UjssKaa0UZhZgV
	 Ohg1z8n/TkBAeJElsU1kYP7+h3LeaMLikl8VUjpuUpeyXrFO0k+sKZgBmNPXkjqYUv
	 HrvYOYBBfAxjDtB2dYsNPPIXOYqg10EZFBsxzi1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbgFOUgM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgFOUgL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 15 Jun 2020 16:36:11 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2420E2074D;
        Mon, 15 Jun 2020 20:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592253371;
        bh=I69UtMEb9hSxBtRqEXCmiR68nJKs/Zsp2r5qsnWd/io=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ln324mEu4wMdAeE5Yr+D9tFmx9A74Tlp8XogEvQGRZru60SdYrKkO+xVIhbI8lzRj
         Qd9rsgX85WPHlJlBQTsH4aOithnVgJ7lexNQeOx04CIaYpEJvmrExiBOAdpJ79quaG
         8xhM1ac84ZGrv7wElI4xpIp9Trrwc+3WW9Ewq5VM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0689535218F0; Mon, 15 Jun 2020 13:36:11 -0700 (PDT)
Date:   Mon, 15 Jun 2020 13:36:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 10/29] rcu: fix some kernel-doc warnings
Message-ID: <20200615203610.GO2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
 <442c913556cba30f2f411e54efedcb97508f01a9.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442c913556cba30f2f411e54efedcb97508f01a9.1592203542.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jun 15, 2020 at 08:46:49AM +0200, Mauro Carvalho Chehab wrote:
> There are some kernel-doc warnings:
> 
> 	./kernel/rcu/tree.c:2915: warning: Function parameter or member 'count' not described in 'kfree_rcu_cpu'
> 	./include/linux/rculist.h:517: warning: bad line:                           [@right ][node2 ... ]
> 	./include/linux/rculist.h:2: WARNING: Unexpected indentation.
> 
> Move the comment for "count" to the kernel-doc markup and add
> a missing "*" on one kernel-doc continuation line.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Queued and pushed, thank you!

							Thanx, Paul

> ---
>  include/linux/rculist.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index df587d181844..7eed65b5f713 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -512,7 +512,7 @@ static inline void hlist_replace_rcu(struct hlist_node *old,
>   * @right: The hlist head on the right
>   *
>   * The lists start out as [@left  ][node1 ... ] and
> -                          [@right ][node2 ... ]
> + *                        [@right ][node2 ... ]
>   * The lists end up as    [@left  ][node2 ... ]
>   *                        [@right ][node1 ... ]
>   */
> -- 
> 2.26.2
> 
