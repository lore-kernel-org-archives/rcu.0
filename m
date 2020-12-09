Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C78C433FE
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 23:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55AC5238EB
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 23:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgLIXRl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Dec 2020 18:17:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbgLIXRl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Dec 2020 18:17:41 -0500
Date:   Wed, 9 Dec 2020 15:16:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607555820;
        bh=ohmvuSKbrDJ5z2QP7Lxb/NjUrmQI5TqmzNvkB3SHFbE=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kyed3dZ9L8UEGFa9HnulMTDycEUR7XX0LBzT3zVgfX/0Xl29Mvo63Azn/ItGfnOkX
         DQfq2gv+diulkzqQuoa7uDz3iPnlauz/8+bZEznXgzuhTD6qjpeXf3PBe8Q5Mjz7Z0
         cz3HrtEJD6fWqqciCqpTA2u21tL8Desw2BrU7uR+LSErSemmuRhcpZjFyCwRBVkGaR
         JhyPoinhy5N7D4ZbhA8UIpcCbcc2FZsYjPZAlNOoksBHn5LDooTZ0GAOMZbidlAgzn
         rdn1ThLOGysAZszDNLKbW2PF0Fdg7L7CbiWF48RJ619Y/UxTgmvb97vexymYQ4tQYC
         rm/FtGRxjj4+g==
From:   Jakub Kicinski <kuba@kernel.org>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     <davem@davemloft.net>, SeongJae Park <sjpark@amazon.de>,
        <kuznet@ms2.inr.ac.ru>, <paulmck@kernel.org>,
        <netdev@vger.kernel.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] net/ipv4/inet_fragment: Batch fqdir destroy works
Message-ID: <20201209151659.125b43da@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <20201208094529.23266-2-sjpark@amazon.com>
References: <20201208094529.23266-1-sjpark@amazon.com>
        <20201208094529.23266-2-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 8 Dec 2020 10:45:29 +0100 SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> In 'fqdir_exit()', a work for destruction of the 'fqdir' is enqueued.
> The work function, 'fqdir_work_fn()', calls 'rcu_barrier()'.  In case of
> intensive 'fqdir_exit()' (e.g., frequent 'unshare(CLONE_NEWNET)'
> systemcalls), this increased contention could result in unacceptably
> high latency of 'rcu_barrier()'.  This commit avoids such contention by
> doing the destruction in batched manner, as similar to that of
> 'cleanup_net()'.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Looks fine to me, but you haven't CCed Florian or Eric who where the
last two people to touch this function. Please repost CCing them and
fixing the nit below, thanks!

>  static void fqdir_work_fn(struct work_struct *work)
>  {
> -	struct fqdir *fqdir = container_of(work, struct fqdir, destroy_work);
> -	struct inet_frags *f = fqdir->f;
> +	struct llist_node *kill_list;
> +	struct fqdir *fqdir;
> +	struct inet_frags *f;

nit: reorder fqdir and f to keep reverse xmas tree variable ordering.
