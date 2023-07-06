Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1702CEB64DA
	for <rcu@archiver.kernel.org>; Thu,  6 Jul 2023 03:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjGFDZl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 5 Jul 2023 23:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFDZk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 5 Jul 2023 23:25:40 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C555F1BC3;
        Wed,  5 Jul 2023 20:25:35 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso2375751fa.0;
        Wed, 05 Jul 2023 20:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688613934; x=1691205934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/eRDSzqQ25Yv2WyVY1qyBDRoPQjAC3HMy+pdvXL9Cc=;
        b=B2v/UPqlW/8h/URXicF1yvJp18WEf2LJfDsNDm61EL/iXhs9SYb849L3HD8touO1J+
         2ikJiQbUS1fqUjlesdYUCj6z1tfK7Ao+eD0iw/wqCmFf8wFQT7T77JDwEjERYuFCa3CB
         lwTgB0nmD0rR9i7D/C6XnG+Fge6blZ/c/3tU93Bs54iVqsNJB/g9Nn/o/fM6y8lFHGlN
         zhX/Buh4UDx0097s/Y44tZUhQK4hHNZk8cU/1Wlox+nBHSz5P5CDIJkOyfgJW7GJU8jF
         OQgetZdaZrmJe6zISuzut/7ctng5WCvTeofU+9t9zQzSoLhUR2onyyCOst9oqY0MzZ75
         45Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688613934; x=1691205934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/eRDSzqQ25Yv2WyVY1qyBDRoPQjAC3HMy+pdvXL9Cc=;
        b=eAUJvfsah8g3IB2jKDuQ6sS31AHGZL2mpb6uYXg7Wd+wJLDyNjGzmscu4ktibZOHzA
         sBcgjDstZgtEzbxh4Jggh34UnqDnuu2WqD584ndwKd4cPWCWkiyw9t513dsk1PwuRL4f
         HpmYpEWlJJP1hlfdm5D0HachBXA38yJUamnKtqPpiqin0tqgqftjpDC5v01HIHs9YKIq
         kfP8n8MORo/fqZe/ke0VFE2dkrIdhEy4ttT5Bhr2Uouf0oWqbAA2ESmRCQcQ6pcO/2j0
         Grnqt23x0C3cdE2PFHlIWekw62iPm+OmXQRhDgZpHfhMDE2OLEyVCrGV0E1jQZ98bRRl
         avBw==
X-Gm-Message-State: ABy/qLar8OgQrK30uXdZJkBkt8PucQ8SLAPR0E69LXnydYJHEsZX9Y1n
        4O0Ow8h7GR6U7v3CsJhnmBKnLd2luStc05S7Qyed/u0p
X-Google-Smtp-Source: APBJJlGEHOCrhbBI8oGOT6K6UDeqp5IC7UXaoZ4mLww8h1jZhNSoSsX39duufpBkFUCdmqTBZcKqffRq1aKqiIMMIbg=
X-Received: by 2002:a2e:a0c8:0:b0:2b7:764:3caf with SMTP id
 f8-20020a2ea0c8000000b002b707643cafmr218910ljm.10.1688613933782; Wed, 05 Jul
 2023 20:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
 <20230628015634.33193-13-alexei.starovoitov@gmail.com> <57ceda87-e882-54b0-057a-2767c4395122@huaweicloud.com>
In-Reply-To: <57ceda87-e882-54b0-057a-2767c4395122@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 5 Jul 2023 20:25:22 -0700
Message-ID: <CAADnVQKpT1HSjz8_bd2ZM67_fwTC9QoJ+4x8G+KzzqPT7QAkDw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 12/13] bpf: Introduce bpf_mem_free_rcu()
 similar to kfree_rcu().
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Tejun Heo <tj@kernel.org>, rcu@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Vernet <void@manifault.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jun 28, 2023 at 7:24=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> I think the race could be fixed by checking c->draining in
> do_call_rcu_ttrace() when atomic_xchg() returns 1 as shown below:
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 2bdb894392c5..9f41025560bd 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -303,8 +303,13 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache =
*c)
>  {
>         struct llist_node *llnode, *t;
>
> -       if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1))
> +       if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
> +               if (READ_ONCE(c->draining)) {
> +                       llnode =3D llist_del_all(&c->free_by_rcu_ttrace);
> +                       free_all(llnode, !!c->percpu_size);
> +               }
>                 return;
> +       }

I managed to repro with your extra check-leaks patch that I will
include in the series.
The fix also makes sense.
Thanks
