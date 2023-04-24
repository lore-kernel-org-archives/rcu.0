Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029BFC7618E
	for <rcu@archiver.kernel.org>; Mon, 24 Apr 2023 18:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjDXSzh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 24 Apr 2023 14:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjDXSzf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 24 Apr 2023 14:55:35 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A01E6A7A
        for <rcu@vger.kernel.org>; Mon, 24 Apr 2023 11:55:24 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54fe08015c1so57958907b3.3
        for <rcu@vger.kernel.org>; Mon, 24 Apr 2023 11:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1682362523; x=1684954523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1+OurL083Y0c7KcWuiM8+QJcAaGH1Ky8yKAH2N6jmoc=;
        b=IGjUxbT7u2aSvTarjgGfvCfroYNT55WCysowQjHYPRa2hsHqrIV3OadCNlyHtELr9c
         0rr4fIruJvnpyMdCGFIKrWrfoe89L5D5M/e8cXeHhj2p/B60yfqV8ulddcFu61rSKE3a
         OM8BiAvVw7M/eJ96SVn6xXCT+T9iUqLnoGbBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682362523; x=1684954523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+OurL083Y0c7KcWuiM8+QJcAaGH1Ky8yKAH2N6jmoc=;
        b=AdjL+DPOILwqegg2v9dU7QtSYc8e6iVv2CpnY7S/dI7McFkTk3OwBM+Eg30/GSdwru
         4FoonwYC+qaoFA/bu1VEVsbsalAGyNk+zWhVGX03rOvnXLqCn8ZDMHvO6/ggmmvPZWy6
         NToHgz1Hj/MWbpsoSZYdZuTbe5AJ9tHa89bbeDY7F0ELImls5aIO9E4twkKnB6nEVD+L
         EJ19wauWuPJ4f/0RYf0uMvt8zl+HGa8Ei8MPRLFOh7dIJEJl4ApLoYltjpcZEk2zaFfW
         2lFrfeWbu1UQG7uF6IdYvMAsz7ugZY/o7uqaP3AIT4nMT8bHg3poVjQY8mvhEtBoulje
         qMcQ==
X-Gm-Message-State: AAQBX9fkQHsuOwosyAmdsKZ30hp2VWFVcUFa2j3YIy7h/Ag8/sSEXqDo
        jeUnAHfTjnfdUi/RmY/lB1R44s6L6e8BGyEYhcsiLA==
X-Google-Smtp-Source: AKy350aoe2Cg48zE3WTOUfu7kvGjK5v9r+0PwXZqQIgRDlnb/sqo4ljedyjlVhmhjgkFZt6oSOdWn0hsMSQrP78RGPg=
X-Received: by 2002:a81:4f12:0:b0:541:66e8:d4da with SMTP id
 d18-20020a814f12000000b0054166e8d4damr8695111ywb.29.1682362523439; Mon, 24
 Apr 2023 11:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <CAEXW_YSSGYgqTpxqbYikCFS9t=2f+L-0phbU+gAAngB5z-FbyA@mail.gmail.com>
 <ZEXOMC2casTlobE1@boqun-archlinux> <87fs8pzalj.fsf@mail.concordia>
 <20230424151351.GP19790@gate.crashing.org> <ZEagN1jJwg+rUzX4@boqun-archlinux>
In-Reply-To: <ZEagN1jJwg+rUzX4@boqun-archlinux>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 24 Apr 2023 14:55:11 -0400
Message-ID: <CAEXW_YRfetnhgCw5OgnwhgZF_U+UkHN=uy=L8ovGLqn1UCtfTg@mail.gmail.com>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
To:     Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This is amazing debugging Boqun, like a boss! One comment below:

> > > Or something simple I haven't thought of? :)
> >
> > At what points can r13 change?  Only when some particular functions are
> > called?
> >
>
> r13 is the local paca:
>
>         register struct paca_struct *local_paca asm("r13");
>
> , which is a pointer to percpu data.
>
> So if a task schedule from one CPU to anotehr CPU, the value gets
> changed.

It appears the whole issue, per your analysis, is that the stack
checking code in gcc should not cache or alias r13, and must read its
most up-to-date value during stack checking, as its value may have
changed during a migration to a new CPU.

Did I get that right?

IMO, even without a reproducer, gcc on PPC should just not do that,
that feels terribly broken for the kernel. I wonder what clang does,
I'll go poke around with compilerexplorer after lunch.

Adding +Peter Zijlstra as well to join the party as I have a feeling
he'll be interested. ;-)

thanks,

 - Joel
