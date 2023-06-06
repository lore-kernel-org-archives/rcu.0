Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64D3C77B7A
	for <rcu@archiver.kernel.org>; Tue,  6 Jun 2023 21:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbjFFVOA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Jun 2023 17:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbjFFVOA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Jun 2023 17:14:00 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1FE171D;
        Tue,  6 Jun 2023 14:13:57 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b1b084620dso62340831fa.0;
        Tue, 06 Jun 2023 14:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686086035; x=1688678035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5v/+JewlbvMwwMc1ycVR+mwpSgdsrXWL+bpwcE9vDvg=;
        b=DPlbdfIN7e2OWR0sKf1pGmByINVOEu4Es+iyeYoNN4g58s2sjf3yWTEWP2L3j9V6hP
         VWPztbqp8yzz134l1zha3Pq3+ZmAGWqU7uW7CPwflJRbQzHM9Fu2++JeluP1DX+VKjNP
         0K1EkHa+SdSYFhRu/FBNTwTySkfH2igxjTKhNTJ9eJJWylbRiAcnC6oN+drQkXbCg9OI
         gORnfUo1GwpUsAFzj6Giqni/0dT8XtZYCvuX95/vTW9AmXq742fEW+yVFgecE5C5CvWe
         Be1/NNFy4JIj1Xv8HLASR7+J+EDVgpT4wPOgrHzNeAuvUaLa8KPwf9ACOhHsmsEgPUh5
         DksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686086035; x=1688678035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5v/+JewlbvMwwMc1ycVR+mwpSgdsrXWL+bpwcE9vDvg=;
        b=ZJmoSwXS+SY3MJ/82obH6O2SETEiA0bNz3aCusBVx9VF/Y7wU3DKipJn6BHmJ6zBi4
         NikkMkaQ48dFgZ96ZVFsbqL0j4kNxb98RGihKJvWA4rsPQ9AJy24T7mGQA4MNanD8wbZ
         ZNgy+Fa0Z2MkS3oLVfhmugJ+srUA88MDavtZULPZZCF0vULH5BuuNr8sLMe/BYS3GlBP
         Oa6zL77194owmfJmbDSVRF6rMNwjv7GyDJvugaBhbpqutc45+lSrXVvpkd4hCbkEVTJt
         UlBrU9s1C1yX8wic7pMRnsd91Vhr+oFpwungTpZuWmwhprg4u2j1vPwG8Jepv4imE2Ej
         0aVw==
X-Gm-Message-State: AC+VfDzDufCk8Y0r/wp5qCFj69oz9PwlpZt0zdV2pogfsn1Pih/zpaKU
        k1BU51DzaQq6JFZk48caRZX/MkXk6m5JrXJmR9U=
X-Google-Smtp-Source: ACHHUZ4RrZ2jDtswLKaCj0fnZki2hZnq2/SjkuulDzrwAzt5AQ0csm9Szqg88Qbd1JMq0WDm3oSIw+qG0oM/7FZ2L8g=
X-Received: by 2002:a2e:9258:0:b0:2ac:dd01:e169 with SMTP id
 v24-20020a2e9258000000b002acdd01e169mr1370999ljg.40.1686086035161; Tue, 06
 Jun 2023 14:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230606035310.4026145-1-houtao@huaweicloud.com> <20230606035310.4026145-3-houtao@huaweicloud.com>
In-Reply-To: <20230606035310.4026145-3-houtao@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 6 Jun 2023 14:13:44 -0700
Message-ID: <CAADnVQJZc6iJiZ+axjXGKMSJa0ims9vYUc4vYQ7bdnOqgz5QfA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v4 2/3] selftests/bpf: Add benchmark for bpf
 memory allocator
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
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

On Mon, Jun 5, 2023 at 8:20=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> +static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long =
*value)
> +{
> +       char buf[32];
> +       int fd;
> +
> +       fd =3D openat(ctx.fd, name, O_RDONLY);
> +       if (fd < 0) {
> +               fprintf(stderr, "no %s\n", name);
> +               *value =3D 0;
> +               return;
> +       }
> +
> +       buf[sizeof(buf) - 1] =3D 0;
> +       read(fd, buf, sizeof(buf) - 1);

Please BPF CI. It's complaining about:

benchs/bench_htab_mem.c: In function =E2=80=98htab_mem_read_mem_cgrp_file=
=E2=80=99:
benchs/bench_htab_mem.c:290:2: error: ignoring return value of =E2=80=98rea=
d=E2=80=99,
declared with attribute warn_unused_result [-Werror=3Dunused-result]
290 | read(fd, buf, sizeof(buf) - 1);
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


> +       *value =3D strtoull(buf, NULL, 0);
> +
> +       close(fd);
> +}
> +
> +static void htab_mem_measure(struct bench_res *res)
> +{
> +       res->hits =3D atomic_swap(&ctx.skel->bss->loop_cnt, 0);

This is missing:
res->hits /=3D env.producer_cnt;

Doubling the number of producers should double the perf metric.
Like -p 4 should be half the speed of -p 8.
In an ideal situation, of course.
Without this normalization -p 1 vs -p 2 numbers are meaningless.
Runs with different numbers of producers cannot be compared.
