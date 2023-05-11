Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E23C77B7C
	for <rcu@archiver.kernel.org>; Thu, 11 May 2023 05:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjEKF0j (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 11 May 2023 01:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjEKF0i (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 11 May 2023 01:26:38 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FD84498
        for <rcu@vger.kernel.org>; Wed, 10 May 2023 22:26:36 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-ba1911d60f5so12022810276.2
        for <rcu@vger.kernel.org>; Wed, 10 May 2023 22:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1683782796; x=1686374796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7yTENVyOqFjUfzaGJwWt+oOgBMebhIk0NqAg6/+aCg=;
        b=E3fqH+C1TZNntj8XWs7Ld78+jxI7qMTtnccB5OVdHIipQZe02qJRykfjXf3ciqoyQd
         iwuNgbfoH9bDnGMTiXO+5Xulm42HNjAjIftdKiHXRqH1kWCBGImuAb45Kx0wlV+gC5ea
         jGHjsEU/2l00dJ600ly9uY08OnOCrTdWTIFxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683782796; x=1686374796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7yTENVyOqFjUfzaGJwWt+oOgBMebhIk0NqAg6/+aCg=;
        b=bSmJ6OZ5kG9J9QCY7LwZcHA+BR+qhOT16+RjCuEknuk9GHx+e4lee/sy3Vp6EPi/mQ
         qi8i77HX20Ic4XsSa1xiGBkBKDHSyPgCuilaAFXNJ6Fy+nzYv2Ks77CrkTQhktlKYRsg
         0XbanFg94KMfOjmnnuCdDkrYUGxuL3Y7sw3M/Zc6MMWDlbPkYdk+RrE34T6JujXEnoc/
         1B71fA4CMre2mQk6Uk/fcaqPLSjdTzkKj0b8ew1oqRfFLlE0WQ/KDp61pQPp3B3r08/l
         neITsZjidjlFrGppJgZsnN5ElPcjZSWIzT5eSWO10cS0MWoCQ4ky8ea80kLRqj86FimZ
         Q8Gg==
X-Gm-Message-State: AC+VfDy1PtfKAaKWYIsUpdwoHWvz6N0dvy5ER5XBNTeO9g7AXFHR5XBh
        F2hirsdIoIklf4+iCq7bgTRtEiiCObGTuLGJGDqMm4zfB8uVsnV0mxs=
X-Google-Smtp-Source: ACHHUZ4ntDzdE8uBKO3utIIAtwq/ZLfBZlZzrpxFAD3yE0ohaVJvDEWtv7oPkHqvfIZt+Fa2i56UMm+7j+o9FilwBs8=
X-Received: by 2002:a25:d187:0:b0:b9e:917c:c8ba with SMTP id
 i129-20020a25d187000000b00b9e917cc8bamr20142971ybg.10.1683782795792; Wed, 10
 May 2023 22:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop> <20230510171238.2189921-6-paulmck@kernel.org>
In-Reply-To: <20230510171238.2189921-6-paulmck@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 10 May 2023 22:26:24 -0700
Message-ID: <CAEXW_YRRMfbfXJwCA89hD_VCpbxR8AoEvv9xzrX=W_4Ffi-g2A@mail.gmail.com>
Subject: Re: [PATCH rcu 6/6] torture: Remove duplicated argument -enable-kvm
 for ppc64
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Zhouyi Zhou <zhouzhouyi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, May 10, 2023 at 10:13=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
>
> The qemu argument -enable-kvm is duplicated because the qemu_args bash
> variable in kvm-test-1-run.sh has already provides it.  This commit

drop the has.

 - Joel

> therefore removes the ppc64-specific copy in functions.sh.
>
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  tools/testing/selftests/rcutorture/bin/functions.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/=
testing/selftests/rcutorture/bin/functions.sh
> index b52d5069563c..48b9147e8c91 100644
> --- a/tools/testing/selftests/rcutorture/bin/functions.sh
> +++ b/tools/testing/selftests/rcutorture/bin/functions.sh
> @@ -250,7 +250,7 @@ identify_qemu_args () {
>                 echo -machine virt,gic-version=3Dhost -cpu host
>                 ;;
>         qemu-system-ppc64)
> -               echo -enable-kvm -M pseries -nodefaults
> +               echo -M pseries -nodefaults
>                 echo -device spapr-vscsi
>                 if test -n "$TORTURE_QEMU_INTERACTIVE" -a -n "$TORTURE_QE=
MU_MAC"
>                 then
> --
> 2.40.1
>
