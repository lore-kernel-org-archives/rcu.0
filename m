Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E82DEB64D7
	for <rcu@archiver.kernel.org>; Wed, 28 Jun 2023 19:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjF1TAy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jun 2023 15:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjF1S7q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jun 2023 14:59:46 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE34294E;
        Wed, 28 Jun 2023 11:58:37 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b69e6cce7dso2341521fa.2;
        Wed, 28 Jun 2023 11:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687978716; x=1690570716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Pp3/6WHOX3IhCc8i+jwBDxBIWCrCEEZYNsbdhw2Vzw=;
        b=kgOuC/NLgkBG5JldvkeV+tBAlM+B9NFfIH9O4aGGaoBZOE7oc66SQJLaHj4ERhZmPh
         wZkOTTHK4PUL3fItkOi/fSIL8JsWCynhWfUwNY8HAPdwPGwQjSf+ZCYAalC+PGFBx67I
         c782945YUvOPTn4d3EbeDqip024QyN/U0c7GUwuIlmkYIELt8P8NTExxXd0wG0RN2ZPS
         Ui12zouCNxytvV4F2ii6kbh0JxyC/VKLle2p9QjFc0nweyHbZUpFNCCUjL3gOlu8BsSM
         lcNh4Q8N3gTbq+dvcIa/ProtpWjm3QbOXLXepNI0Uqa+DKDju3SgcBwvXLdVScQYWE1k
         ESyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687978716; x=1690570716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Pp3/6WHOX3IhCc8i+jwBDxBIWCrCEEZYNsbdhw2Vzw=;
        b=ckoHKplD25HvgYMRpiMst9E6LxhmkB2rGA6JDXlnKrlkx9CpcAMCROEWz0+kDGWr6W
         PLyS3oXmVlTo48GdGV2AdXTXQp7NX+qxNcDjlaFOV9Ir+OUij2dSKqzhS45sTXeky5yO
         jmLgAVfADptKKhPCy5xRj+XcrX/ycwICxkgMgE8g8DsWr8jX8rNyyw6HmPJV6LYqCeKm
         zuP+SxM9BnVW+gJWZqiMMSVnfqiC29lr+SLqPSYePhOT9BH+tlkaFkMJzrXYTxjFYRjo
         2k0/kkKkky+hyJ5TTUTBExBz0efoMGiIvW8e7ESAhN8rNxz+gUuTqSRb8xL3/SW0rrlg
         FFBw==
X-Gm-Message-State: AC+VfDwDfXha6uqh8HD5K9ZyDQN5juiIWcVlBxAw32O2X4nbkm7ZT28c
        olb0I4LwJerGPVk6boJchLwrp0WvpkKE5x4xrz4Plm+k
X-Google-Smtp-Source: ACHHUZ7MgzQGhT0lFe9/3LXZJAkDu1+MCARStQWQGqvkRxaBkspbafFeITgCyHqIpUd1CzkmIcfYTn4jCt/lmfkPKu0=
X-Received: by 2002:a2e:8443:0:b0:2b1:edfe:8171 with SMTP id
 u3-20020a2e8443000000b002b1edfe8171mr21883013ljh.36.1687978715441; Wed, 28
 Jun 2023 11:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
 <20230628015634.33193-7-alexei.starovoitov@gmail.com> <ZJxWR9SZ5lya+MN+@corigine.com>
In-Reply-To: <ZJxWR9SZ5lya+MN+@corigine.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 28 Jun 2023 11:58:23 -0700
Message-ID: <CAADnVQJcQif0ZvOeF4YD+KzR3Vp85qL=K=eyKkUvFhc4G_pgoA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 06/13] bpf: Further refactor alloc_bulk().
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Vernet <void@manifault.com>,
        Hou Tao <houtao@huaweicloud.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        rcu@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jun 28, 2023 at 8:48=E2=80=AFAM Simon Horman <simon.horman@corigine=
.com> wrote:
>
> On Tue, Jun 27, 2023 at 06:56:27PM -0700, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > In certain scenarios alloc_bulk() migth be taking free objects mainly f=
rom
>
> Hi Alexi,
>
> checkpatch --codespell flags: 'migth' -> 'might'
> It also flags some typos in several other patches in this series.
> But it seems silly to flag them individually. So I'll leave this topic he=
re.

Thanks for flagging.
Did you find this manually? bpf/netdev CI doesn't report such things.
