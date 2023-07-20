Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FF4EB64DA
	for <rcu@archiver.kernel.org>; Thu, 20 Jul 2023 19:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjGTTWl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 20 Jul 2023 15:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGTTWk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 20 Jul 2023 15:22:40 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77861724
        for <rcu@vger.kernel.org>; Thu, 20 Jul 2023 12:22:39 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40371070eb7so69181cf.1
        for <rcu@vger.kernel.org>; Thu, 20 Jul 2023 12:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689880959; x=1690485759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IacBuQPmaTbg0zMPyJfZlxsv5lt3ViODtkIRDulzhHs=;
        b=E/1t3ntk/ROfOq0NxRVzaZGOQmS0fbflKbT5fuUtIrEPWVe0msQz4PFZdmoKFgoT+K
         4hdX+Vr+qjYB/H18OSNxVOeX+fnRWnwnauDd01Wdvzy07Ih88dpkXC17UPwwt3Uajxg+
         OOCiBtSo+KvcPWxuzYHJ2+D9XcSMuhwBLf0RYWW5lwMyzGZIDyfdxoDNA9fygY0yW4Ky
         oWbiHGY/k8ALT7xqHaZRqdYzMB49y9lH0cg5qejymAa01RK3tZpszbJvgZblNhFd9VdV
         2/HdHxEKMGWwcg7BsBhlPoZKHTQc5W2hdO51RwBzDQJ6TOA7/+MNQu76+XIA+FMvOiVE
         tQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689880959; x=1690485759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IacBuQPmaTbg0zMPyJfZlxsv5lt3ViODtkIRDulzhHs=;
        b=DTgSbiSzDAIFwRz5EyKQwfQR4re8ZCPm8CMH3WEd52K42PNCA2+sGjA4ynO4OGpxqW
         8qM7tFhKY+2P0ejc8slRVq+sCIxlTVPN29d7/EmFU3X4gPhcVZIA3h+7MWcf190Hr6tc
         67Smaayj5jcFPn+vSb+L7rV+O1tzlFYbnaCQ//RZMNJ14WbJzVJJSdGBARSbFZv2uT2n
         FcJFasm6v6LYOMl1utO0xCZOIfKQ8Fb1f0uVFmpA2Dfu6ePrTYwGbZLo/2dDej9PSfyx
         lZXGN1qYQkxH1GhMyW8cafvcssNF4jgDqkQRsTtUvt5W2YCJGwJundyoCl8lCCDicU/e
         ILSg==
X-Gm-Message-State: ABy/qLZqvo6IW9ISzcfT5Q1JWf06fe3h7GO3XnojjZCxTNrvhvnugHGz
        4YlB/5TgepQrpAgbTZj6U6MXZyv4TF5TAS534/V0MJIrUfnfwhaURf4=
X-Google-Smtp-Source: APBJJlHr3QDZlQT/T2FTm6Y0rEg87Rb8pyQFJApkDLa5645mm6jQKvaBY3GDo3mFWO1c+f+tQBuX9l568tX79MbGhfU=
X-Received: by 2002:a05:622a:14c7:b0:3f8:5b2:aef0 with SMTP id
 u7-20020a05622a14c700b003f805b2aef0mr36407qtx.24.1689880958746; Thu, 20 Jul
 2023 12:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <04C1E631-725C-47AD-9914-25D5CE04DFF4@gmail.com>
In-Reply-To: <04C1E631-725C-47AD-9914-25D5CE04DFF4@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 20 Jul 2023 21:22:27 +0200
Message-ID: <CANn89iKJWw7zUP-E_d=Yhaz=Qw0R3Ae7ULaGgrtsi1yf2pfpGg@mail.gmail.com>
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        roman.gushchin@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 20, 2023 at 8:54=E2=80=AFPM Alan Huang <mmpgouride@gmail.com> w=
rote:
>
> Hi,
>
> I noticed a commit c87a124a5d5e(=E2=80=9Cnet: force a reload of first ite=
m in hlist_nulls_for_each_entry_rcu=E2=80=9D)
> and a related discussion [1].
>
> After reading the whole discussion, it seems like that ptr->field was cac=
hed by gcc even with the deprecated
> ACCESS_ONCE(), so my question is:
>
>         Is that a compiler bug? If so, has this bug been fixed today, ten=
 years later?
>
>         What about READ_ONCE(ptr->field)?

Make sure sparse is happy.

Do you have a patch for review ?


>
>
> [1] https://lore.kernel.org/all/1369699930.3301.494.camel@edumazet-glapto=
p/
>
> Thanks,
> Alan
