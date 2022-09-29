Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2131C04A95
	for <rcu@archiver.kernel.org>; Thu, 29 Sep 2022 08:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiI2IVQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Sep 2022 04:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiI2IVP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Sep 2022 04:21:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1894012BD9D
        for <rcu@vger.kernel.org>; Thu, 29 Sep 2022 01:21:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i26so1106221lfp.11
        for <rcu@vger.kernel.org>; Thu, 29 Sep 2022 01:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=F844Qpv8K4RKvtptNO/e3cT38Iah+kTwHUnF9Qn+Frs=;
        b=DAkWPAXOeyAgdRKLqT2/bTHfNckiie/MlRR419uOWtkXfRo0KDr6/3/2U0WN6+xDIC
         xnBsuREiLs7FMXRxRBOt1lBx/dyjg3gPRab0AHSmMzTHFURm9WKOcOPZETdNXwiJD9jU
         y2qbcTyJUTuu0c7KYMOa45jNbjbfr6AgnZ6h6bzK0jUDD1r07ShwvNwCJbdIwVi0Khpf
         f29PrdrESxvDdhwW9ra2paD9g6jsa+LSADBgiEUkj+ljzxQz23M7SZuqQ5quobY6Qvqt
         Ldxldov2nJgpFyhDKvRFmJvQpo+1oOC1nUhEbWpwW0PSnda+GLLPnPKJCNQZAOneCfpP
         b5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=F844Qpv8K4RKvtptNO/e3cT38Iah+kTwHUnF9Qn+Frs=;
        b=kG57IkfqwOoQQU3vbEZBDKreddheH4FTx46NRrNjfudLxMC9Ufd4nmRgPZsoDtMroT
         VufF7DkR64nC1cUdqv7zEEbsb4Y09QTvoTqoMjyt0qVrSS/v7pul1XhJdudr/EAl5yrp
         +IEcCaxnznD5uX9eebRQWCabacrsNkkY1KU9t5edIZpCPf68VFMU26k15uzGWQaGzWi8
         cifEk1zn8QbMFjjabBm997XWhu14SgXuIUWBBEFIXgY8tKksdz++30LOv0oZpFl99fQp
         rtqErnXgMU9iRONfHLEIDLi0l3y4FW5QV0k51Wekk4ckeZEupAdbuEDC88gVNxIPA6eY
         mbQg==
X-Gm-Message-State: ACrzQf3T2ahaZhHeeUZsstzMwCNa7GvH5/iFzhqlXGIpanEBrj+0Apjt
        O51HdRO9GW6Yl0e1Fz9LRmv8frHYSesuVdu0yw==
X-Google-Smtp-Source: AMsMyM7e4xg5tjnVuItp0hsgOZ+rqb32vUi9A8Gqd1ZxqijhPh3YgjemAshrtNucNcr6jMqVG+iDXPBkUN859YeMZaM=
X-Received: by 2002:ac2:4422:0:b0:49f:5c95:9525 with SMTP id
 w2-20020ac24422000000b0049f5c959525mr945828lfl.1.1664439668359; Thu, 29 Sep
 2022 01:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220915055825.21525-1-kernelfans@gmail.com> <20220915055825.21525-4-kernelfans@gmail.com>
 <20220916134258.GB25891@lothringen> <YylrJCjYPrcT6xKJ@piliu.users.ipa.redhat.com>
 <20220920094645.GG69891@lothringen> <20220920191339.GS4196@paulmck-ThinkPad-P17-Gen-1>
 <Yywq/AtA5DN6J5+6@piliu.users.ipa.redhat.com> <20220922135442.GH4196@paulmck-ThinkPad-P17-Gen-1>
 <YzFH6WSMX/Yht+i1@piliu.users.ipa.redhat.com> <20220926222352.GV4196@paulmck-ThinkPad-P17-Gen-1>
 <YzLJZU2mAPjfD/RK@piliu.users.ipa.redhat.com> <CAFgQCTtLm-JXRyQfKo6-+P00SShVGujZGau+khmtCe1AiRodQA@mail.gmail.com>
In-Reply-To: <CAFgQCTtLm-JXRyQfKo6-+P00SShVGujZGau+khmtCe1AiRodQA@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 29 Sep 2022 16:20:56 +0800
Message-ID: <CAFgQCTu-oyFMQOSGc=9q_ni=hJQ87oxM0AAU1joftkX36t9ejw@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent offlining
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 29, 2022 at 4:19 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
[...]
> "
>
> I have no idea whether this is related to the reverted commit.
>

I have started another test against clean v6.0-rc7 to see whether this
is an issue with the mainline.
