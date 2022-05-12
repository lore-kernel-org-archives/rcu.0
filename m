Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D57C433F5
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 16:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356034AbiELQJZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 May 2022 12:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353470AbiELQJY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 May 2022 12:09:24 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A7D266C99
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 09:09:22 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id e194so5845133iof.11
        for <rcu@vger.kernel.org>; Thu, 12 May 2022 09:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0yNHcpsU922PwWcNqJozBVSJdwcv4lgR8Sy9MB974Ps=;
        b=IYr8PyD7yboUOVbg8xzAQE3/uIiV0f2Z8pX5RomtXv6nLGYsEfHNWGBFavDo4w2L7d
         /sO2LirFUyUA9wVVVxaf49AueYKg61GJWbN3x4xVEJrGt8PhRDW3TyncL1pbTX4dU9aS
         y20LJy9ttwXuw3vXNE/zB76BbKNQGeaghdAVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yNHcpsU922PwWcNqJozBVSJdwcv4lgR8Sy9MB974Ps=;
        b=hi35uQCr3aLdqDDtCW/f2MA2qPc7/LIhmhlcOtQdmt7eh1eEJGxeN+LbXzaAJ7Pgbt
         7bCpXO+yIjQqlJm751JGqbA3fwFKj5nbATKxMNxs8HzwCalUyPt1Qa/n9UUg+PKSPnIW
         ZKdlJYx+W2UNKxNGdrwytZvYk9wAkiJ3/X26Cd63OILWibTqyAutH2VOE4AEfyM1PRcx
         cBzy01esa/l0cJdtFr+8t+N2PdS45T3OG6TveQhKlYh67oozoWuwKSipui4NS776JC6n
         P0aPKzovCtAzn2dPgSskDkr8jafCGEGfvpxq4h1sovdth2KnKWtuSoXZ9L90UCaJPTRd
         eeUw==
X-Gm-Message-State: AOAM533l7EtPgD9E7k550nAxz7wP3oIyI9XpNmrcbOjwgsgI/F46aVZN
        VqCSpSMF8F7/7DaYHFADgB9hfNCtS/lINhY7P+D5Ew==
X-Google-Smtp-Source: ABdhPJxatbX8lFlqxXtBu7oG+g32xfBLOBTgLYjy2qjwx6qS3BAfJlgTAXfXZMbXdC421a+JHezBAWPeX+Ry4GrTdkU=
X-Received: by 2002:a02:7307:0:b0:324:22bf:e119 with SMTP id
 y7-20020a027307000000b0032422bfe119mr377975jab.183.1652371761544; Thu, 12 May
 2022 09:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <CAEXW_YQ+9GK+b5_k6ZtDgSPb9S0RQ8FVcJbHoy-T2GGRpq9Zag@mail.gmail.com>
 <CA+KHdyVTwtC274v=Mmbwe3jaRPsme1mENWiOR+m2uDV=3SBTBQ@mail.gmail.com>
 <CA+KHdyVGCC2-S8waURWL_cwjdv8EyeUwnLFNVYHn+h7TrteP6g@mail.gmail.com>
 <Yn0TuehXj6VoWG0A@google.com> <Yn0bwhkdfPvbjIwK@pc638.lan>
In-Reply-To: <Yn0bwhkdfPvbjIwK@pc638.lan>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 12 May 2022 12:09:10 -0400
Message-ID: <CAEXW_YQNPDJ8aaxKzG2NN9gVR_QPbarJthiXYRd9Erw7p5V=FA@mail.gmail.com>
Subject: Re: [RFC v1 00/14] Implement call_rcu_lazy() and miscellaneous fixes
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     rcu <rcu@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 12, 2022 at 10:37 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> > On Thu, May 12, 2022 at 03:56:37PM +0200, Uladzislau Rezki wrote:
> > > Never mind. I port it into 5.10
> >
> > Oh, this is on mainline. Sorry about that. If you want I have a tree here for
> > 5.10 , although that does not have the kfree changes, everything else is
> > ditto.
> > https://github.com/joelagnel/linux-kernel/tree/rcu-nocb-4
> >
> No problem. kfree_rcu two patches are not so important in this series.
> So i have backported them into my 5.10 kernel because the latest kernel
> is not so easy to up and run on my device :)

Actually I was going to write here, apparently some tests are showing
kfree_rcu()->call_rcu_lazy() causing possible regression. So it is
good to drop those for your initial testing!

Thanks,

 - Joel
