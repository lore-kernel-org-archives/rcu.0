Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FB4C433F5
	for <rcu@archiver.kernel.org>; Thu,  7 Apr 2022 17:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbiDGRIL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 Apr 2022 13:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiDGRIL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 7 Apr 2022 13:08:11 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD291CA12E
        for <rcu@vger.kernel.org>; Thu,  7 Apr 2022 10:06:10 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id k15so4739686ils.0
        for <rcu@vger.kernel.org>; Thu, 07 Apr 2022 10:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2shIerg3ZjkZ+hlnELwnPDYoovZR3rLiNksYdZNlR/w=;
        b=TmpaZ6JIqPGs+Ma4m3GP49IfdLPHB8PEbnHSjkWx9pLDkPlhGSLwemhYzfQ0NlWnno
         Op5Md0NoFP9YmDy3uXvYu20A19fwrJWLvZOXalgpVJT09z7QNwfuPZguUnVtXpwSeOgQ
         WIXdpEaf2WhoEyn9z0S4VpviPGsKfeed7JVMMkoRvI2yAVSAuNFwXCoaO67ft26gZY58
         fLZOHVS3IF7MW7RSAdrPxBlSU+ShDRhBRUKY5vTZrUl9WnSMhYsHSkM8LuYf/846gWAu
         skb7gRlaajdGF3WGab4QCul6QfU2ikDkTESjH3OG/1L3H5QHRQCFHxS4fv/r6E/XXA2U
         feSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2shIerg3ZjkZ+hlnELwnPDYoovZR3rLiNksYdZNlR/w=;
        b=bvZTUVzUxN/NybtzrwCKQN+avkams+lmEA1c2IxoadBVUbqMfQnN+oCAHBtc7czj4E
         YNS8Cwq7W3wNLkyqOV25cntihPv0cfoLf2MG3HGmg7sqeVwpS4kSt2hQaZtS2f5uqZg5
         pN16wnYdk9CG5DcgvzEwXHaF60YOB0WJBuP6uAxihncn24M86EbkLZN+IEtTIeaQV4aQ
         SdYW7DE7LIw1Jt6uBa9y8HU2YLZ9LCKdxBRLrygNJh1hcVBEJjOMu/PwYBJCjhEvB3sf
         i2PwZ0ImvT2Y4ouUOdG07/OmN2TmsdCllkZ8QFKGOq78sN5JJnYQiiZ12zdnr9/moH+l
         xyWA==
X-Gm-Message-State: AOAM533pir5yu36oLJ3TzkV+ryw/cVEfleZMX2OqYnK6HicgSgJdtUHW
        GJxqrPP+Y5VjyKvwDjjOKA4DshFi25kw9o1xTUc=
X-Google-Smtp-Source: ABdhPJx4pyWHHkwr3I6PP1ppWaPPVhTkblMHBdqTeyH51o5vidrq6q7KC3VE+MtKa7OCbtjwfTqpxav/vK3S3LB1RxU=
X-Received: by 2002:a92:c908:0:b0:2c1:a287:8868 with SMTP id
 t8-20020a92c908000000b002c1a2878868mr6697149ilp.321.1649351169248; Thu, 07
 Apr 2022 10:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72k+5Rdj7i3Df2dcE6_OPYPXK3z5EWLKnY56sSMz4G3OvA@mail.gmail.com>
 <CAABZP2z64aYWfVSdXHaQopWc+BAbJJUGqtrju2iWER3DDTDFWg@mail.gmail.com>
 <20220406170012.GO4285@paulmck-ThinkPad-P17-Gen-1> <CAABZP2zhZaN0+KqP7oMoyXTSkDhLjZwWvnj7coa1ZVve9M+jsQ@mail.gmail.com>
 <20220406195011.GP4285@paulmck-ThinkPad-P17-Gen-1> <CAABZP2x8_783jhEhC3AozH9=xj40UO-rZT2BRJsg5gaLdBz=9w@mail.gmail.com>
 <CANiq72mYXnQo_Y39k23rY-rdJay8GEPJ8MhU-y7-bjkw=zRC+Q@mail.gmail.com> <20220407151555.GR4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220407151555.GR4285@paulmck-ThinkPad-P17-Gen-1>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 7 Apr 2022 19:05:58 +0200
Message-ID: <CANiq72k7BWjOU8=-dXD4bYWbK1i+rjDNaAohGrU42yJzcBm7uQ@mail.gmail.com>
Subject: Re: rcu_sched self-detected stall on CPU
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 7, 2022 at 5:15 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Ah.  So you would instead look for boot to have completed within 10
> seconds?  Either way, reliable automation might well more important than
> reduction in time.

No (although I guess that could be an option), I was only pointing out
that when no stall is produced, the run should be much quicker than 30
seconds (at least it was in my setup), which would be the majority of the runs.

Cheers,
Miguel
