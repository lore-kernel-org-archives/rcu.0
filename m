Return-Path: <SRS0=u9Eq=6Y=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCCEC54E49
	for <rcu@archiver.kernel.org>; Sun, 10 May 2020 07:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C62208E4
	for <rcu@archiver.kernel.org>; Sun, 10 May 2020 07:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1sun/26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgEJHnE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 10 May 2020 03:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgEJHnE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 10 May 2020 03:43:04 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B944C061A0C;
        Sun, 10 May 2020 00:43:04 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k18so6240107ion.0;
        Sun, 10 May 2020 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4b22vTWVuMeumPN4GfshfpoKLGkiEUcdLNHqYwSvwM=;
        b=m1sun/26ORJ4HhCRIGZrKhsSerI4cNNDN0unEnjVHpkXqBvQnhWaQUtrg5vBny1qZ/
         mmliljcDrVcZSU2SRuAb4ff0bP1u057qx4YiGYd+c2q0wtfIGEMiFuo16VU73Te48ISt
         jkZMuOogr2P1CrmOn3rbbuXhg1/nbtLZnY0/S6VhOmNbl7WTGcqt30J3MbMWzKS6lCzY
         YQ2+EXeSBwnsTS4vhHEwI+7WNz4cSv5IIN/c9VNB4KZGR//QpBGf1MQjb2U9PaOx0/Iv
         CYVeZBN0OMgICird5o1QhlJqjcQjvbvhhWQutSNIAFI0ab5iXIN4nZSaQPAXeg1BjjMm
         1fGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4b22vTWVuMeumPN4GfshfpoKLGkiEUcdLNHqYwSvwM=;
        b=aERdEm+mnE6QSqyeVsu8JHJhCBPwssRRwijl217Atf9EHs/HbYYeyZHGbBcU+9d41u
         RLUajgyVIHf77wW52QrNeLJVxEJ81XmjySSuvTLFviNklxx7azL+P04alBnhBcGB+raB
         x1l2wzhnmdplD1a7qXr75P+g+sGKfmEIAeNYPuBB8NaST4LSEzRVcn+nsLXdCZmpWdwS
         Bz1ZYa5oYqa/7D0MGDJf2LxE/2BjmlZYiv2vAmaIASswtKX8Ex03Ck98VXvoNxy6m60Z
         qzjlXcHa7gO3isyDGxp9KIvdbiIM7yF9hAf7lfjJwqPKeS87/ttOX8UCkdttSVGp1WjY
         a52w==
X-Gm-Message-State: AGi0PuaJ873FLc99mCS6fnHLyPpXh/mkFCBhGBvY01vILpV4leiGG9+p
        4djFO3oe+Vkv5c3iFcDsqYWBU8uqVjGmhNomZ4o=
X-Google-Smtp-Source: APiQypLvV1pSP3VZtraTk96bREnC9Rgkd6XvEBMOQWXgnjrWhVPiIgKC/oFscsbpQf+marw66l1yF56pwsacdD9GNgM=
X-Received: by 2002:a05:6602:384:: with SMTP id f4mr9941211iov.207.1589096583604;
 Sun, 10 May 2020 00:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200415181856.GA11037@paulmck-ThinkPad-P72> <20200415181941.11653-5-paulmck@kernel.org>
In-Reply-To: <20200415181941.11653-5-paulmck@kernel.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Sun, 10 May 2020 15:42:52 +0800
Message-ID: <CAJhGHyArjzU9QeDkSH-L31ytzkWC9TT4uZ-gmA+gdmgvweagCQ@mail.gmail.com>
Subject: Re: [PATCH v4 tip/core/rcu 05/38] rcu-tasks: Move Tasks RCU to its
 own file
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        dipankar@in.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 2:19 AM <paulmck@kernel.org> wrote:
>
> From: "Paul E. McKenney" <paulmck@kernel.org>
>
> This code-movement-only commit is in preparation for adding an additional
> flavor of Tasks RCU, which relies on workqueues to detect grace periods.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  kernel/rcu/tasks.h  | 370 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  kernel/rcu/update.c | 366 +--------------------------------------------------

Hello Paul

Makes it kernel/rcu/tasks.c?

One of my old patch split it into a c-file, and it did work.
Is there anything new or planed that prevents it to be a c-file?

thanks
Lai

>
> +#include "tasks.h"
> +
>  #ifndef CONFIG_TINY_RCU
>
>  /*
> --
> 2.9.5
>
