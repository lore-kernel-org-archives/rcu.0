Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D744C4321E
	for <rcu@archiver.kernel.org>; Wed, 30 Nov 2022 23:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiK3XZj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiK3XZV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Nov 2022 18:25:21 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED30BBD8BF
        for <rcu@vger.kernel.org>; Wed, 30 Nov 2022 15:17:07 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id m7-20020a9d6447000000b0066da0504b5eso12215142otl.13
        for <rcu@vger.kernel.org>; Wed, 30 Nov 2022 15:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HInS/N+iYT5Xyv/3OtkTBTcUMud6010V70HXD5PLrgQ=;
        b=UoueS2pcPxayLxQFXEIfTPHDfYTQ5o6kSdnvOHBEZNmSr0iPL47pGi3D5VEsq4ZZWK
         NXpkr2RVsUvlg2ueuKu//R0ddEFwoNKwUI8JocQc/BjhTxilDcWD2QOmZbXikPVjP1Gc
         O0TejO0856WRouyOsoV2XWLCP+fzOhZubAwFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HInS/N+iYT5Xyv/3OtkTBTcUMud6010V70HXD5PLrgQ=;
        b=ioYpzLRTsk0sM93booCjijWalX7FSbUsicIBw0cjUpMIZAtrg47Hmgko5TGXFdcpKE
         N7ywA1JQr/dj3FY6VjbFlgsmfd6PJfIq9nQeUDnvdg9iu56bC1SMBhOPgmptGi2h1m6D
         uxfhYymCo1fc7rACBbUxyyKkAFcCrdS5dCYXdZHyJJao1W+FWGPrsn0Oc6JNzusYRvFb
         Z+ISO4I2//FHkApwDtaTn2Z+aJIxcLZf80rLUO9SChT4Qjz5xkue0e0XZ5Y1L47Apasd
         nQvqsVqQJkPeeWMcoWonv2R6uVvE9ILqC9thSSppIWlG3U4coWM6PRWSd1t8j8SOn6Rq
         mXHw==
X-Gm-Message-State: ANoB5pn63spHQ2Zs4GkorKUKcu8mIxny7AKBunCajJkitNSF0HeMjJ2J
        LlaXVeLvZaephWyfb85WKlkKJev57Y4aE7SFBtIZJTnBMrpi/x3+
X-Google-Smtp-Source: AA0mqf4PNohW9IoqD0HMyO5sUTIU8Ax9vPiAxn89y1QKO6rMLaUTbF9NDjCpCqbB3gn4d7O6p1M8/iZkYZUpu08wCRI=
X-Received: by 2002:a05:6830:1f4a:b0:661:b04c:41d9 with SMTP id
 u10-20020a0568301f4a00b00661b04c41d9mr22511809oth.92.1669850168015; Wed, 30
 Nov 2022 15:16:08 -0800 (PST)
MIME-Version: 1.0
References: <20221130181316.GA1012431@paulmck-ThinkPad-P17-Gen-1>
 <20221130181325.1012760-14-paulmck@kernel.org> <CAEXW_YS1nfsV_ohXDaB1i2em=+0KP1DofktS24oGFa4wPAbiiw@mail.gmail.com>
 <639433.1669835344@warthog.procyon.org.uk> <CAEXW_YSd3dyxHxnU1EuER+xyBGGatONzPovphFX5K9seSbkdkg@mail.gmail.com>
 <658624.1669849522@warthog.procyon.org.uk>
In-Reply-To: <658624.1669849522@warthog.procyon.org.uk>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 30 Nov 2022 23:15:51 +0000
Message-ID: <CAEXW_YSKdkxYNompUK1orGcAHfqCjWg-twiASdBM9i2Sv=9Kuw@mail.gmail.com>
Subject: Re: [PATCH rcu 14/16] rxrpc: Use call_rcu_hurry() instead of call_rcu()
To:     David Howells <dhowells@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 30, 2022 at 11:05 PM David Howells <dhowells@redhat.com> wrote:
>
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > > Note that this conflicts with my patch:
> > >
> > >         rxrpc: Don't hold a ref for connection workqueue
> > >         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=rxrpc-next&id=450b00011290660127c2d76f5c5ed264126eb229
> > >
> > > which should render it unnecessary.  It's a little ahead of yours in the
> > > net-next queue, if that means anything.
> >
> > Could you clarify why it is unnecessary?
>
> Rather than tearing down parts of the connection it only logs a trace line,
> frees the memory and decrements the counter on the namespace.  This it used to
> account that all the pieces of memory allocated in that namespace are gone
> before the namespace is removed to check for leaks.  The RCU cleanup used to
> use some other stuff (such as the peer hash) in the rxrpc_net struct but no
> longer will after the patches I submitted.
>
> > After your patch, you are still doing a wake up in your call_rcu() callback:
> >
> > - ASSERTCMP(refcount_read(&conn->ref), ==, 0);
> > + if (atomic_dec_and_test(&rxnet->nr_conns))
> > +    wake_up_var(&rxnet->nr_conns);
> > +}
> >
> > Are you saying the code can now tolerate delays? What if the RCU
> > callback is invoked after arbitrarily long delays making the sleeping
> > process to wait?
>
> True.  But that now only holds up the destruction of a net namespace and the
> removal of the rxrpc module.
>
> > If you agree, you can convert the call_rcu() to call_rcu_hurry() in
> > your patch itself. Would you be willing to do that? If not, that's
> > totally OK and I can send a patch later once yours is in (after
> > further testing).
>
> I can add it to part 4 (see my rxrpc-ringless-5 branch) if it is necessary.

Ok sounds good, on module removal the rcu_barrier() will flush out
pending callbacks so that should not be an issue.

Based on your message, I think we can drop this patch then. Since Paul
is already dropping it, no other action is needed.

(I just realized my patch was not fixing a test failure, like the
other net ones did, but rather we found the issue by static analysis
-- i.e. programmatically auditing all callbacks in the kernel doing
wake ups).

thanks,
 - Joel
