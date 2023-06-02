Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F74EC7EE29
	for <rcu@archiver.kernel.org>; Fri,  2 Jun 2023 23:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbjFBXAO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 2 Jun 2023 19:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjFBXAN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 2 Jun 2023 19:00:13 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9521C1B9
        for <rcu@vger.kernel.org>; Fri,  2 Jun 2023 16:00:12 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-565eaf83853so27590087b3.3
        for <rcu@vger.kernel.org>; Fri, 02 Jun 2023 16:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1685746812; x=1688338812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gu/jJLV8GpS/4k+cydSglYZByXG+Mppg0bGRw+veAQc=;
        b=n+CVYF4Tuyyz/8u1854NGgzFqK5+hUef0fmwxGv2HJN3YW2ncq7KUfOZtLVyt2Efjg
         ZqIH+8nJOy02Yx0oIhY2rAU163b5YoDfMVgkNLj1GxSlBRwAIFKUTm2rDlxmaOJVIVbn
         WVfEVco94qRLBkhImari5ahpts/h9FR2UvMhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685746812; x=1688338812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gu/jJLV8GpS/4k+cydSglYZByXG+Mppg0bGRw+veAQc=;
        b=PGVt6CtLT2+VH93N/FhO9wCK63ss5cBv8l4+9nBZKEQ2Eobs9vyWPduU7mZisoI2Xf
         FYuDdOwty5GxBc7yBIRI9J13lfSm9u/xjY83eHkpHYVnvGXEUZ7ngnB51aj99FaAcp95
         +M1zXrLuRWQ0nIYVptCDVWwgluWPuLY7RrG4vM1iNo4PbPzmUq1rh+hrQ/NUlSpza/N5
         SnWTozUwukl5z+Y1hWA3Ly49oFKpJRraKHxNrBR2qKmL1jmVbVmC+zngWXLGIA+ERXo9
         lQkh8Ch4flVtCMqfDILty/dtDhhVpjK4O77M7oo5UEKgXlytWiP8UiGYKx08jL6Gt8Oc
         2IWA==
X-Gm-Message-State: AC+VfDzubF1lAa/F2/WwDg40KSzN7O77zdNUMmI40vm3xIPWAsVvFPZI
        TFFys/vuvdK5FQgCmCFfmHhpW8x84AzarSps21WmRw==
X-Google-Smtp-Source: ACHHUZ7k1w3VVHVPdfiggFFlDnugb+v5ibHwqQOyIcWLvl8GAKysKHCP5O4HvLB/GxwUgYVFDhQSBF3IISry1VPotqc=
X-Received: by 2002:a0d:f405:0:b0:559:fad8:322f with SMTP id
 d5-20020a0df405000000b00559fad8322fmr1677466ywf.24.1685746811742; Fri, 02 Jun
 2023 16:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230531101736.12981-1-frederic@kernel.org> <20230531101736.12981-3-frederic@kernel.org>
In-Reply-To: <20230531101736.12981-3-frederic@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 2 Jun 2023 19:00:00 -0400
Message-ID: <CAEXW_YQhufHtuNc5stZQpBY8JSd99NVWEzqv=-QbeMFOA-vDnQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] rcu: Use rcu_segcblist_segempty() instead of open
 coding it
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, May 31, 2023 at 6:17=E2=80=AFAM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> This makes the code more readable.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/rcu_segcblist.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index f71fac422c8f..1693ea22ef1b 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -368,7 +368,7 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rscl=
p,
>         smp_mb(); /* Ensure counts are updated before callback is entrain=
ed. */
>         rhp->next =3D NULL;
>         for (i =3D RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
> -               if (rsclp->tails[i] !=3D rsclp->tails[i - 1])
> +               if (!rcu_segcblist_segempty(rsclp, i))

Hopefully the compiler optimizer will be smart enough to remove this
from the inlined code ;-):
if (seg =3D=3D RCU_DONE_TAIL)
   return &rsclp->head =3D=3D rsclp->tails[RCU_DONE_TAIL];

Otherwise it appears to be no functional change for this and the below
change, and straightforward so for this patch:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


>                         break;
>         rcu_segcblist_inc_seglen(rsclp, i);
>         WRITE_ONCE(*rsclp->tails[i], rhp);
> @@ -551,7 +551,7 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *r=
sclp, unsigned long seq)
>          * as their ->gp_seq[] grace-period completion sequence number.
>          */
>         for (i =3D RCU_NEXT_READY_TAIL; i > RCU_DONE_TAIL; i--)
> -               if (rsclp->tails[i] !=3D rsclp->tails[i - 1] &&
> +               if (!rcu_segcblist_segempty(rsclp, i) &&
>                     ULONG_CMP_LT(rsclp->gp_seq[i], seq))
>                         break;
>
> --
> 2.40.1
>
