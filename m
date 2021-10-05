Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFB0C433EF
	for <rcu@archiver.kernel.org>; Tue,  5 Oct 2021 16:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC5C61381
	for <rcu@archiver.kernel.org>; Tue,  5 Oct 2021 16:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhJEQtZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Oct 2021 12:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbhJEQtZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Oct 2021 12:49:25 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED36C061749
        for <rcu@vger.kernel.org>; Tue,  5 Oct 2021 09:47:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id r19so6053093lfe.10
        for <rcu@vger.kernel.org>; Tue, 05 Oct 2021 09:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eLZ4fUPrQrbt7FIi8eh6e+j83DwiHUC8faRiqF4uPzs=;
        b=Sx/egy7EF/hE71/yLc5iCclMS1KXr0PsI3iiyddcxXDm2B0Fxf8mgNzYhQ2YN7zBBO
         /4+9Kcm3Z11rJyATI53bYBVYHhIMcqzuKTHZLXoJBScRA6Yo3U68Qhd6c/SYBgRtmj6W
         xEbTJ6zX5RaesGntJeEEsVug181hbwk/vJhRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eLZ4fUPrQrbt7FIi8eh6e+j83DwiHUC8faRiqF4uPzs=;
        b=RSFzggOK37oxX/iihmaiC8fGC+NwsENyEpCJJY60zPB1bNy/OZhYvWYMV9+omBuANT
         zu7uQUmvhbYmfn9jg4xO9OgZZyYyBP9zym3IVku6jhJL3BeIEJ6OhSndtJb9FVYGLi8k
         eieKit4iNcshem//zpyEecYOwWzXuJ0oT77rfRrTWa85Wg9FbZEjbfbQZO7WhxZkFmC9
         1kb49wsp5+30eS2xqfOjOVZqDWxtm3bMTLIVo3jx56/wItO6Mf/M/Yhyc+Qpq3st+F2B
         KyQi2scueJY3naHYNkl0TO0JMuthB5Wzb7+yhrnjDlx+hsVBIsPVcR5hh30sJGwN4jsF
         nrpg==
X-Gm-Message-State: AOAM5316eMsaTLp10wF7BvDOOFttHGqn+WY/YRK0twdsV3SU8BMBpmTW
        FQpf6GsDlUJsJ0JhCEMGz2fPjw/z7Ov0Hfao
X-Google-Smtp-Source: ABdhPJzQw1215C9pi1ZhNFa/bztyK8LihV1YLsPCf22I6wAwBOfLak1YhidZP+Wa5dxothV0eTdO5w==
X-Received: by 2002:a05:6512:3502:: with SMTP id h2mr4525814lfs.415.1633452452379;
        Tue, 05 Oct 2021 09:47:32 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id i24sm1994744ljb.31.2021.10.05.09.47.32
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 09:47:32 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id n8so32179855lfk.6
        for <rcu@vger.kernel.org>; Tue, 05 Oct 2021 09:47:32 -0700 (PDT)
X-Received: by 2002:a05:6512:12c4:: with SMTP id p4mr4519659lfg.280.1633452446149;
 Tue, 05 Oct 2021 09:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211005094728.203ecef2@gandalf.local.home> <CAHk-=wj0AJAv9o2sW7ReCFRaD+TatSiLMYjK=FzG9-X=q5ZWwA@mail.gmail.com>
 <20211005123729.6adf304b@gandalf.local.home>
In-Reply-To: <20211005123729.6adf304b@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Oct 2021 09:47:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8duLUhR4duN2fNWRF73oGufZNMyvyF5Twp9FnqXmq+g@mail.gmail.com>
Message-ID: <CAHk-=wg8duLUhR4duN2fNWRF73oGufZNMyvyF5Twp9FnqXmq+g@mail.gmail.com>
Subject: Re: [RFC][PATCH] rcu: Use typeof(p) instead of typeof(*p) *
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, rcu <rcu@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 5, 2021 at 9:37 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Oh well, it was a fun exercise. Too bad we failed due to inconsistencies in
> compilers :-(

I'm admittedly surprised that something like this would be a
"different compiler versions" issue. But "typeof()" isn't exactly
standard C, so the fact that some version of gcc did something
slightly different is annoying but I guess not _that_ surprising.

Oh well indeed,

           Linus
