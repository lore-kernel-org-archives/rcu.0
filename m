Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1A5C3DA7A
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 08:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjAEIFC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Jan 2023 03:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjAEIFA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Jan 2023 03:05:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5838F4435A;
        Thu,  5 Jan 2023 00:04:59 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672905896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LBxY4x0lJECD3Q95isd05EdO7m7NX7/uYbQPzo0bI20=;
        b=0Dgu5ClJpyieIj/9iUZxjMDW8ZJTVlPIqbiIIB5fG5R3kHFQJnrurr6kHDTZKle0oJL0mg
        OTnCbmLG2qKdm7+hbkk/BIx0Y50Dq4JG3csa8Nik4hZa6FeOo6qAqLHaSdW6/BnNvw9iTB
        CWTnysWkJEwhnHHQLTG1ktMai44ctieGiIS5zW84DV4Pcth2sHqKl2e9T/bq1BmXmh9xlZ
        6CIBvV48TZrGH1/SZ5gO8z/+5gkMVszNFqXVDZ6qv7fX1Om9rCbOC/FUTN1WaDCj6L2rfb
        BQG8vZWhbsFxj2OAbrG8ePSgISnOFnzk8dcQ67WBDLGgOjP5vW1R67k0V7QLeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672905896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LBxY4x0lJECD3Q95isd05EdO7m7NX7/uYbQPzo0bI20=;
        b=tsKbdvhJYyQ43xpUDWVbw6FN9BbvrqYVO/pzQdu+9Tvot04pDwEtjq7LEPHq8nmTcmf1Uk
        p3rew6Rk5+ddrUDQ==
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH rcu 27/27] rcu: Remove CONFIG_SRCU
In-Reply-To: <20230105003813.1770367-27-paulmck@kernel.org>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-27-paulmck@kernel.org>
Date:   Thu, 05 Jan 2023 09:10:16 +0106
Message-ID: <87r0w9csqn.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2023-01-04, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> Now that all references to CONFIG_SRCU have been removed, it is time to
> remove CONFIG_SRCU itself.

I think "all references" is a bit misleading since there still are
several places in the kernel code that use it:

$ git grep CONFIG_SRCU
drivers/base/core.c:#ifdef CONFIG_SRCU
drivers/base/core.c:#else /* !CONFIG_SRCU */
drivers/base/core.c:#endif /* !CONFIG_SRCU */
fs/locks.c:#if IS_ENABLED(CONFIG_SRCU)
fs/locks.c:#else /* !IS_ENABLED(CONFIG_SRCU) */
fs/locks.c:#endif /* IS_ENABLED(CONFIG_SRCU) */
kernel/notifier.c:#ifdef CONFIG_SRCU
kernel/notifier.c:#endif /* CONFIG_SRCU */

Should those be removed before this patch?

John Ogness
