Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85CEEB64D8
	for <rcu@archiver.kernel.org>; Tue, 20 Jun 2023 17:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjFTRzo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Jun 2023 13:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjFTRzn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Jun 2023 13:55:43 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3886E1739
        for <rcu@vger.kernel.org>; Tue, 20 Jun 2023 10:55:41 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5700b37da3fso45638067b3.1
        for <rcu@vger.kernel.org>; Tue, 20 Jun 2023 10:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687283740; x=1689875740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNKXcZ39Z10NVBkiTIhQmIoTjYz8PY/jDnJTeB9TmWc=;
        b=UFHcVNRgkeY635daGhoi/fIQLSvF6t6kSDruzQUr6UZvI1enwmwkKlT4X+XSSqYI13
         JYV+8g2dudsKX/RZ0x+TweL08U4d1TiqHhVJbY4N4t996nceoVzkw3MBfKL7JvmuXdVc
         jV02HfWoztqcCu7rAv1mOym4MgDqC6tnlrsQEqWAUcvevZOyP/8STcyUn/nA4Cz377Qg
         tF3v8LCK+ihuPIFFJJxJTEjxK57FfZPl6vqsi2wGeG+FzRGy8zvx87yYr2B0jYlqeUL4
         PiuA4UBhyBVBx6564O3T3tfiWATuPqvVeoFXJ/NSAy4IyAX45q2aWw2kMxPooKB7Wrvs
         oOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687283740; x=1689875740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNKXcZ39Z10NVBkiTIhQmIoTjYz8PY/jDnJTeB9TmWc=;
        b=aYA/40n9I8vdsH6St+klR3hc9i8DoPAaKoxqCfePs5FZwyw7UI6xpKpO2nFMVfy1xY
         6cJae8ywgO16MdyU18M0+2jiVFNA0E8pilxBRf8S8oOLNzKPAH3UGVBCxYotw6S3tYQP
         9bpRfCIkm6tCnXP73vWesm5AwvhpHIPeChAyZDrBnjAHYR/HJdCzBpEp2Y+o37N/M5g5
         2pdO/K5FquW6CATrDv5VpSQuibWxF/p09rpomglfm8SjvcHTTPKm9OvpLvuo2sdnUbNN
         SvKa5nCIPIOr50x8orD+OVTlaesiGasf46wF6Jmg9dIYqdsjY+COadAb/lqMm/7cPom+
         ZhjQ==
X-Gm-Message-State: AC+VfDx8mUiuX8xhhFQ5ry2eDCc8RZaWmyDP7zOseppEhFZ3XtPg9F7N
        tMtKQXiJcN7BqL0PM7D7vS+26/ySvc894oyfPNOLxQ==
X-Google-Smtp-Source: ACHHUZ4kFhYGq1McBHCrKGBedUf2xwnSf+RXgEGL3EzRFdNA+PwrVJgxb55iiZYNwNR7iwv3SzyxB835GCQeBrcfSkg=
X-Received: by 2002:a25:2e0c:0:b0:bc3:843a:953a with SMTP id
 u12-20020a252e0c000000b00bc3843a953amr8727613ybu.18.1687283740311; Tue, 20
 Jun 2023 10:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230614013548.1382385-1-surenb@google.com> <20230614013548.1382385-3-surenb@google.com>
 <2023061925-overact-flakily-9830@gregkh>
In-Reply-To: <2023061925-overact-flakily-9830@gregkh>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 20 Jun 2023 10:55:29 -0700
Message-ID: <CAJuCfpHWpmLGjBTRAAtSiPSo=q273j7qRGXCt+bZ2qyHOP9x8A@mail.gmail.com>
Subject: Re: [RESEND 1/1] linux-6.1/rcu/kvfree: Avoid freeing new kfree_rcu()
 memory after old grace period
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, urezki@gmail.com,
        oleksiy.avramchenko@sony.com, ziwei.dai@unisoc.com,
        quic_mojha@quicinc.com, paulmck@kernel.org, wufangsuo@gmail.com,
        rcu@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Jun 18, 2023 at 11:21=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Jun 13, 2023 at 06:35:47PM -0700, Suren Baghdasaryan wrote:
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> >
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
>
> That's not the author of this commit, where did it come from?

True, that's the author of the backport. The commit author is Ziwei
Dai <ziwei.dai@unisoc.com>

>
> confused,
>
> greg k-h
