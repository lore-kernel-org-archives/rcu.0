Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D75FC47089
	for <rcu@archiver.kernel.org>; Mon,  5 Dec 2022 13:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiLENXW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 5 Dec 2022 08:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiLENXV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 5 Dec 2022 08:23:21 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C20FFAD9
        for <rcu@vger.kernel.org>; Mon,  5 Dec 2022 05:23:20 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3f15a6f72d0so11770637b3.1
        for <rcu@vger.kernel.org>; Mon, 05 Dec 2022 05:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HdUkGOFA8wke27uAAhCuCv+jF7+0r0HFE/PqJS/cws=;
        b=iWU0jI581Ky8vZRfXg2dEaOi6FgfRMlB3PV2QOTtIUiMiPZQIe4jFy4OeqY4LJwesn
         z7Q9ziwFacx6n8v/8RWZ1PYXCNaICKqmWgdLUyaojEZKPh1/obeK81gcd82y2FD80GRO
         DtwtmQqMVIpJ+UJqkKq56wGBM41piayl9hqdjHCQRRLKvw8mfGIInF4LNu7ziLUad6vX
         cGaO1AaI435CERsl25V6q1F0V5gtnHbNmckYddp1/DcmILJhnIpgmwrevWQbo2qUK2ig
         baehqU0vSMSK1WbC4jep47jr9ckd9RNTcj/D1KyVynfXqxlNch0oTDyMbqzN95JxOvJm
         xPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HdUkGOFA8wke27uAAhCuCv+jF7+0r0HFE/PqJS/cws=;
        b=jXKS6M4rAkEjlxax0P4/IHjHST+NfpOvC8pJz9ZmD4YfjaoMQdkuc7Kvcs2g1HwcZY
         1tzmE078NRHUKcqJDPLjLgWcxaPb/0J4mP5LQtKWq0GUwhCLHIP8wJGWhLN3cncTbIKi
         mpcqDky+QBhxKVdxrrV23QOCZ33kCSIyMNSog6kUa6OTsI109lyVFMq3uwK49SUt/mF+
         X6WjNVxDwyZeb7khAEgjyGobVvrNIzegqOZw7nr9zpGToi4xelSfJ52gXMIega0kDJTw
         V3lloeODj24R05MNqhsK+kvw+fl15jHsjYnjDui+8ShwmOVD26SRPDCVWl5YDY2q+eKL
         KAkw==
X-Gm-Message-State: ANoB5plBzX4IFYR8CyrJz9++GfPutWID7lQ6QCswaRUgLMv3S89vFEXA
        fVHE5ahZDxqT6bRwM0+0rt6pJOKekAqxmbVHLAV0Ww==
X-Google-Smtp-Source: AA0mqf4tzCE5SswJAW77W9du8An5y0+TmPZ8Oxr2G5+RQ9HRdiKyTEynuI/wTWzNYfTaH4Wu/+/nRxyswOH+/mxVIz8=
X-Received: by 2002:a81:1144:0:b0:3f2:e8b7:a6ec with SMTP id
 65-20020a811144000000b003f2e8b7a6ecmr472667ywr.332.1670246599462; Mon, 05 Dec
 2022 05:23:19 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YRW+ZprkN7nE1yJK_g6UhsWBWGUVfzW+gFnjKabgevZWg@mail.gmail.com>
 <21A10014-22D8-4107-8C6C-14102478D19B@joelfernandes.org> <Y43RXNu0cck6wo/0@pc636>
In-Reply-To: <Y43RXNu0cck6wo/0@pc636>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 5 Dec 2022 14:23:07 +0100
Message-ID: <CANn89i+RNj0gaJCyNUyrMBpSTsxSgjW1YN_FuRW_pMUOMiQtuQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: use 2-arg optimal variant of kfree_rcu()
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     paulmck@kernel.org, "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        eric.dumazet@gmail.com, Dmitry Safonov <dima@arista.com>,
        rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Dec 5, 2022 at 12:09 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> Hello, Eric.
>
> > +rcu for archives
> >
> > > On Dec 2, 2022, at 7:16 PM, Joel Fernandes <joel@joelfernandes.org> w=
rote:
> > >
> > > =EF=BB=BFOn Sat, Dec 3, 2022 at 12:12 AM Joel Fernandes <joel@joelfer=
nandes.org> wrote:
> > >>
> > >>> On Sat, Dec 3, 2022 at 12:03 AM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
> > >>>
> > >>> On Fri, Dec 02, 2022 at 11:49:59PM +0000, Joel Fernandes wrote:
> > >>>> On Fri, Dec 02, 2022 at 05:28:47AM +0000, Eric Dumazet wrote:
> > >>>>> kfree_rcu(1-arg) should be avoided as much as possible,
> > >>>>> since this is only possible from sleepable contexts,
> > >>>>> and incurr extra rcu barriers.
> > >>>>>
> > >>>>> I wish the 1-arg variant of kfree_rcu() would
> > >>>>> get a distinct name, like kfree_rcu_slow()
> > >>>>> to avoid it being abused.
> >
> <snip>
> tcp: use 2-arg optimal variant of kfree_rcu()
> Date: Fri,  2 Dec 2022 05:28:47 +0000   [thread overview]
> Message-ID: <20221202052847.2623997-1-edumazet@google.com> (raw)
>
> kfree_rcu(1-arg) should be avoided as much as possible,
> since this is only possible from sleepable contexts,
> and incurr extra rcu barriers.
>
> I wish the 1-arg variant of kfree_rcu() would
> get a distinct name, like kfree_rcu_slow()
> to avoid it being abused.
>
> Fixes: 459837b522f7 ("net/tcp: Disable TCP-MD5 static key on tcp_md5sig_i=
nfo destruction")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Dmitry Safonov <dima@arista.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> <snip>
>
> Could you please clarify a little bit about why/how have you came
> up with a patch that you posted with "Fixes" tag? I mean you run
> into:
>   - performance degrade;
>   - simple typo;
>   - etc.

Bug was added in the blamed commit, we use Fixes: tag to clearly
identify bug origin.

tcp_md5_key_copy()  is called from softirq context, there is no way it
could sleep in synchronize_rcu()
