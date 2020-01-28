Return-Path: <SRS0=RZVH=3R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CB9C2D0DB
	for <rcu@archiver.kernel.org>; Tue, 28 Jan 2020 18:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DA52173E
	for <rcu@archiver.kernel.org>; Tue, 28 Jan 2020 18:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgA1SBd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:01:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34845 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1SBd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 28 Jan 2020 13:01:33 -0500
Received: from ip5f5bd665.dynamic.kabel-deutschland.de ([95.91.214.101] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iwVB2-00023P-Og; Tue, 28 Jan 2020 18:01:28 +0000
Date:   Tue, 28 Jan 2020 19:01:28 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     madhuparnabhowmik10@gmail.com
Cc:     peterz@infradead.org, mingo@kernel.org, oleg@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org, rcu@vger.kernel.org
Subject: Re: [PATCH] exit.c: Fix Sparse errors and warnings
Message-ID: <20200128180128.lxx5cis2d74wolnc@wittgenstein>
References: <20200128172008.22665-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200128172008.22665-1-madhuparnabhowmik10@gmail.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 28, 2020 at 10:50:08PM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> This patch fixes the following sparse error:
> kernel/exit.c:627:25: error: incompatible types in comparison expression
> caused due to accessing rcu protected pointer without using rcu primitives.
> 
> And the following warning:
> 
> kernel/exit.c:626:40: warning: incorrect type in assignment
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Thanks, looks good to me!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
