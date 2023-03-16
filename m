Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2AFC6FD19
	for <rcu@archiver.kernel.org>; Thu, 16 Mar 2023 05:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjCPFBQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Mar 2023 01:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCPFBP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Mar 2023 01:01:15 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD349EF64
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 22:01:14 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id e194so533978ybf.1
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 22:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678942873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11L4bG0IazgBpc/bEo/rh1pO9WY2JB5Cnz+AF2jVWr8=;
        b=fydBYh7IDK/xvjeo2SE6lxrCjGPC+IFbnMkvDmZIVYWNE9a1+T0biSAJNkEBQNOe7n
         WlpAv9tapTceCe+CQJ946JS1yM6trhd+ts0BT7VYGQ6MI6iBUqgckqUi/g0JX25f0MjZ
         GEqYi5fs2ZKxRHY5jUvEg5vX2IaCy8daHE9S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678942873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11L4bG0IazgBpc/bEo/rh1pO9WY2JB5Cnz+AF2jVWr8=;
        b=VjjleA0jXi4PDJh5yOkQv6sOyCID5JBN0aiyOwcCSXfNuovG8e4Kin9BAMTosajMxK
         CdQrMM5Xh0gwuyb+yr1qK9KlVJ0FVVa3q2dD/0vG5VJ/HELxa2+xtNZe1c4lgcOAK+/D
         PEGfdEGzn6DroPIW+Pkq/AilQPavAL0GQ0PdnCTVtlAXKOoF+E1uPd2rGiu1zg9O62Mq
         A4g5UC9F97QTxPIUz+GTlUGcXLuLrUBjFbRuu+E1UpPahVrUiap8+OvDDhJV0u5rGk8J
         HxD6/A1BCm4P6JBdUyq+Dd9yLv65WD5kII5TjUBrUY4ldRNpNyINVcltPXPjUWBsO1DJ
         l+sA==
X-Gm-Message-State: AO0yUKUp/N0Nh8m6cyRud6Mv8ygcj4TLM9iAZdpsOjXL7/rIpizz5jxV
        V+KTXoGNmVCc5P5GV6F2sDkODRmYzARJchMIKuB+5A==
X-Google-Smtp-Source: AK7set8aa1EiJes/s4PujwskpdRqRkJmJ9T179Ig2lW/L0+La8ScHCtdmUNP+KtSer8igSxOllboZrq+shxRKlwciRQ=
X-Received: by 2002:a25:9292:0:b0:b3a:e877:3290 with SMTP id
 y18-20020a259292000000b00b3ae8773290mr8897010ybl.2.1678942873240; Wed, 15 Mar
 2023 22:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230201150815.409582-1-urezki@gmail.com> <20230315151415.2534e11c@gandalf.local.home>
 <e5a1815b-65b5-55ca-9773-ec04378d53c0@kernel.dk> <ZBIbloFMm5xRsjfn@pc636>
 <20230315153448.6914f85b@gandalf.local.home> <CAEXW_YTLFQ3-LApyCPNNx7Tn2ovFr8YUXL=1WVCm+rE2hRKE8g@mail.gmail.com>
 <20230315162840.106a5b4f@gandalf.local.home> <CAEXW_YTNNJJftsg1QRvhUCRoZpKa3SM6=-0M-cukCGt5=G+row@mail.gmail.com>
 <20230315182628.39329315@gandalf.local.home> <CAEXW_YSMr7b4K11T6kjThG8-DyxNiJMU3LOo-SwQ+Ev8h9taMw@mail.gmail.com>
 <20230315225046.3cfed1ee@gandalf.local.home>
In-Reply-To: <20230315225046.3cfed1ee@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 16 Mar 2023 01:01:02 -0400
Message-ID: <CAEXW_YRhTsr8Yx2HyrcuK5ziNPDEPV-GFc0FG=UCQ-1J4UnvXg@mail.gmail.com>
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to k[v]free_rcu_mightsleep()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 15, 2023 at 10:50=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Wed, 15 Mar 2023 22:13:26 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > > Why not call it kvfree_rcu_alloc() ? It allocates right?
> >
> > Sure, but one can say now that allocating is an implementation detail? =
;-)
>
> I was being sarcastic.
>
> But as the mighty Linus once said: "In the Internet, nobody can hear your=
 sarcasm"
>

I guess it's official then - the internet has killed sarcasm. I
suppose we'll all have to resort to using more obvious forms of humor,
like dad jokes. ;)

 - Joel
