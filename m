Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3BBC61DA4
	for <rcu@archiver.kernel.org>; Wed, 15 Mar 2023 19:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjCOT5Q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Mar 2023 15:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCOT5P (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Mar 2023 15:57:15 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C663C1F
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 12:57:14 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536af432ee5so390183247b3.0
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 12:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678910233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWpTabGy6QLogyA9n745re/JJmzh/5d9dyJhDfcEfl4=;
        b=Lpe59DpwZs9pQF/TmsfrmgkvqZ0K3A/XUYL0fNgV07LpOAxVq7cGpuv6SQ83pKBTEm
         MhTTjW8D5MQ3YTn18WGmoozAuGkvGMZPW13GulOi2OoZ4WFj8qWAtwgoKNzDYcIVJh+x
         g+CbMBx+hDRKFCbkDK1KA4mq5olc85IXG0avA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678910233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWpTabGy6QLogyA9n745re/JJmzh/5d9dyJhDfcEfl4=;
        b=iM/JTP2ESfVXSUgSFuCeT6bK8/Wn3+TR/muvsOA5az5P8gXb1qhMhGSAxa8zM5LZDy
         qMva6pG6X3unqk1gy7ZRFrmUBsW1gbSZJHc0R1gihZCMNGN46W7S+1lTSXEPeICBbRu2
         TgmeUC5DSbuFfrynPpglVo/8uiApyMZ/rm514TTucsiaWfdSWDTUa63prYIji4xopaqR
         Kh60RssxJIjNXcnBCJKtz8+970Hv8kFSM7gRqcCpFmByrhuuq/6YMtAl9adv1m7VVFV6
         WydiXxXqwNt9xp1IAWfFBVVvmUQmxuE2BVTQqUM8yfFBueLiEFbfV1j29TJK9JU2q+sU
         3f6g==
X-Gm-Message-State: AO0yUKVu8r46kuSEn5o+t/k/SEnbB1BQdpvuX9N2sXpMcPKMTBbOv/0t
        XarI44p3dPGBSvttFpIDYMin/OFoGDICGsjS9vT/vw==
X-Google-Smtp-Source: AK7set+pGKWCyoCQbm2+A59THlc6hWu8pXoM0CYg/D+t+xU3PMcVQu9wwx4y4vZXdfb62v049FzI2x4zlkO63ATF2yA=
X-Received: by 2002:a81:ae5f:0:b0:532:e887:2c23 with SMTP id
 g31-20020a81ae5f000000b00532e8872c23mr695840ywk.9.1678910233685; Wed, 15 Mar
 2023 12:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230201150815.409582-1-urezki@gmail.com> <20230315151415.2534e11c@gandalf.local.home>
 <e5a1815b-65b5-55ca-9773-ec04378d53c0@kernel.dk> <ZBIbloFMm5xRsjfn@pc636> <20230315153448.6914f85b@gandalf.local.home>
In-Reply-To: <20230315153448.6914f85b@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 15 Mar 2023 15:57:02 -0400
Message-ID: <CAEXW_YTLFQ3-LApyCPNNx7Tn2ovFr8YUXL=1WVCm+rE2hRKE8g@mail.gmail.com>
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

Hey Steve,

On Wed, Mar 15, 2023 at 3:35=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 15 Mar 2023 20:25:10 +0100
> Uladzislau Rezki <urezki@gmail.com> wrote:
>
> > > This was my main complaint too, kvfree_rcu_mightsleep() is an absolut=
ely
> > > horrible name for an API... But nobody seemed to care about that!
> > >
> > > I like the _synchronize() suggestion, as it matches other RCU naming.
> > >
> > This is basically about what it does. If you renamed it to "_synchroniz=
e()"
> > in reality it would not mean that it always a synchronous call, most of=
 the
> > time it is not whereas the name would point that it is.
>
> No, just comment it.
>
> I was going to suggest "kvfree_rcu_might_synchronize()" but that's just
> getting ridiculous.

No, synchronize() is incorrect. The code really can sleep for other
reasons like memory allocation. It is not that simple of an
implementation as one may imagine. mightsleep is really the correct
wording IMHO.

> Still, I will replace that code back to a kfree() and rcu_synchonize() th=
an
> to let that other name get in.

I think it is too late for that for now, we already have conversions
going into the other subsystems, that means we'll have to redo all
that over again (even if it sounded like a good idea, which it is
not).

I would rather you just did: "#define kvfree_rcu_tracing
#kvfree_rcu_mightsleep", or something like that, if it is really a
problem. ;-)

Also you are really the first person I know of who has a problem with that =
name.

 - Joel
