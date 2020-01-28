Return-Path: <SRS0=RZVH=3R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24076C33CB3
	for <rcu@archiver.kernel.org>; Tue, 28 Jan 2020 09:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE626207FD
	for <rcu@archiver.kernel.org>; Tue, 28 Jan 2020 09:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgA1JE1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:04:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51436 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgA1JE1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 28 Jan 2020 04:04:27 -0500
Received: from ip5f5bd665.dynamic.kabel-deutschland.de ([95.91.214.101] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iwMnD-0007sp-Q3; Tue, 28 Jan 2020 09:04:19 +0000
Date:   Tue, 28 Jan 2020 10:04:19 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     madhuparnabhowmik10@gmail.com
Cc:     oleg@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        paulmck@kernel.org, joel@joelfernandes.org, frextrite@gmail.com,
        rcu@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] fork.c: Use RCU_INIT_POINTER() instead of
 rcu_access_pointer()
Message-ID: <20200128090419.4gvyfggzg4ohb42t@wittgenstein>
References: <20200127175821.10833-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200127175821.10833-1-madhuparnabhowmik10@gmail.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jan 27, 2020 at 11:28:21PM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> Use RCU_INIT_POINTER() instead of rcu_access_pointer() in
> copy_sighand().
> 
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
