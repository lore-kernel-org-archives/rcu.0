Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F42C88CB8
	for <rcu@archiver.kernel.org>; Tue, 13 Jun 2023 00:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjFMAKW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Jun 2023 20:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238402AbjFMAKV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Jun 2023 20:10:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1289B1713;
        Mon, 12 Jun 2023 17:10:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5184abe9e86so1400491a12.0;
        Mon, 12 Jun 2023 17:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686615018; x=1689207018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQJnDcH0ALLV/E56p3jRM/MO9BHs7ZbnbRxpSd3Nmbs=;
        b=prfFHzHlf9cW54g09kfm0XysBjfLfuBcm2DiD257jQCU/meqs2iWi4df9I4iAExOAR
         f9yGmYSYNrRIn5Gjia3vxfmFKR6NiO9Ei6XDpVzqE6dkBrcjojQgD46Q5pWrvIQhcOgW
         gAQOIstuxBtucDCqrtvMD16dx1vVbFn03ceaN7VbpGSIsOmdZPAjkonYfvmUOgyQlEVU
         63VCiY26WOKUek09qsdOE+nKznii2IDN9A1gNbvl8VEHZ47Tgy0kBX8+loWAVojr2owj
         ubCuZdW8BqMWgSlojjcIrRed6ggqKNtQiuBEuS0rQMBitKdF/YHk6pO60vdVpqTNiz9+
         JCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686615018; x=1689207018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQJnDcH0ALLV/E56p3jRM/MO9BHs7ZbnbRxpSd3Nmbs=;
        b=cZZrR15MuQP7lhmTvwWsWTWlUxrP1eyow5KqI/NB/uxM3ueN2OVWibbapoSytEt71t
         eFtpUlRRFHEkMkPS7EMEygHZrKEWECtGsZgzCQoew0rrtIx4uUHku2jdDCWTKifIT8ry
         IAMw6lMVurcToN0sE7a3i9f63tmihebF70gQ3nozF1WnfYpfNrvvF4yqw2b+ZcM4FEdE
         9Q8So8/GmT7KGWgVcoqwAzc0fcmzTAHQR2vb9t+6LYBx8VSifMb/IHznQp4wg9dHH52R
         8ZF6JivctpuNOxjfs6JNGuhcYaJbadL23S91HVBiZ5bS+yZuh/DTU38nqeiKjoPcPeX3
         TBjw==
X-Gm-Message-State: AC+VfDyahgwCCZqIYNvgLnGByNaSuyAqx24qtq6eRGCKRxGNgLBoRobg
        aPbzPqFA9ANYG28+z+qsHqCqa3ayE6rcHZlk+tA=
X-Google-Smtp-Source: ACHHUZ5dLMN/F0aDh7JXJCID1hzj3u/ItiBttwDZ3LBACbID7aXcxkf9BuWLfULUh1yDoRo0ohhKXWbPy0ifHT6POyY=
X-Received: by 2002:a17:906:6a29:b0:97c:b6e6:f36a with SMTP id
 qw41-20020a1709066a2900b0097cb6e6f36amr8062515ejc.62.1686615018429; Mon, 12
 Jun 2023 17:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230609024030.2585058-1-houtao@huaweicloud.com>
 <20230609031907.5yt7pnnynrawjzht@MacBook-Pro-8.local> <7e1ed3f0-f6b1-a022-d7c5-055a80deb606@huaweicloud.com>
 <CAADnVQK-e9Y0gNyDUu6kZ4K9P0UXLdkwhvWT_iEhxJeB5JSAyg@mail.gmail.com>
 <CAEf4BzY7+mcADa1SUDMpVNbdo2aakSkHv4HU3ENgFfrg+7BNPQ@mail.gmail.com> <CAADnVQKBm7cYAwYtimPaPf_m7TAhf4SXajfuCcLo7DJ+6EXjGg@mail.gmail.com>
In-Reply-To: <CAADnVQKBm7cYAwYtimPaPf_m7TAhf4SXajfuCcLo7DJ+6EXjGg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Jun 2023 17:10:06 -0700
Message-ID: <CAEf4Bzax=zdncGuNa_+AusYywxqNfSMmTERg_geP60UOm9oGkg@mail.gmail.com>
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

On Mon, Jun 12, 2023 at 4:38=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jun 12, 2023 at 4:17=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jun 9, 2023 at 9:12=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Jun 8, 2023 at 11:32=E2=80=AFPM Hou Tao <houtao@huaweicloud.c=
om> wrote:
> > > >
> > > > >
> > > > >> +                    --producers=3D8 --prod-affinity=3D0-7 "$@")=
"
> > > > > -a -p 8 should just work.
> > > > > No need to pick specific cpus.
> > > > No. For VM with only 8 CPUs, the affinity of the first producer wil=
l be
> > > > CPU 1 and the affinity of the last producer will be CPU 8, so the
> > > > benchmark will fail to run. But I think I can fix it, so the affini=
ty of
> > > > the last producer will be 0 instead.
> > >
> > > Right. Noticed that too.
> > > That should probably be a separate patch to fix this cpu assignment
> > > issue in bench for all benchs.
> > >
> > > Andrii,
> > > when you wrote it did you really mean to start assigning cpus from 1
> > > or that was just an oversight?
> >
> >   616 =E2=96=B8       /* unless explicit producer CPU list is specified=
, continue after=C2=AC
> >   617 =E2=96=B8        * last consumer CPU=C2=AC
> >   618 =E2=96=B8        */=C2=AC
> >
> >
> > It's been a while, but it seems like each consumer gets its CPU first,
> > then each producer. So yeah, seems intentional.
> >
> > For context, this was done for BPF ringbuf benchmarking, so by default
> > I wanted to separate a single consumer from multiple producers.
>
> I see. In this cas Hou's bench has empty consumer:
> +static void *htab_mem_consumer(void *arg)
> +{
> +       return NULL;
> +}
>
> but setup_benchmark() still creates an instant 'return NULL' thread
> and pins it to cpu 0.
>
> I guess the fix is for htab-mem bench to set env.consumer_cnt =3D 0
> at init time and don't supply empty consumer at all.
>
> May be consumer_cnt=3D0 can a default and ringbuf bench will just the
> default to 1?

makes sense
