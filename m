Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A4DC7EE43
	for <rcu@archiver.kernel.org>; Mon, 12 Jun 2023 23:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjFLXRX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Jun 2023 19:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjFLXRW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Jun 2023 19:17:22 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F14BD;
        Mon, 12 Jun 2023 16:17:21 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977d02931d1so720864766b.0;
        Mon, 12 Jun 2023 16:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686611840; x=1689203840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sV57Gi5KB8DQYNOaIfyuyJjbpB6bLU8SRXwiQ796zo=;
        b=nA4LLIBhx2cb6bEKHs1Pqk8didPqi9NF/qrcBtAjVAydat742PBh94sFPCzr7r0pC4
         iiHflTB30MnqroKx/XRt6TFaAWS960YBR6X5MzMs3CQU6hnHMxPrBg3MejQiBin96Ixm
         jxIYkNGYwIaUAo7U06knKi0tnOBotqwRCr+v8xWel3oV8iIdktxfNQpXICU7ftXF0OD3
         DvIzu/vhKKdzY1e3zA/zxMB6VS5tAGhf9CrSH0nWmVAWZJN310FdwDyx52fSQvZsb+Xb
         Yydaf7QmRofIef0xIuVeWotFIJFVyvEUv/yTtSpxqked9s9p11cQdHnqLqNR/oSta6eo
         C5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686611840; x=1689203840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sV57Gi5KB8DQYNOaIfyuyJjbpB6bLU8SRXwiQ796zo=;
        b=lWOSI6I9pSpNpYhChDTkyZqENBKRjphyMnukEue76Ju3JwLlIJOKxZvTDMxVcjvg36
         wp0VmKoSLWbITtD8hAU91UypTcpQunDcFnam3/+fm7PfujrHY1uXRMBKBp+/rygbt4wM
         vvGfpqXTKpi1o3BlRvo5ffypFibODUZXB5XMZN55Xbmx3w8mta9ZpG5DRJ23VBNP31ul
         spvvBtG7ujUvMqKvSsIzkvTZUrOHwdZ3UV1VoU6WZhY3DnEqzS+mnF9Xge3lRjmog0bq
         iqMs9mHilGFCri554gGzj6SJ/Q6fuiZBydNb4kOe18T3btWEnFDncjVkfQ62DlPhmbf9
         85UQ==
X-Gm-Message-State: AC+VfDxtCTw5CGeLAZqJxbsrrC4UnMBCg23YdP0uJ6F1cLHU+jWMgzMN
        otUjvcECesGtSCXkao9y7wyS/FB7BypGSPxLxDI=
X-Google-Smtp-Source: ACHHUZ72g4kV+21RVFP3RAcJ4GRF0ynHzwlhMYtRpKNCNJUJTnxslJtj9I9Z0byqfwqO26sdKNTowOAZRJJEqeXRRYg=
X-Received: by 2002:a17:906:58d2:b0:96f:f19b:887a with SMTP id
 e18-20020a17090658d200b0096ff19b887amr11598141ejs.56.1686611839769; Mon, 12
 Jun 2023 16:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230609024030.2585058-1-houtao@huaweicloud.com>
 <20230609031907.5yt7pnnynrawjzht@MacBook-Pro-8.local> <7e1ed3f0-f6b1-a022-d7c5-055a80deb606@huaweicloud.com>
 <CAADnVQK-e9Y0gNyDUu6kZ4K9P0UXLdkwhvWT_iEhxJeB5JSAyg@mail.gmail.com>
In-Reply-To: <CAADnVQK-e9Y0gNyDUu6kZ4K9P0UXLdkwhvWT_iEhxJeB5JSAyg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Jun 2023 16:17:07 -0700
Message-ID: <CAEf4BzY7+mcADa1SUDMpVNbdo2aakSkHv4HU3ENgFfrg+7BNPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] selftests/bpf: Add benchmark for bpf memory allocator
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jun 9, 2023 at 9:12=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jun 8, 2023 at 11:32=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> =
wrote:
> >
> > >
> > >> +                    --producers=3D8 --prod-affinity=3D0-7 "$@")"
> > > -a -p 8 should just work.
> > > No need to pick specific cpus.
> > No. For VM with only 8 CPUs, the affinity of the first producer will be
> > CPU 1 and the affinity of the last producer will be CPU 8, so the
> > benchmark will fail to run. But I think I can fix it, so the affinity o=
f
> > the last producer will be 0 instead.
>
> Right. Noticed that too.
> That should probably be a separate patch to fix this cpu assignment
> issue in bench for all benchs.
>
> Andrii,
> when you wrote it did you really mean to start assigning cpus from 1
> or that was just an oversight?

  616 =E2=96=B8       /* unless explicit producer CPU list is specified, co=
ntinue after=C2=AC
  617 =E2=96=B8        * last consumer CPU=C2=AC
  618 =E2=96=B8        */=C2=AC


It's been a while, but it seems like each consumer gets its CPU first,
then each producer. So yeah, seems intentional.

For context, this was done for BPF ringbuf benchmarking, so by default
I wanted to separate a single consumer from multiple producers.
