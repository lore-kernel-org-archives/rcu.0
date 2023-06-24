Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E3FEB64DA
	for <rcu@archiver.kernel.org>; Sat, 24 Jun 2023 03:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjFXD5j (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 23 Jun 2023 23:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjFXD5i (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 23 Jun 2023 23:57:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44D42706;
        Fri, 23 Jun 2023 20:57:37 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-988c495f35fso149138766b.1;
        Fri, 23 Jun 2023 20:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687579056; x=1690171056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8slvx4ZdUifVILZaRydBzNP8NZRy+01HQMzDAyD/y4=;
        b=kC3V2LqfM6h+TUo3RZ4xYsV378t99VXt4/8iQ4rTkWzEE7kPZh8Dz8SwGi2mrPp8kx
         jPYdp/ZCiHqXFEw2dBPfhkPo6D6667rGHAmf7+Y+yyB0dO6s+QXbPjj8we1TjY6K8Fj4
         GGMwFSefUGL01twEvNCvX2WA8qm4Giu5iN2O6jsEZlcnTHnyAOnB6XepEKFLswSJKAQi
         8b07XempeOXP/gibzbKpCvMh7xbjFOi0Eo/qAi7qiOc8QRn9fsi8VtRvlXKyXXNTaXg+
         nAS95NzSF3jILGE9Zgj22okTTQLrfUQmxgHn2+dOj2Ry6bQbojbJOtNs0WPz+ND/5DGC
         oSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687579056; x=1690171056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8slvx4ZdUifVILZaRydBzNP8NZRy+01HQMzDAyD/y4=;
        b=Kj+3zIcktlFp42o80KE5xXpMtPW8WGBMtSoim8OD2ZHxKZFC2T7yS5Hg/pqPLOC8hC
         p7Fp0k+OBwMAzxHvjs2ay8LCvX+xM77ZKLxRcz76narrK1ffMh1x3noePi5F00XO+wUk
         TKHnrAKHDChL3ZDrx2YRFk5Bkg6swW+Az23P0dH3zInosfV7XOC4DpsBSfgS3aPFhiXR
         UgZrJlGz8vh4yWXE08L+r/wBmEI5Yxvqsq/ymSY4QmdM5xjkrI1Rnpe0a9wp/EC+NY3J
         BqpjA3/fWd+acxUrbSU7WBodtypNWtEZgd0wjBFOZm/tcDjHQKYLr/QEvI2tISsmuFVk
         A1TQ==
X-Gm-Message-State: AC+VfDwqdpSP/r1+/L8lMSt1/Fa0BrW3gQFoNNtzjmMpM7/DLKOo2MYB
        3OSRzB6nhXxwVseeQbpXm3bBuGr/3mOh7H83cCs=
X-Google-Smtp-Source: ACHHUZ4+5pR6WXh4pJggKpGlYpyaZPlSheuUJGkgSxX5AJSZno+x9I9JDFj3J22FWQRoqJ/dJYeX7GSlzrUMuSXiimE=
X-Received: by 2002:a17:906:d185:b0:98d:76f8:217b with SMTP id
 c5-20020a170906d18500b0098d76f8217bmr2571441ejz.73.1687579055778; Fri, 23 Jun
 2023 20:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
 <20230621023238.87079-8-alexei.starovoitov@gmail.com> <280a8fd5-6bc6-7924-30e3-412d5bc3c3e0@huaweicloud.com>
 <CAADnVQ+ROd__AXmHcUTy3j8zYL7zr6brA3swS9P6OmN_2BwcrQ@mail.gmail.com> <73ca4152-a197-5744-1950-25c294b5b865@huaweicloud.com>
In-Reply-To: <73ca4152-a197-5744-1950-25c294b5b865@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 23 Jun 2023 20:57:24 -0700
Message-ID: <CAADnVQKdkkeaxdwx7Tw0eTnD3Lsp9do6S2LN=iEHukj_Q=pZig@mail.gmail.com>
Subject: Re: [PATCH bpf-next 07/12] bpf: Add a hint to allocated objects.
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Vernet <void@manifault.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        rcu@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jun 23, 2023 at 8:54=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 6/24/2023 11:42 AM, Alexei Starovoitov wrote:
> > On Fri, Jun 23, 2023 at 8:28=E2=80=AFPM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >>>                */
> >>> -             obj =3D __llist_del_first(&c->free_by_rcu_ttrace);
> >>> +             obj =3D llist_del_first(&c->free_by_rcu_ttrace);
> >> According to the comments in llist.h, when there are concurrent
> >> llist_del_first() and llist_del_all() operations, locking is needed.
> > Good question.
> > 1. When only one cpu is doing llist_del_first() locking is not needed.
> >  This is the case here. Only this cpu is doing llist_del_first() from t=
his 'c'.
> > 2. The comments doesn't mention it, but llist_del_first() is ok on
> > multiple cpus if ABA problem is addressed by other means.
> Haven't checked the implementation details of lockless list. Will do
> that later. "by other means" do you mean RCU ? because the reuse will be
> possible only after one RCU GP.

Right. Like RCU, but that's if we go that route in future patches.
We're at 1 =3D=3D only one cpu is doing llist_del_first.

> > PS
> > please trim your replies.
> Sorry for the inconvenience. Will do next time.
>
>
