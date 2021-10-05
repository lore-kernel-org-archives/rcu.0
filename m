Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746E8C4332F
	for <rcu@archiver.kernel.org>; Tue,  5 Oct 2021 16:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 619226138F
	for <rcu@archiver.kernel.org>; Tue,  5 Oct 2021 16:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhJEQUU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Oct 2021 12:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbhJEQUT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Oct 2021 12:20:19 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC566C061749
        for <rcu@vger.kernel.org>; Tue,  5 Oct 2021 09:18:28 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m3so87252327lfu.2
        for <rcu@vger.kernel.org>; Tue, 05 Oct 2021 09:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9pR87ZxffODNYHX3y8wIUUlOXsoFep7W3KkITUWQQdA=;
        b=TpNQeD0xD3/3W2Huts2s1yHnNDHO08/TvqGsxKknqz53fnCGeGEUqEVbfpYl1NdwF4
         xJpyZzE3P+DphdGWSaAERkfy6zE0yQxVQJzxFtwf2PG26X4bXpACjDTFkKxp99R+RSkM
         OtWyX3w8eTxmkzyy/0NhGAMfrer3tnjCwq++I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9pR87ZxffODNYHX3y8wIUUlOXsoFep7W3KkITUWQQdA=;
        b=HVOLhwKmWpyO9m+ylnxgJqoOqIoSah4cExv3ftkoGEd1ZJTLj4oLYbxWx4wUuLjMFm
         92PxZsUgkwXOS3FDjcExVW73B49BMA7Uu9jc7P5nwHfBEyjPPWQi80VEp1uxAuSXTrTD
         8BcYUGH/JRQ/ATL+fXYnt6QIDBep8iJXrZu/MqglYYqkcxLlT2fPEbR1D43Nmwu0aLqQ
         hzMP9mWJnRsYAabVruNVmLFTUvxMJd6AMnta7uf1HEjfeE/C9/xk/J3nRZCVRPvJCuGp
         lLlBa+QdqVMHjgQI6mWdp6/aYkBnNYVmtsHqKTPrtQLXViPyVY+5fms4fKAi//avjILk
         kcvw==
X-Gm-Message-State: AOAM533rWXwzYxeaAfa1PN4bSIiXBS0qT3l/drvG5Ev+ZlP4HC1WTmtD
        Wo1p+LnMqL4bY43Er4FhvYo3UZVOSFp+1KVm
X-Google-Smtp-Source: ABdhPJzkwfBTnFlZRnlrs8PUHS0XxiAal3u2ZJpo9EdIYry/MumaEF6oof5UPBS6DI9bOZxNQHDTwg==
X-Received: by 2002:ac2:4e0a:: with SMTP id e10mr4401933lfr.225.1633450705332;
        Tue, 05 Oct 2021 09:18:25 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id g13sm1998211lfj.245.2021.10.05.09.18.21
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 09:18:22 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id u18so88852423lfd.12
        for <rcu@vger.kernel.org>; Tue, 05 Oct 2021 09:18:21 -0700 (PDT)
X-Received: by 2002:a05:6512:b8e:: with SMTP id b14mr4429467lfv.655.1633450701008;
 Tue, 05 Oct 2021 09:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211005094728.203ecef2@gandalf.local.home>
In-Reply-To: <20211005094728.203ecef2@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Oct 2021 09:18:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0AJAv9o2sW7ReCFRaD+TatSiLMYjK=FzG9-X=q5ZWwA@mail.gmail.com>
Message-ID: <CAHk-=wj0AJAv9o2sW7ReCFRaD+TatSiLMYjK=FzG9-X=q5ZWwA@mail.gmail.com>
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

On Tue, Oct 5, 2021 at 6:47 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Also had to update a lot of the function pointer initialization in the
> networking code, as a function address must be passed as an argument in
> RCU_INIT_POINTER() and not just the function name, otherwise the following
> error occurs:

Ugh.

I think this is a sign of why we did it the way we did with that odd
"typeof(*p)*" thing in the first place.

The thing is, in any normal C, the function name should just stand in
for the pointer to the function, so having to add a '&' to get the
function pointer is somehow odd..

So I think you should just expose your type to anybody who uses a pointer to it.

               Linus
