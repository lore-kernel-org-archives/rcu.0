Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBD8C5DF62
	for <rcu@archiver.kernel.org>; Wed, 26 Jan 2022 20:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiAZUZY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Jan 2022 15:25:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229837AbiAZUZY (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 26 Jan 2022 15:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643228723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l/f4SbDskEdju8/ujJbeu3HorcjyliWi4DjB0YbspNg=;
        b=FYqIDhiQ/Yy45o+AEsUymcMiWKePI9IRj6dsN6XiEc+YTb9gzatgN2nuSEsnHFAfzfp0QR
        5J30LQSw3+CN0ThxPaqCKJUC+M1+W9Fy8NTNu5QItGQYr0/TWXhuBQO+r/ZmrdHmZltwqT
        +ywvuQM4iymJ9JJhx7usZhiVC/tYHvE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-ESqC1-mDMqeaehBmXqBnbg-1; Wed, 26 Jan 2022 15:25:22 -0500
X-MC-Unique: ESqC1-mDMqeaehBmXqBnbg-1
Received: by mail-qt1-f197.google.com with SMTP id c20-20020ac84e14000000b002d198444921so586594qtw.23
        for <rcu@vger.kernel.org>; Wed, 26 Jan 2022 12:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/f4SbDskEdju8/ujJbeu3HorcjyliWi4DjB0YbspNg=;
        b=7sW5zv1Zi6E/iVHqEB79Mx/NZjovOnnU5zxkxPLxY+Sl8kn94l4ieEF0lhLJEswpBA
         yxwvJFNo3KjMHGFC8CdZRYo4ubrdhmoBK8cOzygj2x74OOkO27OnFwR+MDMzpUur+Nuv
         /A9IoU09qGyroynN8EwwqPr9sTpKo0vgDgzjYty1zNQ7SmRVo0hX5KJT9GnpNuy16gLc
         YPKemxiQSCuTIK+sO8dBlK3NqBu056aw72RAqxeQvRRa097+wzH/hwz56Is7Syq0ulu1
         DqSq/tU/GSB/STJTDnG8KiNsa0Kb8YGC34rTSltvEyb0sqPUahd3y7hFdrb2Grk6CrI4
         11xQ==
X-Gm-Message-State: AOAM5324by5QCyJ3vol7cQBBie+2+TAzpBX6bkNPsT0YFo9aWrNRRSqu
        VuvW20RutsRqrTlh4lH+9cQEdV6xcXt5KHEuwxNxKigtK1EkK57kBgoGOaGqQ5wyMr61zz+qMlB
        e3woIeM5u0olk+CEWhAizwLm82DPR
X-Received: by 2002:a05:6214:21e8:: with SMTP id p8mr432634qvj.116.1643228721305;
        Wed, 26 Jan 2022 12:25:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJze1yjZvcppzNmXfLCG5XHVb07viUq7EOClOmQBQwEVKkpKq8oRDQQbE4c8SF/u6k0/KW6KM7KPuCi1JcmEQTs=
X-Received: by 2002:a05:6214:21e8:: with SMTP id p8mr432613qvj.116.1643228721051;
 Wed, 26 Jan 2022 12:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20220126150354.3644838-1-aahringo@redhat.com> <20220126200703.GZ4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220126200703.GZ4285@paulmck-ThinkPad-P17-Gen-1>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 26 Jan 2022 15:25:10 -0500
Message-ID: <CAK-6q+hzhndgEVLEO7m_Yu8ZEkwsQrBRZQpJdEvpK-iCCPG1LQ@mail.gmail.com>
Subject: Re: [PATCH] srcutree: use export for srcu_struct defined by DEFINE_STATIC_SRCU()
To:     paulmck@kernel.org
Cc:     jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

On Wed, Jan 26, 2022 at 3:13 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Jan 26, 2022 at 10:03:54AM -0500, Alexander Aring wrote:
> > This patch fixes a sparse issue if DEFINE_STATIC_SRCU() of srcutree is
> > used by a module. Sparse will show:
> >
> > sparse: symbol '__srcu_struct_nodes_srcu' was not declared. Should it be static?
> >
> > The problem is here that the DEFINE_STATIC_SRCU() of srcutree uses
> > __DEFINE_SRCU() and define a non-static srcu_struct. This srcu_struct
> > will be exported by inserting it in a special module section
> > '__section("___srcu_struct_ptrs")'. During load/unloading srcutree runs
> > their init/cleanup functionality. It seems sparse does not understand
> > this connection. To avoid the sparse warning we make a prototype of the
> > exported srcu_struct with an export keyword. This way we tell the
> > that the srcu_struct might be used outside of the module.
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
>
> Queued for further review and testing, thank you!!!
>
> As usual, I could not resist the urge to wordsmith a bit.  Could you
> please check below in case I messed something up?
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit fa92d727f94486195e12dc782fec17d103072101
> Author: Alexander Aring <aahringo@redhat.com>
> Date:   Wed Jan 26 10:03:54 2022 -0500
>
>     srcutree: Use export for srcu_struct defined by DEFINE_STATIC_SRCU()
>
>     If an srcu_struct structure defined by tree SRCU's DEFINE_STATIC_SRCU()
>     is used by a module, sparse will give the following diagnostic:
>
>     sparse: symbol '__srcu_struct_nodes_srcu' was not declared. Should it be static?
>
>     The problem is that a within-module DEFINE_STATIC_SRCU() must define
>     a non-static srcu_struct because it is exported by referencing it in a
>     special '__section("___srcu_struct_ptrs")'.  This reference is needed
>     so that module load and unloading can invoke init_srcu_struct() and
>     cleanup_srcu_struct(), respectively.  Unfortunately, sparse is unaware of
>     '__section("___srcu_struct_ptrs")', resulting in the above false-positive
>     diagnostic.  To avoid this false positive, this commit therefore creates
>     a prototype of the srcu_struct with an "extern" keyword.
>

perfect, thanks.

- Alex

