Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8A8C433FE
	for <rcu@archiver.kernel.org>; Fri, 11 Dec 2020 15:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088F82246B
	for <rcu@archiver.kernel.org>; Fri, 11 Dec 2020 15:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395159AbgLKOiB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 11 Dec 2020 09:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390748AbgLKOht (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 11 Dec 2020 09:37:49 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DEFC0613D3
        for <rcu@vger.kernel.org>; Fri, 11 Dec 2020 06:37:05 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id p5so8964755iln.8
        for <rcu@vger.kernel.org>; Fri, 11 Dec 2020 06:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJlHhFY7YpGSb/NWgpsHkRiym//oc/n7oGp6xC0++YI=;
        b=ATt6n2xzRSCOBPYNJqnfDPSM1w4dkDEyGpz0yU3WQaPHQ36ZuuiOgYy+6B1QSHYSMy
         RN7ABuPhtbt6d2A28l20fAe+to7TJeiI62SH0imBVhoY6/MENzMuX0Dmyp4vL3LujZa3
         vreiQVmlFgK9/2Iefib9XM/v4uGWXKeihehkvxaNkRk54q6j8LtDeTrmgbn6hF1m7UfW
         pKE8uexzTVU4NHqlD4os1Okz57gjFQGeDZ/R11DDvOAvPiHbGUooxzCWzAzt1dkzOeV5
         2O8FsY8bUvj6xKhoUc5t/Gloa4oepDTfkGsn9ko+8eJ6r/Zfxx4sVfrBP24K5SKHxFcj
         z1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJlHhFY7YpGSb/NWgpsHkRiym//oc/n7oGp6xC0++YI=;
        b=MksCbOZ3nmZqBDhXaJmVHL9+LA7jW39wXiDfzF0GqYhHuJwYcWbCSIeq9WBeQ993Sy
         c1hSOg0IBc/xJq6WbT1wG/nNKzuxgX+EMR3h2ZPwmpa0jcwo07Fu0hEOnEN9C3qSgXMv
         DxCG++w8h725Q5wPwM8OYbyyTNoYFVRb593Qio87+gRRhvpl2g5GiAJnxXswdjbPdofK
         VLJGDkhUouX3kJ39kNbsy8xK4/1SYz23snxHBPdhM2wlF/P3hM9Epf1nc2p0X/2JI09a
         7l0gCxv0/hzDbY/QSmrFY1Jt6XcgfDgTRAUUcZSktu9gjLlxNdiVrJaY8X8Pc8IoSKDB
         2lFg==
X-Gm-Message-State: AOAM530nEWsH3+qIWsUK872n/NzRVElOP6UuYvkjOpPPgGJrBqNaTC1Q
        ekH8inkO5HfE2Xvl3KBw/d3EDLi9tSu458SH4ZepGg==
X-Google-Smtp-Source: ABdhPJx4GDSLnE6X++8HaLygIbU7GOWkPLUEzAx6L7q7vDvDs7fa7NOTg9AzBA5eFeY1//1BiEyEqUEd2Wv5v7CuQYY=
X-Received: by 2002:a92:d0ca:: with SMTP id y10mr16813330ila.68.1607697424987;
 Fri, 11 Dec 2020 06:37:04 -0800 (PST)
MIME-Version: 1.0
References: <20201211112405.31158-1-sjpark@amazon.com>
In-Reply-To: <20201211112405.31158-1-sjpark@amazon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 11 Dec 2020 15:36:53 +0100
Message-ID: <CANn89iKGU6_OusKfXeoT0hQN2kto2RF_RpL3GNBeB54iqvqvXw@mail.gmail.com>
Subject: Re: [PATCH v4] net/ipv4/inet_fragment: Batch fqdir destroy works
To:     SeongJae Park <sjpark@amazon.com>
Cc:     David Miller <davem@davemloft.net>,
        SeongJae Park <sjpark@amazon.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Florian Westphal <fw@strlen.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        netdev <netdev@vger.kernel.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Dec 11, 2020 at 12:24 PM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> On a few of our systems, I found frequent 'unshare(CLONE_NEWNET)' calls
> make the number of active slab objects including 'sock_inode_cache' type
> rapidly and continuously increase.  As a result, memory pressure occurs.
>

> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Jakub or David might change the patch title, no need to resend.

Thanks for this nice improvement.
