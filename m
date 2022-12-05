Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E7BC4332F
	for <rcu@archiver.kernel.org>; Mon,  5 Dec 2022 16:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiLEQ6v (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 5 Dec 2022 11:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiLEQ6u (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 5 Dec 2022 11:58:50 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54B8DEB6
        for <rcu@vger.kernel.org>; Mon,  5 Dec 2022 08:58:48 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-381662c78a9so124627247b3.7
        for <rcu@vger.kernel.org>; Mon, 05 Dec 2022 08:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b4FnVG9CvMwOaoefk8RFLw+V3FPIDJ4g0+liDDmbBrU=;
        b=b16PKuFraMFTSNgbojgdPURSbayXPJPy05u+7irwPt3hjOo2RnVqEnYsJzaNZ3m3ZF
         URU4m0IWCfslMjoaITU0pqwYhuy6n4hpJCmS12nKpKA6/0slBZMcxXYS3/kyia4zvIvZ
         iv44HSLOjjGdM3mAZWC5RlmeAZXW0KujEJb4QIrt4xtKuTIeMI89hQIu2V+wGuD4Hh5O
         JO9TbbLmL7/TnILGLCrpL6pwl/jrxeoi97IX022mTPrDECKlZd9k5KF87U8nuip4Nv3r
         NAXj9677nzbeDkSsIRGuLJxn2WsI0T2YcgDXwybPC635zh+mKaO9Xxtpa9yyYA8+M0l7
         yd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4FnVG9CvMwOaoefk8RFLw+V3FPIDJ4g0+liDDmbBrU=;
        b=IWKApms4E36BMqaFfF/nTtcn1txmJE1VifgY1Qc9XorzrsfMmfFx/C9m6bRPGCZIUE
         ziB47gdv8dqQjxCx/qs4s5ZDk4F1nlMaZ6Q0YRDs4PqkFXCNxQXrNPfYaltw9yAob5VR
         7HIMDBkS+tOPCqUdzzQmIQvhKwmzej+qPjDPEIDxXE01M5ShB9c460+MmM9vDlmScMZ1
         q4DXaISfWb3OKWbtZwIAsat3nZH5J9JSyAYXfnuZBscCq86vMIRmZuDsO2N1UCh9dsHE
         RltpTrwnKLu2J0egI70Jf/lgiNJExuXDhXBvURqbHNxT297Yn17ujGQRF9yx4U2fFKik
         ycyw==
X-Gm-Message-State: ANoB5pl1CC5lx9HscYgxqIi5uCsTf/FC6vcenJwmeLPPk7QNhktHB098
        ZcPKd6D4xGlHKvR5yWs2apHeWCxvkas8lF1LAsR5qw==
X-Google-Smtp-Source: AA0mqf5v9z+tJTtp/2qQCCKuXN5ds2ulIeWtJJjdQX1jUtI6Usl9dtaZk2dTlf0TUssF27sy9yTFT40I1+4zE71+ZSE=
X-Received: by 2002:a81:d87:0:b0:393:ab0b:5a31 with SMTP id
 129-20020a810d87000000b00393ab0b5a31mr11266197ywn.55.1670259527617; Mon, 05
 Dec 2022 08:58:47 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YRW+ZprkN7nE1yJK_g6UhsWBWGUVfzW+gFnjKabgevZWg@mail.gmail.com>
 <21A10014-22D8-4107-8C6C-14102478D19B@joelfernandes.org> <Y43RXNu0cck6wo/0@pc636>
 <CANn89i+RNj0gaJCyNUyrMBpSTsxSgjW1YN_FuRW_pMUOMiQtuQ@mail.gmail.com> <Y44HNfuR5OgfEXxV@pc636>
In-Reply-To: <Y44HNfuR5OgfEXxV@pc636>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 5 Dec 2022 17:58:36 +0100
Message-ID: <CANn89i+8Au1+Wa_F0QGAz2zfA7UYcCF_9a0BqCpdAqMOrNVbsw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: use 2-arg optimal variant of kfree_rcu()
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     paulmck@kernel.org, "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        eric.dumazet@gmail.com, Dmitry Safonov <dima@arista.com>,
        rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Dec 5, 2022 at 3:59 PM Uladzislau Rezki <urezki@gmail.com> wrote:

> So it was a typo then. How did you identify that BUG? Simple go through
> the code? Or some test coverage?

Code review. I am the TCP maintainer, in case you do not know.

>
> Thank you!
>
> --
> Uladzislau Rezki
