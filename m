Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B133C0015E
	for <rcu@archiver.kernel.org>; Tue, 27 Jun 2023 17:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjF0R4p (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Jun 2023 13:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjF0R4p (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Jun 2023 13:56:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA522733
        for <rcu@vger.kernel.org>; Tue, 27 Jun 2023 10:56:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9924ac01f98so57314266b.1
        for <rcu@vger.kernel.org>; Tue, 27 Jun 2023 10:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687888599; x=1690480599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BBM9HTbVE8IN9zkGnkp6xc3S5GpMqGP8gETPCnCzVXo=;
        b=ZAKtTuJnvBJ0mMPXJRzdMshkWjH33bH2L3xcGz1iqCddlIVwQQwZ1nsVXMGqNKgCac
         mZvJD56rmK9hLaxlIBxKHEFSXukX38e816WSScn+dwxbTI7YsYgQnIgRqc4RRywKuf7t
         JSpVK5+5nTpdBcO1+ZukQyAfsMVyNn7LhRT/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687888599; x=1690480599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBM9HTbVE8IN9zkGnkp6xc3S5GpMqGP8gETPCnCzVXo=;
        b=Y/vodzPwTc4YuEMYCDesFsWaX4RJotere3J00/svSuE1//tVZmoruv/po6KhUtJ5jI
         QMlxWCY861jCAeybl+K6wblrWTTsRoqLX674Jla94uBYUZ1XCLiBXhMn6zQZMqPfmtv3
         gC6yGlT1Ly2cPysad5C82bzo6hQzX5OZ7MyRsFGS5G2xFxbZR6p2k0SoJP7vGfpLH1qd
         f9hL++WM9Q73MgkPdUPp4CHwVrSJxJJC3e0YZWi57o83MacjMyEu5eLY1H62GIQ38Kpm
         OIC8Mp/YtpAXQTe2DmqJDUIIHHEFeJkDqZr5XgQmrB+6kC1exuxfQaJS35e5tiO83ePG
         pk8A==
X-Gm-Message-State: AC+VfDytQCUP2MuUWZpUT5c53NonzSy8MPj0FepKAzskGh1w5IyQP0Q3
        pcRZriXMNCS4sTnXgodut90FONwUzgr1dOn1xdblRFkN
X-Google-Smtp-Source: ACHHUZ5jYLTwOvprchvRpSaHppnY0fEkCJT65+dYSlZKZlY/o8YmTT5dCeSlcXKi2gw/A5e/rO41+g==
X-Received: by 2002:a17:906:58c5:b0:988:891b:28c6 with SMTP id e5-20020a17090658c500b00988891b28c6mr26824574ejs.15.1687888599706;
        Tue, 27 Jun 2023 10:56:39 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id lc1-20020a170906f90100b00988e953a586sm4826240ejb.61.2023.06.27.10.56.38
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 10:56:38 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51d7f4c1cfeso4937892a12.0
        for <rcu@vger.kernel.org>; Tue, 27 Jun 2023 10:56:38 -0700 (PDT)
X-Received: by 2002:aa7:c257:0:b0:51c:ef63:380a with SMTP id
 y23-20020aa7c257000000b0051cef63380amr7719283edo.27.1687888598013; Tue, 27
 Jun 2023 10:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <963d6eb8-6520-4c33-bbe8-6c76205bfd3d@paulmck-laptop>
In-Reply-To: <963d6eb8-6520-4c33-bbe8-6c76205bfd3d@paulmck-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Jun 2023 10:56:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whn4DGusRgq7ihBmu7vPBhvSDZsYN_ctef94E1rVbf5jA@mail.gmail.com>
Message-ID: <CAHk-=whn4DGusRgq7ihBmu7vPBhvSDZsYN_ctef94E1rVbf5jA@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.5
To:     paulmck@kernel.org, Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, 25 Jun 2023 at 08:35, Paul E. McKenney <paulmck@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2023.06.22a
>
> o       Eliminate the single-argument variant of k[v]free_rcu() now
>         that all uses have been converted to k[v]free_rcu_mightsleep().

Well, clearly not all users had been.

The base of this RCU was v6.4-rc1, and when that commit was done, we
still had a single-argument variant:

  7e3f926bf453 ("rcu/kvfree: Eliminate k[v]free_rcu() single argument macro")

but look here:

     git grep 'kfree_rcu([^,()][^,()]*)' 7e3f926bf453

results in

   7e3f926bf453:drivers/infiniband/sw/rxe/rxe_verbs.c:     kfree_rcu(mr);

so the RCU tree itself can not possibly have built cleanly.

How the heck did this pass testing in linux-next? Did linux-next just
assume that it was a merge error, and fix it up?

Anyway, I *did* fix it up, changing the 'kfree_rcu()' to
'kfree_rcu_mightsleep()', but no, this was not a merge artifact. This
was purely "the RCU tree did not build on its own", and as a result
the tree does not bisect cleanly if you have rdma enabled.

Adding rdma people to the participants just to let them know that this
happened, but it's not their fault. This is on the RCU tree, and lack
of proper coverage testing.

               Linus
