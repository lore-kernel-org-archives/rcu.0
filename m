Return-Path: <SRS0=LYSJ=3T=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220A5C33C9E
	for <rcu@archiver.kernel.org>; Thu, 30 Jan 2020 10:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ABA206D5
	for <rcu@archiver.kernel.org>; Thu, 30 Jan 2020 10:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgA3KcJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:32:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55694 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3KcJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Jan 2020 05:32:09 -0500
Received: from [89.27.154.14] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ix779-00009R-Gd; Thu, 30 Jan 2020 10:31:59 +0000
Date:   Thu, 30 Jan 2020 11:31:58 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     madhuparnabhowmik10@gmail.com
Cc:     peterz@infradead.org, mingo@kernel.org, oleg@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org, rcu@vger.kernel.org
Subject: Re: [PATCH] exit.c: Fix Sparse errors and warnings
Message-ID: <20200130103158.azxldyfnugwvv6vy@wittgenstein>
References: <20200130062028.4870-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200130062028.4870-1-madhuparnabhowmik10@gmail.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 30, 2020 at 11:50:28AM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> This patch fixes the following sparse error:
> kernel/exit.c:627:25: error: incompatible types in comparison expression
> 
> And the following warning:
> kernel/exit.c:626:40: warning: incorrect type in assignment
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

I think the previous version was already fine but hopefully
RCU_INIT_POINTER() really saves some overhead. In any case:

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
