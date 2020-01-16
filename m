Return-Path: <SRS0=/SR9=3F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47361C33CB1
	for <rcu@archiver.kernel.org>; Thu, 16 Jan 2020 13:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D2D2077C
	for <rcu@archiver.kernel.org>; Thu, 16 Jan 2020 13:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgAPNbR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:31:17 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38646 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgAPNbR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Jan 2020 08:31:17 -0500
Received: from localhost (82-95-191-104.ip.xs4all.nl [82.95.191.104])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5922915B6A351;
        Thu, 16 Jan 2020 05:31:14 -0800 (PST)
Date:   Thu, 16 Jan 2020 05:31:07 -0800 (PST)
Message-Id: <20200116.053107.2118682332070479073.davem@davemloft.net>
To:     madhuparnabhowmik04@gmail.com
Cc:     gregkh@linuxfoundation.org, paulmck@kernel.org,
        joel@joelfernandes.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        frextrite@gmail.com
Subject: Re: [PATCH] net: wan: lapbether.c: Use built-in RCU list checking
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200115114101.13068-1-madhuparnabhowmik04@gmail.com>
References: <20200115114101.13068-1-madhuparnabhowmik04@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 16 Jan 2020 05:31:16 -0800 (PST)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: madhuparnabhowmik04@gmail.com
Date: Wed, 15 Jan 2020 17:11:01 +0530

> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> The only callers of the function lapbeth_get_x25_dev()
> are lapbeth_rcv() and lapbeth_device_event().
> 
> lapbeth_rcv() uses rcu_read_lock() whereas lapbeth_device_event()
> is called with RTNL held (As mentioned in the comments).
> 
> Therefore, pass lockdep_rtnl_is_held() as cond argument in
> list_for_each_entry_rcu();
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

Applied.
